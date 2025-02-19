import json
import urllib.parse
import sys

import boto3
import botocore
import loguru
import orjson

from awsglue.utils import getResolvedOptions
from awsglue.context import GlueContext
from awsglue.job import Job
from loguru import logger
from pyspark import SparkContext
import backoff
from pyspark.sql.functions import col, struct, to_json

# Initialize Spark
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# Set the config to handle legacy dates
spark.conf.set("spark.sql.parquet.datetimeRebaseModeInWrite", "CORRECTED")

required_args = ["kernel_bucket", "env"]

args = getResolvedOptions(sys.argv, required_args)
kernel_bucket = args["kernel_bucket"]
env = args.get("env", "dev")

# Initialize Glue job
JOB_NAME = "kernel-migration"
job = Job(glueContext)
job.init(JOB_NAME, args)


# Configs
def get_migration_config(kernel_bucket: str, type: str, source_system: str = None):
    s3 = boto3.client("s3")
    match type:
        case "config":
            try:
                config_key = f"migration/config.json"
                response = s3.get_object(Bucket=kernel_bucket, Key=config_key)
                json_content = response["Body"].read().decode("utf-8")
                config = json.loads(json_content)
                return config
            except Exception as e:
                message = f"Failed to get migration config key {config_key}:" + str(e)
                logger.error(message)
                raise Exception(message)

        case "column_mappings":
            try:
                config_key = f"migration/column_mappings/{source_system}.json"
                response = s3.get_object(Bucket=kernel_bucket, Key=config_key)
                json_content = response["Body"].read().decode("utf-8")
                config = json.loads(json_content)
                logger.info("Found source system column mappings")
                return config
            except json.JSONDecodeError as e:
                logger.error(f"Failed to parse json: {e}")
            except Exception as e:
                logger.info("No source system column mappings found")
                return {}


try:
    customer_configs = get_migration_config(kernel_bucket, "config")["customer"]
    organization = customer_configs["organization"]
    ingestion_property = customer_configs["property"]
    customer_db = customer_configs["customer_db"]
    bucket = f"stellaralgo-{env}-use1-{organization.replace('_', '-')}"
except KeyError as e:
    raise Exception(f"{e} missing from required params")


# Logging
def serialize(record):
    extra = record["extra"]
    extra["severity"] = record["level"].name

    subset = {"message": record["message"]}
    subset.update(extra)

    return str(orjson.dumps(subset), "utf-8")


def formatter(record):
    record["extra"]["serialized"] = serialize(record)
    return "{extra[serialized]}\n"


def setup_logger(
    cust_id: str, property: str, department: str, app: str, default_level: str = "INFO"
) -> loguru.logger:
    extra = dict(
        customer=cust_id, property=property, department=department, application=app
    )
    handlers = [
        dict(sink=sys.stdout, format=formatter, level=default_level, enqueue=True)
    ]
    logger.configure(handlers=handlers, extra=extra)
    return logger


logger = setup_logger(
    cust_id=organization,
    property=ingestion_property,
    department="data-enginerring",
    app=JOB_NAME,
)

logger.info("Starting GLUE JOB WITH ARGS:" + str(args))


def get_ssm_param(name: str) -> str:
    ssm_client = boto3.client("ssm")
    response = ssm_client.get_parameter(Name=name, WithDecryption=True)

    return response["Parameter"]["Value"]


def load_etl_table(connection_options, customer_db):
    logger.info(f"STEP 1 LOADING ETL LOADS TABLE")

    # Load SQL Server etlLoads table into spark dataFrame
    try:
        raw_df = glueContext.create_dynamic_frame.from_options(
            connection_type="sqlserver",
            connection_options=connection_options,
            transformation_ctx="source_etl_df",
        ).toDF()

        # Register the dataframe as a temporary table
        raw_df.createOrReplaceTempView("source_etl_df")

    except Exception as e:
        message = "STEP 1 FAILED TO LOAD ETL LOADS TABLE" + str(e)
        logger.error(message)
        raise Exception(message)

    query = f"""
         SELECT 
             loadid, 
             date_trunc('second', min(insertDateUtc)) as ingestion_datetime
        FROM source_etl_df
        WHERE lower(databaseName) = lower('{customer_db}')  
        GROUP BY loadid
        """

    df = spark.sql(query)
    df.createOrReplaceTempView("etl")
    logger.info(f"STEP 1 SUCCEED TO LOAD ETL LOADS TABLE ROW COUNT: {df.count()}")


