import boto3


# def _check_aws_profile(self):
#         """Check if the provided AWS profile is valid."""
#         # Command to check AWS session validity
#         check_session_cmd = [
#             "aws",
#             "sts",
#             "get-caller-identity",
#             "--profile",
#             self.aws_profile,
#         ]

#         # Command to initiate AWS SSO login
#         login_cmd = ["aws", "sso", "login", "--profile", self.aws_profile]

#         # Raise error if awscli not installed
#         try:
#             subprocess.check_output(["which", "aws"], stderr=subprocess.STDOUT)
#         except subprocess.CalledProcessError as e:
#             raise Exception(
#                 "AWS CLI not found. Please install it and try again."
#             ) from e
#         # Check AWS session validity
#         try:
#             subprocess.check_output(check_session_cmd, stderr=subprocess.STDOUT)
#             if not self._valid_session:
#                 print(
#                     f"Valid AWS session found for profile '{self.aws_profile}'. "
#                     "Continuing..."
#                 )
#                 self._valid_session = True

#         # If the check fails, initiate AWS SSO login
#         except subprocess.CalledProcessError:
#             print(
#                 f"No valid AWS session found for profile '{self.aws_profile}'. "
#                 "Initiating login..."
#             )
#             subprocess.run(login_cmd)
#             self._valid_session = True

if __name__ == '__main__':
    session = boto3.Session(profile_name='power-prod')

    s3 = session.resource("s3")

    source_bucket_name = 'stellaralgo-usprod-use1-echl-duluthgladiators'
    dest_bucket_name = 'stellaralgo-usprod-use1-echl-atlantagladiators'
    path = 'archive/ticketmaster' #directory + source system
    source_team_name = 'echl_duluthgladiators'
    dest_team_name = 'echl_atlantagladiators'

    source_bucket= s3.Bucket(source_bucket_name)

    for obj in source_bucket.objects.filter(Prefix=path):
        print(obj)

        source_key = obj.key
        print(f'Processing: {source_key}')
        

        dest_ingestion_property = f'ingestion_property={dest_team_name}'
        source_ingestion_property = f'ingestion_property={source_team_name}'

        if source_ingestion_property in source_key:
            source_split = source_key.split('/')
            dataset = source_split[2]
            ingestion_datetime = source_split[4]
            file = source_split[5]
            destination_key = f'{path}/{dataset}/{dest_ingestion_property}/{ingestion_datetime}/{file}'
        
            copy_source = {'Bucket': source_bucket_name, 'Key': source_key}
            try:
                s3.Object(dest_bucket_name, destination_key).copy(copy_source)
                print("Object successfully copied")
            except Exception as e:
                print(f"Failed to copy {source_key} -> {destination_key}: {e}")
    
    print("Completed copying all files")