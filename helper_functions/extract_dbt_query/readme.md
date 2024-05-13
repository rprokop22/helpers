# DBT json query extract


- read dbt jason
- extract the keys
- output the values in a readable form


- take in a team name as an env variable
- find the dbt.json file in that team's directory
- iterate through the datastore fields
- iterate through the bi-columns of each field
- extract the values (queries)
- replace the \n with 'enter'
- replace \t with '    '
- output all to a new file names '{{teamname}}_mapping_{{date}}.sql'
- if the path.exists (file already exists), update the file, otherwise create a new one
