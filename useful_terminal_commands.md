<!-- print any duplicates in a pd dataframe -->
print(db_results_with_match_key[db_results_with_match_key.duplicated(subset=['key'], keep=False)])

<!-- find specific line in a dataframe -->
dataframe_name.loc[dataframe_name['campaign_name']=='Storm @ Dream Know Before You Go - 7.3.22']


