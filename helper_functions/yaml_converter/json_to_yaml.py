import os
from ruamel.yaml import YAML
from ruamel.yaml.scalarstring import PreservedScalarString
import json


# replace all the \n and \t in the sql queries
def replace (value):
    # make sure the value is a string before performing the replace 
    if isinstance(value, str):
        new_value = value.replace("\\t", "    ").replace("\\n","\n")
        return PreservedScalarString(new_value)
    return value

# use recursion to drill down the dictionaries until we reach a string value.
def recursively_replace(data):
    if isinstance(data, dict):
        return {k:recursively_replace(v) for k,v in data.items()}
    elif isinstance(data, list):
        return [recursively_replace(v) for v in data]
    else:
        return replace(data)


def convert (directory: str):
    # instantiate the ryaml
    ryaml = YAML()
    # set formatting for the yaml file
    ryaml.default_flow_style = False
    ryaml.indent(sequence=4, offset=2)
    ryaml.width = 80
    ryaml.preserve_quotes = True

    for root, _, files in os.walk(directory):
        for file in files:
            if(file == "dbt.json"):
                filepath = os.path.join(root, file)
                # read the dbt.json file while also getting ready to write to a new yaml file
                with open (filepath, "r") as f, open (filepath.replace(".json", ".yaml"), 'w') as yaml_filepath:
                    json_data = json.load(f)
                    replaced = recursively_replace(json_data)
                    ryaml.dump(replaced, yaml_filepath)

                


if __name__ == "__main__":
    # update this directory path to the proper relative path that you need (based on where you have placed this file and where the client config dek is)
    # directory = "../../../client-config-dek/organizations/development/mp_mlse"
    directory = "./"
    convert(directory)