def load_customer_table(connection_options, table):
    logger.info(f"STEP 2 LOADING CUSTOMER TABLE {table}")

    # Load SQL Server customer db table into spark dataFrame
    try:
        raw_df = glueContext.create_dynamic_frame.from_options(
            connection_type="sqlserver",
            connection_options=connection_options,
            transformation_ctx=f"{table}_df",
        ).toDF()

        logger.info(
            f"STEP 2 SUCCEED TO LOAD CUSTOMER TABLE {table} ROW COUNT: {raw_df.count()}"
        )

        raw_df.createOrReplaceTempView(table)

    except Exception as e:
        message = f"STEP 2 FAILED TO LOAD CUSTOMER TABLE {table} " + str(e)
        logger.error(message)
        raise Exception(message)

    query = f"""
            SELECT 
                ord.*
                ,"{ingestion_property}" as ingestion_property
                ,etl.ingestion_datetime
            FROM {table} ord
            LEFT JOIN etl
            ON ord.loadId = etl.loadId
     """
    df = spark.sql(query)
    null_count = df.filter(df["ingestion_datetime"].isNull()).count()
    logger.info(f"Validation | Rows cannot be mapped by loadid: {null_count}")
    return df


def transform_columns(df, source_system_mappings, column_mappings):
    if source_system_mappings:
        logger.info("Apply source system column mappings")
        for key, value in source_system_mappings.items():
            if isinstance(value, dict):
                attributes = [col(v).alias(k) for k, v in value.items()]
                df = df.withColumn(key, to_json(struct(*attributes)))
            else:
                df = df.withColumnRenamed(key, value.lower())

    if column_mappings:
        logger.info("Apply client custom column mappings")
        for k, v in column_mappings.items():
            df = df.withColumnRenamed(k, v.lower())
    # transform all column names to lower case
    for c in df.columns:
        df = df.withColumnRenamed(c, c.lower())
    return df


def upload_to_s3(df, source_system, dataset):
    logger.info("STEP 3 UPLOADING PARQUET FILES TO S3")

    try:
        PARTITION_SIZE = 100000
        s3_path = f"s3://{bucket}/tmp/{source_system}/{dataset}/"
        (
            df.repartition("ingestion_property", "ingestion_datetime")
            .write.option("maxRecordsPerFile", PARTITION_SIZE)
            .mode("overwrite")
            .partitionBy("ingestion_property", "ingestion_datetime")
            .parquet(s3_path)
        )

        logger.info("STEP 3 SUCCEED TO UPLOAD PARQUET FILES TO S3")

    except Exception as e:
        message = f"STEP 3 FAILED TO UPLOAD PARQUET FILES TO S3:" + str(e)
        logger.error(message)
        raise Exception(message)


@backoff.on_exception(
    backoff.expo,
    botocore.exceptions.ClientError,
    max_time=60,
    on_backoff=lambda details: logger.info(
        f"Backoff: Delaying for {details['wait']:.1f} seconds"
    ),
)
def copy_objects(bucket, objects):
    s3 = boto3.client("s3")
    for key in objects:
        partition_key = key.split("/")[-2]
        # decode the partition key
        new_partition_key = urllib.parse.unquote(partition_key)
        new_key = key.replace("tmp", "archive")
        new_key = new_key.replace(partition_key, new_partition_key)
        s3.copy_object(
            Bucket=bucket,
            CopySource={"Bucket": bucket, "Key": key},
            Key=new_key,
        )


@backoff.on_exception(
    backoff.expo,
    botocore.exceptions.ClientError,
    max_time=60,
    on_backoff=lambda details: logger.info(
        f"Backoff: Delaying for {details['wait']:.1f} seconds"
    ),
)
def delete_objects(bucket, keys):
    s3 = boto3.client("s3")
    s3.delete_objects(
        Bucket=bucket, Delete={"Objects": [{"Key": obj} for obj in keys], "Quiet": True}
    )


