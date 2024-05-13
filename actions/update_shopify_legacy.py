from typing import Dict, Any
# if a specific attribute is passed in, update only that attribute
# otherwise update all attributes
def update_shopify_legacy(result: Dict[str, Any], date_time: str, attribute_to_update: str):
    if attribute_to_update:
        if result['config'][attribute_to_update]:
            result['config'][attribute_to_update] = date_time
        else:
            print("Attribute not valid!!")
            exit(1)    
    else: 
        new_attr = result["config"].copy()
        for attr in new_attr:
            result['config'][attr] = date_time

    return result

    
  