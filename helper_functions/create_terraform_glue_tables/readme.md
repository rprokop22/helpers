# This create-terraform.py Script is used to generate the Terraform glue catalog tables


### Use this file to auto generate the glue catalog tables. All you need is a list of tables to create (usually found in the SOW), a destination folder, and a csv.

### Required materials
- csv file with the data


## Steps

1. get list of table names from the SOW or csv
2. get the name of the destination folder
3. at the bottom of the create-terraform.py script, update the csv_path, folder_name of the parent folder, and the list of table_names (which should be found in the SOW)
4. run the script
5. run 
    ```sh
    terraform fmt -recursive
    ```
6. Go work on something more productive now


Confluence page with similar details
https://stellaralgo.atlassian.net/wiki/spaces/DE/pages/2960588805/create-terraform.py+Tool+for+creating+glue+data+catalogs