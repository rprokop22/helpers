import pandas as pd


# file_path = '/Users/robbie/Documents/validation/nba_mavericks/aug-2024-docs-drop/December-2021-Attendance.xlsx'
# file_path = '/Users/robbie/Documents/validation/nba_mavericks/aug-2024-docs-drop/December-2021_5_games.xlsx'
# file_path = '/Users/robbie/Documents/validation/nba_mavericks/aug-2024-docs-drop/December-2022_5_games.xlsx'

file_path = '/Users/robbie/Documents/validation/nba_mavericks/aug-2024-docs-drop/December-2022-Attendance.xlsx'
sheet_name = 'temp'

df = pd.read_excel(file_path, sheet_name=sheet_name)

# events = ['DM211203','DM211204','DM211207','DM211213','DM211215']
events = ['DM221205','DM221209','DM221212','DM221214','DM221216']


for event_name in events:
    filtered_df = df[df['event_name'] == event_name]
    unique_acct_ids = filtered_df['acct_id'].nunique()

    print(f'Unique accounts for {event_name}', unique_acct_ids)
