import pandas as pd
import re


df1 = pd.read_csv('~/Documents/recon Docs/mp_mlse/argos/argos-A240609.csv')
df2 = pd.read_csv('~/Documents/recon Docs/mp_mlse/argos/C24_Argos_Data_CDP_Validation.csv')

# sort the dfs
df_datastore = df1.sort_values(by=['section_name', 'row_name', 'seat_num'])
df_mlse = df2.sort_values(by=['section_name', 'row_name', 'seat_num'])

def update_product_type (price_code: str):
    for key, product_type in product_types.items():
        if re.match(key, price_code.lower()):
            return product_type
    

    return "Unknown"

product_types = {
    r'^.[rtn]': "Full Season",
    r'^.p': "Partial Plan",
    r'^.h': "Half season",
    r'^.m': "Mini Plan",
    r'^.f': "Flex Plan",
    r'^.[x*v]': "Individual",
    r'^.g': "Group",
    r'^[8sy]': "Suite"
}


df_mlse['stlr_product'] = df_mlse['price_code'].apply(update_product_type)


# # groups_datastore = df_datastore.groupby(['section_name', 'stlr_product', 'row_name', 'seat_num']).size().reset_index(name='total_seats')
# groups_mlse = df_mlse.groupby(['section_name', 'stlr_product'])['sum_of_num_seats'].sum().reset_index(name='total_seats')

# # groups_datastore.to_csv('~/Documents/recon Docs/mp_mlse/argos/datastore_section_sums.csv', index=True)
# groups_mlse.to_csv('~/Documents/recon Docs/mp_mlse/argos/mlse_section_sums.csv', index=True)