import os
import boto3
from datetime import datetime as dt
from typing import Optional, Dict, Any

from update_shopify_legacy import update_shopify_legacy
from update_shopify_kernel import update_shopify_kernel

def get_dynamodb_item(
            table_name: str,
            product: str,
            organization_name: str,
    ) -> Optional[Dict[str, Any]]:
        """
        Args:
            table_name:
            product:
            organization_name:

        Returns:
        """
        try:
            dynamodb = boto3.resource("dynamodb")
            table = dynamodb.Table(table_name)

            #  for legacy ingestion-config table
            if table_name == "ingestion-config": 
                primary_key = "api" 
                sort_key ="client-name"
                response = table.get_item(Key={primary_key: product, sort_key: organization_name})
            #  for kernal ingestions
            elif table_name == "kernel_ingestion_state": 
                primary_key = "organization_property"
                sort_key = "source_system"
                response = table.get_item(Key={primary_key: organization_name, sort_key: product})
            # placeholder for future tables that may be implemented
            else:
                print(f"table - {table_name} not currently supported in this action")

            if "Item" in response:
                    return response["Item"]
            else:
                return None
        except Exception as e:
            print(f"Error updating item: {e}")
            return str(e)

def update_times_all(
        config: Dict[str,Any], 
        date_time: str, 
        table_name: str,
        attribute_to_update: Optional[str] = None
    ) -> Dict[str, Any]:
    """
    Args:
        config:
        date_time:
        table_name:
        attribute_to_update:
    Returns:
    """
    
    expected_format = "%Y-%m-%dT%H:%M:%S"
    #convert the date_time string into a dict for comaprison
    iso_date = dt.strptime(date_time, expected_format)

    # make sure the date is in the proper iso format
    if iso_date.strftime(expected_format) != date_time:
        print("ISO String does not match date_time variable")
        exit(1)

    result = config.copy()

    # The following is for legacy ticketmaster
    if table_name == "ingestion-config":
        return update_shopify_legacy(result, date_time, attribute_to_update)
    elif table_name == "kernel_ingestion_state":
        return update_shopify_kernel(result, date_time, attribute_to_update)
    else:
        print(f"Error -- {table_name} not yet implemented")
        exit(1)

def put_dynamodb_item(
        item: Dict[str,Any],
        table_name: str,
    ) -> str:
        """
        Args:
            item:
            table_name:

        Returns:
        """ 
        try:       
            dynamodb = boto3.resource("dynamodb")
            table = dynamodb.Table(table_name)

            response = table.put_item(Item=item)
            return response
        except Exception as e:
            print(f"Error updating item: {e}")
            return str(e)


#  helper function for variable missing error
def no_variables_error(arg):
    switch ={
        "org-none": "organization_name not found",
        "date-none": "date_time_utc not found",
        "table-none": "table_name not found",
        "product-none": "product_name not found",
    }
    print(switch.get(arg))
    exit(1)

def main():
    organization_name = os.getenv("ORGANIZATION_NAME")
    date_time_utc = os.getenv("DATE_TIME_UTC")
    table_name = os.getenv("TABLE_NAME")
    product_name = os.getenv("PRODUCT_NAME")
    attribute_to_update = os.getenv("ATTRIBUTE_TO_UPDATE")

    if organization_name is None:
        no_variables_error("org-none")
    elif date_time_utc is None:
        no_variables_error("date-none")
    elif table_name is None:
        no_variables_error("table-none")
    elif product_name is None:
        no_variables_error("product-none")

    result = get_dynamodb_item(table_name, product_name, organization_name)
    updated = update_times_all(result, date_time_utc, table_name, attribute_to_update)
    response = put_dynamodb_item(updated, table_name ) # comment this out for testing 
    # response = True #this is for testing on dev, without actually updating anything
    if response:
        print(f"{organization_name} item last_pull_date_UTC has been updated")
    else: 
        print(f"There was an error updating {organization_name}")
   


if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print(f"FAILED IN UPDATING DATABASE: {str(error)}")
        raise error
        