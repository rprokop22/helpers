import pandas as pd
source_file_path = '/Users/robbieprokop/Documents/validation/echl_idahosteelheads/seats_sold.csv'
outpath = '/Users/robbieprokop/Documents/validation/echl_idahosteelheads/'
df = pd.read_csv(source_file_path)

unique_df = pd.DataFrame(df['acct_id'].unique(), columns=['acct_id'])


events = df['event_name'].unique()
print("unique events:", events)


for event_name in events:
    filtered_df = df[df['event_name'] == event_name]
    unique_acct_ids = filtered_df['acct_id'].nunique()

    print(f'Number of Unique accounts for {event_name}', unique_acct_ids)



athena_file_path = '/Users/robbieprokop/Downloads/steelheads.csv'

athena_df = pd.read_csv(athena_file_path)

missing_accounts = athena_df[~athena_df['account_id'].isin(unique_df['acct_id'])]

print(missing_accounts)
breakpoint()
with pd.ExcelWriter(f'{outpath}/missing_accounts.xlsx', engine="xlsxwriter") as writer:

    missing_accounts.to_excel(writer, index=True)
    print('file created successfully')