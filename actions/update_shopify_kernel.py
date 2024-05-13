from typing import Dict, Any
# if a specific attribute is passed in, update only that attribute
# otherwise update all attributes
def update_shopify_kernel(result: Dict[str, Any], date_time: str, attribute_to_update: str):
    if attribute_to_update:
        if result["watermarks"][attribute_to_update]:
            result["watermarks"][attribute_to_update] = date_time     
        else:
            print("Attribute not valid!!")
            exit(1) 
    else:
        new_watermarks = result["watermarks"].copy()
        for mark in new_watermarks:
            result["watermarks"][mark] = date_time
            
    return result


    
  