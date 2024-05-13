import json

def main(dbt_location: str, output: str):

    with open(dbt_location, 'r') as file:
        contents = json.load(file)
        datastore = contents['datastore']
        
        for datastore_name, datastore_info in datastore.items():
            with open (output, 'a') as f:
                f.write(f'{datastore_name}:\n\n')
            for item_name, item_query in datastore_info['bi_columns'].items():
                print(item_name)

                with open (output, 'a') as f:
                    data = f"{item_name}: \n\n{item_query} \n\n"
                    f.write(data)

            


if __name__ == "__main__":
    # update the team name, the dbt_location, and the output destination
    team_name = "mp_mlse"
    dbt_location = f"../../../client-config-dek/organizations/production/{team_name}/dbt.json"
    output = f"../../dbt_mappings/{team_name}_mapping.sql"
    main(dbt_location, output)



    # extract to source system's framework in integrations framework 