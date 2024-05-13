# from pathlib import Path
# import re
from typing import List, Dict, Any
# import json

# def transform_column_names(column_names: List) -> str:
#     updated_column_names = []
#     for name in column_names:
#         updated_column_names.append(f"{name.upper()} as {name}")
    
#     return "\n    , ".join(updated_column_names)

# def generate_table_block(table_name: str, column_names: List, with_column_name: str) -> dict:
#      return {
#      table_name: {
#         "query": f"SELECT\n    {column_names}\nFROM {{database}}.{{schema}}.{{table}}",
#         "filter_required": False,
#         "table": table_name.upper(),
#         "date_field": with_column_name
#     }

# }


# def main(directory: str, with_column_name, json_path):

#     # read json file
#     with open (json_path, "r") as f:
#         data = json.load(f)

#     # fun little regex to check for the 
#             # columns {
#             #     name = "xyz"
#             # }
#     # pattern in the terraform files. this gets used to save all the names later on
#     column_pattern = re.compile(r'columns\s*\{\s*name\s*=\s*"([^"]+)"')

#     directory_path = Path(directory)
#     for file in directory_path.glob("*.tf"):
#         has_required_column = False
#         # get only the file name, not the path to the file
#         relative_path = file.relative_to(directory)
#         # remove .tf file extension
#         table_name = relative_path.stem
#         column_names = []
#         with open (file, 'r') as f: 
#             file_content = f.read()
#             if with_column_name in file_content:
#                 has_required_column = True
#                 matches = column_pattern.findall(file_content)
#                 column_names.extend(matches)
#         updated_names = transform_column_names(column_names)

#         if has_required_column:
#             # generate new block
#             new_table_block = generate_table_block(table_name, updated_names, with_column_name)

#             #  update json file with new block
#             data["nhl_league_blade"].update(new_table_block)

#             with open (json_path, "w") as f:
#                 json.dump(data, f, indent=4)

#         has_required_column = False


import pandas as pd
import json


def generate_table_block(snowflake_table_name: str, table_name: str, column_names: List) -> dict:
     return {
     table_name: {
        "query": f"SELECT\n    {column_names}\nFROM {{database}}.{{schema}}.{{table}}",
        "filter_required": False,
        "table": snowflake_table_name.upper(),
        "date_field": "updt_dtm"
    }

}

# def generate_columns (csv_path: str, table_name: str) -> List:
#     columns_list = []
#     df = pd.read_csv(csv_path)

#     filtered_df = df[df['snowflake_table'] == table_name]
#     for _, row in filtered_df.iterrows():
#         columns_list.append(f"{row["snowflake_column"].upper()} as {row["target_column"]}")
#     return "\n    , ".join(columns_list)


# def transform_column_names(column_names: Dict[List, Any]) -> str:
#     updated_column_names = []

#     for name in column_names:
#         updated_column_names.append(f"{name.upper()} as {name}")
    
#     return "\n    , ".join(updated_column_names)
 
def main (
        csv_path: str, 
        table_names: List, 
        directory: str,
        json_path
        ): 
    
    # read json file
    with open (json_path, "r") as f:
        data = json.load(f)
    
    
    for table_name in table_names:

        columns_list = []
        df = pd.read_csv(csv_path)


        filtered_df = df[df['snowflake_table'] == table_name]
        for _, row in filtered_df.iterrows():
            updated_table_name = row["table_mapping"]
            columns_list.append(f"{row["snowflake_column"].upper()} as {row["target_column"]}")
        columns = "\n    , ".join(columns_list)
        # columns = generate_columns(csv_path, table_name)
        # print(table_name)
        # print(json.dumps(columns,indent=2))
        
        
        new_block = generate_table_block(table_name, updated_table_name, columns)
 #  update json file with new block
        data["nhl_league_blade"].update(new_block)
    
        with open (json_path, "w") as f:
            json.dump(data, f, indent=4)





if __name__ == "__main__":
    # with_column_name = "update_datetime"
    type = 'customers'
    directory = f'../../../integrations-ingestions/infrastructure/nhl_league_blade/dev/{type}'
    csv_path = "~/Documents/nhl-setup/nhl_table_column_mapping_clean.csv"
    json_path = "../../../integrations-ingestions/ingestions/mappings/incremental/snowflake/nhl_league_blade.json"
    # json_path = "./"

    table_names = [

    # "v_gm_fan_mstr_hist",
    # "v_dw_fan_mstr_hist",
    # "v_gm_fan",
    # "v_gm_fan_xref",
    # "v_gm_addr_xref",
    # "v_dw_phone",
    # "v_gm_phone_xref",
    # "v_gm_phone",
    # "v_dw_addr",
    # "v_dw_fan",
    # "v_gm_fan_mstr",
    # "v_gm_addr",
    # "v_dw_orgn",
    # "v_dw_fan_mstr",
    # "v_gm_email_xref",
    # "v_dw_src",
    # "v_dw_email"
    
    "v_nhl_email_iterable_rspns",
    "v_nhl_email_fntcs_bncs",
    "v_nhl_ecomm_fntcs_intl_prdct_plyr",
    "v_nhl_ecomm_prdct",
    "v_nhl_ecomm_ordr_ln",
    "v_nhl_ecomm_fntcs_intl_ordr_ln",
    "v_nhl_ecomm_ordr",
    "v_nhl_email_fntcs_clks",
    "v_nhl_email_fntcs_opn",
    "v_nhl_email_fntcs_sent",
    "v_nhl_ecomm_fntcs_intl_ordr",
    "v_nhl_ecomm_fntcs_intl_prdct_team",
    "v_nhl_ecomm_prdct_team",
    "v_nhl_ecomm_fntcs_intl_prdct",
    
    ]

    main(csv_path, table_names, directory, json_path)
    # "v_nhl_usa_appnd",
# "usa_demographic_appends"

            # "v_gm_fan_mstr_hist",
            # "v_dw_fan_mstr_hist",
            # "v_nhl_ecomm_fntcs_intl_prdct_plyr",
            # "v_gm_fan",
            # "v_gm_fan_mstr_xref",
            # "v_gm_fan_xref",
            # "v_nhl_ecomm_prdct",
            # "v_nhl_email_fntcs_bncs",
            # "v_gm_addr_xref",
            # "v_dw_phone",
            # "v_gm_phone_xref",
            # "v_nhl_email_iterable_rspns",
            # "v_nhl_ecomm_ordr_ln",
            # "v_nhl_ecomm_fntcs_intl_ordr_ln",
            # "v_gm_phone",
            # "v_dw_addr",
            # "v_dw_fan",
            # "v_gm_fan_mstr",
            # "v_gm_addr",
            # "v_dw_orgn",
            # "v_nhl_ecomm_ordr",
            # "v_nhl_usa_appnd",
            # "v_nhl_email_fntcs_clks",
            # "v_nhl_email_fntcs_opn",
            # "v_nhl_email_fntcs_sent",
            # "v_nhl_ecomm_fntcs_intl_ordr",
            # "v_dw_fan_mstr",
            # "v_nhl_ecomm_fntcs_intl_prdct_team",
            # "v_nhl_ecomm_prdct_team",
            # "v_gm_email_xref",
            # "v_nhl_ecomm_fntcs_intl_prdct",
            # "v_dw_src",
            # "v_dw_email"