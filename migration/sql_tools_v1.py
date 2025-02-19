import os
import json
import sys
import boto3
import awswrangler as wr
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv


def try_sql_connection(connection):
    """
    Test connection to legacy sql server, checks if the credentials are correctly setup
    """
    try:
        with connection.connect() as connection:
            print("Connected to SQL Server successfully.")
            return True
    except Exception as e:
        print(f"Error connecting to SQL Server: {e}")
        return False


def get_glue_table_schemas(database_name: str, source: str) -> dict:
    """
    database_name: name of the database in kernel, using the integrations_iceberg_{team_name} database
    source: name of the source system, ticketmaster, tdc, ...
    """
    tables = wr.catalog.get_tables(database="integrations_iceberg_" + database_name)
    schemas = {
        table["Name"]: [
            col
            for col in table["StorageDescriptor"]["Columns"]
            if col["Name"] not in ["ingestion_property", "ingestion_datetime"]
        ]
        for table in tables
        if source in table["Name"]
    }
    return schemas


def build_validation_query(source: str, mappings_dict: dict, skipped_columns=[]) -> str:
    """
    database_name: name of the database to query schema from in kernel
    source: source system for which we want to get the tables for
    return: the string query to be run on SQL server which checks for invalid data types
    """
    database_name = mappings_dict["customer"]["organization"]
    schemas = get_glue_table_schemas(database_name=database_name, source=source)
    config_inverted = {
        value: key
        for key, value in mappings_dict["source_system"][source][
            "table_mappings"
        ].items()
    }
    query = ""

    # Get filtered table list first
    valid_tables = [
        (name, schema)
        for name, schema in schemas.items()
        if source in name and name.replace(source + "_", "") in config_inverted.keys()
    ]

    for i, (table_name, schema) in enumerate(valid_tables):
        table_name_legacy = config_inverted[table_name.replace(source + "_", "")]
        if table_name_legacy != "":
            query = (
                query
                + f"select distinct concat('{table_name_legacy}: ', invalid_type) as invalid_columns\nfrom\n(select case"
            )
            for column in schema:
                column_name_legacy = snake_to_camel(column["Name"])
                if column_name_legacy.lower() not in skipped_columns:
                    if column["Type"] == "string" or column["Type"] == "boolean":
                        column["Type"] = "varchar"
                    elif column["Type"] == "double":
                        column["Type"] = "float"
                    elif column["Type"] == "timestamp":
                        column["Type"] = "datetime2"
                    query = (
                        query
                        + f"\nwhen [{column_name_legacy}] is not null and try_cast([{column_name_legacy}] as {column['Type']}) is null then '{column_name_legacy}'"
                    )
            query = (
                query
                + f"end as invalid_type\nfrom staging.[{table_name_legacy}]) a\nwhere invalid_type is not null"
            )

            # Only add union all if not the last item
            if i < len(valid_tables) - 1:
                query = query + "\n\nunion all\n"
    return query


def run_sql_query(query: str, connection: object):
    """
    query: a SQL server query as a string
    return: a dataframe, result of the query
    """
    try:
        with connection.connect() as connection_object:
            result = pd.read_sql(query, connection_object)
            return result
    except Exception as e:
        print(f"Failed to run query:\n{e}")


# also useful for checking if a table is present in the legacy database that we want to migrate
def get_missing_columns(sql_config: dict, source: str, connection) -> dict:
    """
    Returns a dict with legacy table name as key and list of columns not found in legacy tables
    """
    missing_columns = {}
    config_inverted = {
        value: key
        for key, value in sql_config["source_system"][source]["table_mappings"].items()
    }
    schemas = get_glue_table_schemas(
        database_name=sql_config["customer"]["organization"], source=source
    )

    for table_name, schema in schemas.items():
        # Skip if not a relevant table
        if source not in table_name:
            continue

        # Get legacy table name
        kernel_table = table_name.replace(source + "_", "")
        if kernel_table not in config_inverted:
            continue

        legacy_table = config_inverted[kernel_table]
        if not legacy_table:
            continue

        # Get legacy columns
        legacy_query = f"""
            SELECT COLUMN_NAME 
            FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_SCHEMA = 'staging' 
            AND TABLE_NAME = '{legacy_table}'
        """
        legacy_df = pd.read_sql(legacy_query, connection)
        legacy_columns = set(legacy_df["COLUMN_NAME"].str.lower())

        # Get kernel columns
        kernel_columns = {col["Name"].replace("_", "").lower() for col in schema}

        # Find missing columns
        missing = kernel_columns - legacy_columns
        if missing:
            missing_columns[legacy_table] = list(missing)
    return missing_columns