# This function is to modify partition key due to partition key is url-encoded
def move_objects(source_system, dataset):
    logger.info("STEP 4 MOVING S3 OBJECTS FROM TMP TO ARCHIVE")

    try:
        # get the list of objects
        s3 = boto3.client("s3")
        objects = []
        for page in s3.get_paginator("list_objects_v2").paginate(
            Bucket=bucket, Prefix=f"tmp/{source_system}/{dataset}"
        ):
            objects.extend(
                [
                    obj["Key"]
                    for obj in page.get("Contents", [])
                    if obj["Key"].endswith(".parquet")
                ]
            )

        if objects:
            for i in range(0, len(objects), 1000):
                logger.info(f"Moving {i} objects")    
                copy_objects(bucket, objects[i : i + 1000])
                delete_objects(bucket, objects[i : i + 1000])

    except Exception as e:
        message = f"STEP 4 FAILED TO MOVE ALL S3 OBJECTS FROM TMP to ARCHIVE:" + str(e)
        logger.error(message)
        raise Exception(message)


def reset_data(source_system, dataset=None):

    try:
        s3 = boto3.client("s3")
        if dataset:
            logger.info(f"STEP 0 RESET {dataset}")
            for page in s3.get_paginator("list_objects_v2").paginate(
                Bucket=bucket, Prefix=f"archive/{source_system}/{dataset}/ingestion_property={ingestion_property}"
            ):
                for obj in page.get("Contents", []):
                    s3.delete_object(Bucket=bucket, Key=obj["Key"])
        else:

            logger.info("STEP 0 RESET DATA ON TMP")
            for page in s3.get_paginator("list_objects_v2").paginate(
                Bucket=bucket, Prefix=f"tmp/{source_system}"
            ):
                for obj in page.get("Contents", []):
                    s3.delete_object(Bucket=bucket, Key=obj["Key"])

    except Exception as e:
        message = "STEP 0 FAILED TO RESET DATA ON TMP" + str(e)
        logger.error(message)
        raise Exception(message)


def run_migration(
    source_system, table_mappings, source_system_mappings, column_mappings
):

    name = "/kernel/legacy_migration/legacy_staging_mssql"

    # Get specific SSM parameters for db connections
    try:
        db_params = get_ssm_param(name)
        db_params = json.loads(db_params)
        db_host = db_params["host"]
        db_port = db_params["port"]
        db_user = db_params["username"]
        db_password = db_params["password"]

    except Exception as e:
        message = f"There was an issue loading one or more SSM parameters.{e}"
        logger.error(message)
        raise Exception(message)

    # Step 0 - reset data in tmp
    reset_data(source_system)

    # Step 1 - Load ETL meta data and group by loadid
    etl_schema = "staging" if env == "dev" else "log"
    etl_db = customer_db if env == "dev" else "ETLmeta"

    etl_meta_connection_options = {
        "url": f"jdbc:sqlserver://{db_host}:{db_port};databaseName={etl_db}",
        "dbtable": f"{etl_schema}.etlLoads",
        "user": db_user,
        "password": db_password,
    }

    load_etl_table(etl_meta_connection_options, customer_db)

    # Step 2 Load customer tables
    for sql_table, dataset in table_mappings.items():
        # clean up dataset
        reset_data(source_system, dataset)
        customer_db_connection_options = {
            "url": f"jdbc:sqlserver://{db_host}:{db_port};databaseName={customer_db}",
            "dbtable": f"staging.{sql_table}",
            "user": db_user,
            "password": db_password,
        }

        table_df = load_customer_table(customer_db_connection_options, sql_table)
        if table_df.rdd.isEmpty():
            logger.info(f"Skipping empty table {dataset}.")
            continue
        df = transform_columns(
            table_df, source_system_mappings.get(dataset), column_mappings.get(dataset)
        )

        # Step 3 Upload to S3
        logger.info(f"Validation: Migrated {dataset} with {df.count()} rows ")
        upload_to_s3(df, source_system, dataset)

        # Step 4 - Move Objects
        move_objects(source_system, dataset)

    logger.info(f"SUCCEED TO INGEST ALL TABLES FOR {source_system}")


migration_configs = get_migration_config(kernel_bucket, "config")["source_system"]
for source_system in migration_configs:
    run_migration(
        source_system=source_system,
        table_mappings=migration_configs[source_system]["table_mappings"],
        source_system_mappings=get_migration_config(
            kernel_bucket, "column_mappings", source_system
        ),
        column_mappings=migration_configs[source_system].get("column_mappings"),
    )
logger.info(f"Comppleted all source system migration")
