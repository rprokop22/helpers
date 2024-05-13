import os
import yaml
from typing import List

def read_yaml (file_path):
    try:
        with open (file_path, 'r') as file:
            return yaml.safe_load(file)
    #this is the only error handling for a yaml file that isn't formatted correctly.
    # python can't read improperly formatted yaml.
    except yaml.YAMLError as e:
        print('Failed to parse Yaml file. Please check filepath and potential formatting issues in the yaml file')
        print (f'error: {e}')
        return None
    
def validate_columns(data, section_name, required_columns):
    section_data = data.get('datastore', {}).get(section_name,{}).get('bi_columns', {})

    # check for missing columns 
    missing_columns = [col for col in required_columns if col not in section_data]

    if len(missing_columns) > 0:
        return {section_name: missing_columns}
    else:
        return None


def main(file_destination: str, sources:List):
    column_definitions = {
        "ticketmaster": {
            "ticketmaster_events": [
                'client_property', 
                'stlr_game_number', 
                'stlr_is_renewal', 
                'stlr_season_year'
            ],
            "ticketmaster_tickets": [
                'client_properties', 
                'stlr_product', 
                'stlr_reported_revenue', 
                'stlr_season_year'
            ],
        },
        "ticketreturn": {
            "ticketing_events_ticketreturn": [
                'client_property', 
                'stlr_game_number', 
                'stlr_is_renewal', 
                'stlr_season_year'
            ],
            "ticketing_tickets_ticketreturn": [
                'client_properties', 
                'stlr_product', 
                'stlr_reported_revenue', 
                'stlr_season_year'
            ],
        },
        'constant_contact': {
            "esp_campaigns_constant_contact": ["client_property"],
            "esp_activities_constant_contact": ["client_property","stlr_activity_type"],
            "esp_subscriptions_constant_contact": ["client_property"]
        },
        'hubspot': {
            "esp_campaigns_hubspot": ["client_property"],
            "esp_activities_hubspot": ["client_property","stlr_activity_type"],
            "esp_subscriptions_hubspot": ["client_property"]
        },
        'marketo': {
            'esp_campaigns_marketo': ['client_property'],
            'esp_activities_marketo': ['client_property', 'stlr_activity_type'],
            'esp_subscriptions_marketo': ['client_property']
        },
        'sfmc':{
            'esp_campaigns_sfmc': ['client_property'],
            'esp_activities_sfmc': ['client_property', 'stlr_activity_type'],
            'esp_subscriptions_sfmc': ['client_property']
        },
        'sfsc': {
            'crm_campaigns_sfsc': ['client_property'],
            'crm_touchpoints_sfsc': ['client_property'],
        },
        'seatgeek': {
            "ticketing_events_seatgeek": [
                "client_property",
                "stlr_game_number",
                "stlr_is_renewal",
                "stlr_season_year"
            ],
            "ticketing_tickets_seatgeek": [
                    "client_property",
                    "stlr_product",
                    "stlr_reported_revenue",
                    "stlr_season_year"
            ]
        },
        'shopify': {
            'retail_orders_shopify': ['client_property'],
            'retail_products_shopify': ['client_property']
        },
        'tdc': {
            "ticketing_events_tdc": [
                "client_property",
                "stlr_is_renewal",
                "stlr_game_number",
                "stlr_season_year"
            ],
            "ticketing_tickets_tdc": [
                    "client_property",
                    "stlr_product",
                    "stlr_reported_revenue",
                    "stlr_season_year"
            ]
        }   
    }

    for root, _, files in os.walk(file_destination):
    
        for file in files:
            if file == 'dbt.yaml':
                filepath = os.path.join(root, file)
                yaml_data = read_yaml(filepath)
                if yaml_data is None: 
                    return "error reading yaml file"
                for source, sections in column_definitions.items():
                    if source in sources:
                        for section, columns in sections.items():
                            invalid = validate_columns(yaml_data, section, columns)
                            if invalid:
                                print(f'There are missing columns: {invalid}')


        

if __name__ == "__main__": 
    # update to the team you are testing
    team_name = "mp_mlse"

    file_destination = f"../../../client-config-dek/organizations/development/{team_name}"

    # list of potential sources: ['ticketmaster', 'ticketreturn' 'constant_contact', 'hubspot', 'marketo' 'sfmc', 'sfsc', 'seatgeek', 'shopify', 'tdc']
    sources_to_test = ['tdc']
    main(file_destination, sources_to_test)