# Very slow function, needs a refactor to use a single query to get all counts rather then a query for each table
def row_count_report(sql_config, connection, source):
    """
    checks table counts on kernel vs legacy
    """
    count_dict_legacy = {}
    mappings = sql_config["source_system"][source]["table_mappings"]
    tables_leagacy = list(mappings.keys())
    for table in tables_leagacy:
        query = f"select count(*) as count from staging.[{table}]"
        try:  # pass a connection object rather then create new connection
            df = pd.read_sql(query, connection)
            count_dict_legacy[table] = int(df["count"].iloc[0])
        except Exception as e:
            print(f"Error getting count for legacy table {table}: {e}")

    tables_kernel = list(mappings.values())
    count_dict_kernel = {}
    for table in tables_kernel:
        try:
            # Get count from Athena {sql_config['customer']['organization']}
            query = f"select count(*) as count from integrations_iceberg_{sql_config['customer']['organization']}.{source+'_'+table} where ingestion_property='{sql_config['customer']['property']}'"
            df = wr.athena.read_sql_query(
                sql=query,
                database="integrations_iceberg_"
                + sql_config["customer"]["organization"],
                ctas_approach=False,
            )
            count_dict_kernel[table] = int(df["count"].iloc[0])
        except Exception as e:
            print(f"Error getting count for kernel table {table}: {e}")
            count_dict_kernel[table] = None

    return {"legacy": count_dict_legacy, "kernel": count_dict_kernel}


def build_loadid_validation_query(sql_config, source):
    database_name = sql_config["customer"]["customer_db"]
    table_mappings = sql_config["source_system"][source]["table_mappings"]
    query = ""
    tables = list(table_mappings.keys())
    for i, table in enumerate(tables):
        query += f"""select distinct loadid, '{table}' as table_name
                        from staging.[{table}]
                        where loadid not in (
                        select distinct loadid from ETLmeta.log.etlloads 
                        where databasename like '{database_name}'
                        and tablename like '%{table}%'
                    )"""
        if i < len(tables) - 1:
            query += " UNION ALL\n"

    return query


def get_sftp_time(team_name: str):
    pass


#todo: fill in the customer_db and property fields
def generate_sql_config(source, database_name):
    """
    Creates a starting point for migration, legacy tables names maybe incorrect
    Revisit the table names on sql server
    """
    schemas = get_glue_table_schemas(database_name, source)
    mappings = {}
    config = {}
    for table_name, schema in schemas.items():
        # remove source from table_name
        table_name = table_name.replace(source + "_", "")
        renamed_table = snake_to_camel(table_name)
        if renamed_table[-1] == "s":
            renamed_table = renamed_table[:-1]
        mappings[renamed_table] = table_name

    config["source_system"] = {
        source: {"table_mappings": mappings, "column_mappings": {}}
    }
    config["customer"] = {
        "organization": database_name,
        "customer_db": "",
        "property": "",
    }
    config["$schema"] = "../schemas/config_schema.json"

    return config

def validate_sql_config(config: dict):
    '''
    validate the table names in a newly generated sql config
    also check if any of those table are empty
    '''
    pass

def fix_improper_tables(config: dict):
    '''
    if any problematic tables exist in the premigration checks, fix them here
    '''
    pass


def get_sql_config(use_local=False) -> dict:
    """
    Load SQL config from S3 using AWS Wrangler
    """
    if use_local:
        with open("production.json", "r") as f:
            sql_config = json.load(f)
            return sql_config
    try:
        # Read JSON file directly from S3
        sql_config = wr.s3.read_json(
            path="s3://kernel-data-engineering/migration/config.json"
        )
        return sql_config.to_dict()
    except Exception as e:
        print(f"Error loading SQL config: {e}")
        return None


def snake_to_camel(snake_str):
    """
    snake_case to camelCase
    """
    components = snake_str.split("_")
    return components[0] + "".join(x.capitalize() for x in components[1:])


