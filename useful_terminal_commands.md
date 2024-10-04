<!-- print any duplicates in a pd dataframe -->
print(db_results_with_match_key[db_results_with_match_key.duplicated(subset=['key'], keep=False)])

<!-- find specific line in a dataframe -->
dataframe_name.loc[dataframe_name['campaign_name']=='Storm @ Dream Know Before You Go - 7.3.22']


<!-- search in a dataframe if a certain date exists -->
print(source_data.loc[source_data['Send Date'].dt.date == pd.to_datetime('2016-06-30').date()])