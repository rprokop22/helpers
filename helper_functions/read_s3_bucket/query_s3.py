import pandas as pd
import boto3
import os
import json

# def list_buckets():
#     s3_client = boto3.client('s3')
#     response = s3_client.list_buckets()
#     buckets = [bucket['Name'] for bucket in response['Buckets']]
#     return buckets



if __name__ == "__main__":
    # print(list_buckets())
    
    s3 = boto3.client('s3')
    original_bucket_name = 'stellaralgo-usprod-use1-echl-duluthgladiators'
    new_bucket_name = 'stellaralgo-usprod-use1-echl-atlantagladiators'
    
    source = 'ticketmaster'
    table = 'attendances'
    sub_dir = 'data'
    directory = f'iceberg'
    # archive_attendances_path = 'archive/ticketmaster/attendances/ingestion_property=nba_warriors/'
    
    response = s3.list_objects_v2(Bucket=original_bucket_name, Prefix=directory)

    breakpoint()
    if 'Contents' in response:
        for file in response['Contents']:
            print(file)
        #     if file['Key'].endswith('.TXT'):
        #         continue
        #     else:
        #         s3_client = s3.get_object(Bucket=bucket_name, Key=file['Key'])
        #         content = json.loads(s3_client['Body'].read().decode('utf-8')) 
        #         df = pd.DataFrame(content)
        #         for event in df['_embedded']['attend']:
        #             if event['eventId'] in (
        #                 '10371',
        #                 '10383',
        #                 '10346',
        #                 '10357',
        #                 '10359'
        #             ):
        #                 print(f'FOUND event: {event["eventId"]} in file {file["Key"]}')
        #                 events_found.append(f"{file['Key']}: {event}")
        #         print(f'{file['Key']} complete')
            
        # print(events_found)
                    
            
        #     df = pd.read_json(file['Key'], lines=True)
        #     print(df)
            
        
            
            
        
        