def build_premigration_report(sql_config: dict, source: str, connection: object):
    """
    Builds a report for the migration
    """
    # Step 0: check sql connection
    if not try_sql_connection(connection):
        print("Error connecting to SQL Server. Exiting...")
        return

    # step 1: check for missing tables or columns
    print(
        f"Building pre-migration report for the kernel team {sql_config['customer']['organization']} and Legacy team {sql_config['customer']['customer_db']}"
    )
    print("Source system:", source, "\n")
    print("Checking for missing tables or columns on legacy...")
    missing_columns = get_missing_columns(sql_config, source, connection=connection)
    if not missing_columns:
        print(
            "No missing columns or tables found.\nContinuing with data type checking...\n"
        )
    else:
        print("Missing columns found:", missing_columns)
        print(
            "Continuing with the migration will cause the missing column to be skipped."
        )
        print("Skipping missing columns for data type checking\n")
    # step 2: check for data type mismatches
    print("Checking for data type mismatches on legacy...")
    missing_cols_list = []
    for value in missing_columns.values():
        missing_cols_list.extend(value)
    query = build_validation_query(
        mappings_dict=sql_config, source=source, skipped_columns=missing_cols_list
    )
    with open("data-validation-query.sql", "w") as f:
        f.write(query)
    df = run_sql_query(query=query, connection=connection)
    if df.empty:
        print("No data type mismatches found.\n")
    else:
        print("Data type mismatches found:")
        print(df)
        print(
            "The second step of the migration will fail if these data type mismatches are not resolved.\n"
        )
    # step 3: check for missing loadids on legacy
    print("Checking for missing loadids on legacy...")
    print("Disclaimer: This step assumes the table names in your SQL db are the same in ETLMeta.log.etlloads table")
    query = build_loadid_validation_query(sql_config, source)
    with open("loadid-validation-query.sql", "w") as f:
        f.write(query)
    df = run_sql_query(query=query, connection=connection)
    if df.empty:
        print("No missing loadids found.\n")
    else:
        print("Missing loadids found:")
        print(df)
        print("")
        print(
            "Reccomendation: Add missing loadids to the ETLmeta.log.etlloads table.\n"
        )
        df.to_csv("missing_loadids.csv")
        print("Saved missing IDS to a local csv")

    print("Pre-migration report complete.")


def build_postmigration_report(sql_config: dict, source: str, connection: object):
    """
    Builds a report for the migration
    """
    # Step 0: check sql connection
    if not try_sql_connection(connection):
        print("Error connecting to SQL Server. Exiting...")
        return
    # step 1: check for row count mismatches
    print(
        f"Building post-migration report for the kernel team {sql_config['customer']['organization']} and Legacy team {sql_config['customer']['customer_db']}"
    )
    print("Source system:", source, "\n")
    print("Row count comparision between kernel and legacy:\n")
    rowcount_report = row_count_report(sql_config, connection, source)
    df = pd.DataFrame(
        {
            "Table Name": rowcount_report["kernel"].keys(),
            "Legacy Row Counts": rowcount_report["legacy"].values(),
            "Kernel Row Counts": rowcount_report["kernel"].values(),
        }
    )
    df["% Difference"] = round(
        df["Kernel Row Counts"] / df["Legacy Row Counts"] * 100, 2
    )
    df = df.fillna(100.00)
    print(df)

    print("Checking for mismatched tables...\n")
    anonmalies_df = df[(df["% Difference"] > 105) | (df["% Difference"] < 95)]
    anonmalies_df
    if anonmalies_df.empty:
        print("All tables are under +/- 5% threshold!.\n")
    else:
        print("Mismatched tables greater then +/- 5% threshold:\n")
        print(anonmalies_df)
        print("")
        print(
            "Reccomendation: Investigate the mismatched tables and resolve the issue of data loss or data increase.\n"
        )


def initialize_connection(load_env=False):
    """
    Initialize a connection to the SQL server
    """
    if load_env:
        load_dotenv()
    DB_HOST = os.getenv("SQL_DB_SERVER")
    DB_USER = os.getenv("SQL_DB_USER")
    DB_PASSWORD = os.getenv("SQL_DB_PASSWORD")
    DB_NAME = os.getenv("SQL_DB_NAME")
    
    if not DB_HOST or not DB_USER or not DB_PASSWORD or not DB_NAME:
        if load_env: raise ValueError("SQL server credentials are not set properly in your .env file")
        else: raise ValueError("SQL server credentials are not exported properly in your shell")
    
    # Create a connection string
    connection_string = f"mssql+pyodbc://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}?driver=ODBC+Driver+18+for+SQL+Server&TrustServerCertificate=yes"


    engine = create_engine(connection_string)

    return engine

if __name__ == "__main__":

    engine = initialize_connection(load_env=True)

    if sys.argv[1] == 'local_config':
        sql_config = get_sql_config(use_local=True)
    elif sys.argv[1] == 's3_config':
        sql_config = get_sql_config(use_local=False)
        print(sql_config)
    elif sys.argv[1] == 'generate_config':
        sql_config = generate_sql_config(sys.argv[3], sys.argv[2])
        with open('production.json', 'w') as f:
            json.dump(sql_config, f)
        sys.exit(1)
    else:
        print("Invalid argument. Please provide either 'local_config' or 's3_config' as the first argument.")
        sys.exit(1)
    
    if sys.argv[2] == 'pre_migration':
        build_premigration_report(sql_config=sql_config, source=sys.argv[3], connection=engine)
    elif sys.argv[2] == 'post_migration':
        build_postmigration_report(sql_config=sql_config, source=sys.argv[3], connection=engine)
    else:  
        print("Invalid argument. Please provide either 'pre_migration' or 'post_migration' as the second argument and specify sourcesystem as third arguement.")
        sys.exit(1)

