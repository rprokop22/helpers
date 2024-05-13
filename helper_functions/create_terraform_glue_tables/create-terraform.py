# MAKE SURE TO RUN A terraform fmt -recursive after running this file
#  Also, update the output file and the list of files you wish to create

import pandas as pd
from typing import List, Dict, Any
import re

def check_num_scale (scale):
    if scale > 2 :
        num_type = "double"
    else: 
        num_type = "bigint"

    return num_type

data_types = {
    "TEXT": "string",
    "FLOAT": "float",
    "DATE": "date",
    "TIMESTAMP_NTZ": "timestamp",
}

# This is used for the nhl_can_appnd tables
# columns_interested_in = r"(^AGE_)|(_AGE)|(_AGE_)|MALES|FEMALES|GENDER|EDUCATION|OCCUPATION|OCCUPS|WORK_TYPE|CHLDRN|CHILDREN_(ONE|TWO|THREE)|^CONSUMER_CHILDREN$|LONE_PARENT|INCOME|CONSUMER_MARITAL_STATUS|COMMON_LAW|MARRIED|DIVORCED|WIDOW|CPLE_FAM|MULTI_ETHNIC|MULT_RACE|CONSUMER_RACE|RUSTIC_HERITAGE|_ID|GEO_SUMMARY|CODE"

# exclude_columns_with = r"EXPCT_TO_HAPPEN|TUITION|HAPPENED_PST_YR|TAKEN_STEP|PST_YR|PAST_YR|NXT_YR|NEXT_YR|PST_MTH|PAST_MTH|NEXT_MTH|(^SHOP_)|MST_OFT|AGED|AGENT|AGENCIES|EXPNDTRS|TEXTBOOKS|SCHOOL_SUPPLIES|(^POP_)|(_POP)|(_POP_)"


# usa appends - columns wanted
# columns_interested_in = r"blade_id|mover_age|consumer_zip_code_4|consumer_zip_code|consumer_young_adult_in_household|consumer_v_income|consumer_v_home_value|consumer_state|consumer_residental_properties_owned|consumer_race|consumer_occupation_code|consumer_occupation|consumer_num_of_children|consumer_num_of_adults|consumer_num_in_household|consumer_net_worth|consumer_marital_status|consumer_language|consumer_income|consumer_home_owner|consumer_gender|consumer_estimatedincomecode|consumer_age|consumer_hh_id|consumer_hh_ad|consumer_child_7_to_9_years_old|consumer_child_4_tp_6_years_old|consumer_child_13_to_18_years_old|consumer_child_10_to_12_years_old|consumer_child_0_to_3_years_old|consumer_childrens_age_16_17|consumer_date_of_birth_year_yyyy|consumer_date_of_birth_month_mm|create_datetime|update_datetime"

#    here are the subjects that we are interested in
    # "Age"
    # "Gender"
    # "Education"
    # "Occupation"
    # "Children in Household"
    # "Income"
    # "Marital Status"
    # "Ethnicity" 



def generate_columns (csv_path: str, table_name: str, data_types: Dict[str, Any]) -> List:
    columns_list = []
    df = pd.read_csv(csv_path)

    filtered_df = df[df['table_mapping'] == table_name]

    for _, row in filtered_df.iterrows(): 
        # if not re.search(columns_interested_in, row["target_column"], re.IGNORECASE) or re.search(exclude_columns_with, row["target_column"]):
        #     continue
        # else:
            # if row["DATA_TYPE"] == "NUMBER":
            #     type = check_num_scale(row["NUMERIC_SCALE"])
            # else: 
            #     type = row["DATA_TYPE"]
        # name = row["target_column"]
        type = row["data_type"]
        name = row["target_column"]
        

        column_entry = f'\n        columns {{\n                name = "{name}"\n                type = "{type}"\n            }}'
        columns_list.append(column_entry)
    
    return "\n".join(columns_list)
    
    
def generate_tf (csv_path: str, destination_folder: str, parent_folder_name: str, table_names: List[str], data_types: Dict[str, Any], type):
    for table_name in table_names:
        columns_generated = generate_columns(csv_path, table_name, data_types)

        if len(columns_generated) <= 0:
            continue
        else:   
            final_terraform = f"""resource "aws_glue_catalog_table" "{table_name.lower()}" {{
    name          = "{parent_folder_name}_{type}_{table_name.lower()}"
    database_name = var.database

    table_type = "EXTERNAL_TABLE"

    parameters = {{
        external           = "TRUE"
        classification     = "parquet"
        compression        = "none"
        has_encrypted_data = "false"
    }}

    storage_descriptor {{
        location      = "s3://${{var.bucket}}/raw/{parent_folder_name}/{type}/{table_name.lower()}/"
        input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
        output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

        ser_de_info {{
            serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
        }} 

        {columns_generated}



        partition_keys {{
            name = "ingestion_property"
            type = "string"
        }}

        partition_keys {{
            name = "ingestion_datetime"
            type = "timestamp"
        }}
    }}
}}
"""
            
            output_file = f'{destination_folder}{table_name.lower()}.tf'
            with open(output_file, "w") as file:
                file.write(final_terraform)


if __name__ == "__main__":
    # full path to the csv file that you are importing the data from
    csv_path = "<<CHANGEME -- xyz.csv>>"

    # name of the parent folder of where the terraform files will live, for example:
        # in the integrations-ingestions folder -> infrastructure -> nhl_league_blade -> dev -> terraform files. In this case, we want the nhl_league_blade 
    parent_folder_name = "<<CHANGEME -- Parent folder of where the final terraform will be held>>"

    type = "<<CHANGEME>>"

    destination_folder = f"../../../integrations-ingestions/infrastructure/nhl_league_blade/{type}/dev/"
    # destination_folder = "<<CHANGEME -- where you want the terraform to be outputted>>"
    table_names = [
        # "<<CHANGEME -- ADD YOUR LIST OF TABLES HERE!>>"

	"fanatics_bounces",
    "fanatics_clicks",
    "fanatics_opens",
    "fanatics_sents",
    "iterable_responses"
        
    ]
    generate_tf(csv_path, destination_folder, parent_folder_name, table_names, data_types, type)