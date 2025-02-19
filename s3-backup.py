import boto3


def _check_aws_profile(self):
        """Check if the provided AWS profile is valid."""
        # Command to check AWS session validity
        check_session_cmd = [
            "aws",
            "sts",
            "get-caller-identity",
            "--profile",
            self.aws_profile,
        ]

        # Command to initiate AWS SSO login
        login_cmd = ["aws", "sso", "login", "--profile", self.aws_profile]

        # Raise error if awscli not installed
        try:
            subprocess.check_output(["which", "aws"], stderr=subprocess.STDOUT)
        except subprocess.CalledProcessError as e:
            raise Exception(
                "AWS CLI not found. Please install it and try again."
            ) from e
        # Check AWS session validity
        try:
            subprocess.check_output(check_session_cmd, stderr=subprocess.STDOUT)
            if not self._valid_session:
                print(
                    f"Valid AWS session found for profile '{self.aws_profile}'. "
                    "Continuing..."
                )
                self._valid_session = True

        # If the check fails, initiate AWS SSO login
        except subprocess.CalledProcessError:
            print(
                f"No valid AWS session found for profile '{self.aws_profile}'. "
                "Initiating login..."
            )
            subprocess.run(login_cmd)
            self._valid_session = True

if __name__ == '__main__':
    s3 = boto3.resource('s3')

    bucket_name = 'stellaralgo-usprod-use1-mp-toledosports'
    source_path = 'backup/tdc' #directory + source system
    destination_path = 'archive/tdc' #directory + source system
    team_name = 'echl_walleye'

    bucket= s3.Bucket(bucket_name)

    for obj in bucket.objects.filter(Prefix=source_path):
        print(obj)

        source_key = obj.key
        print(f'Processing: {source_key}')
        

        ingestion_property = f'ingestion_property={team_name}'
        if ingestion_property in source_key:

            dataset = source_key.split('/')[2]
            ingestion_datetime = source_key.split('/')[4]
            file = source_key.split('/')[5]
            destination_key = f'{destination_path}/{dataset}/{ingestion_property}/{ingestion_datetime}/{file}'
        
            copy_source = {'Bucket': bucket_name, 'Key': source_key}
            s3.Object(bucket_name, destination_key).copy(copy_source)
            print("Object successfully copied")
    
    print("Completed copying all files")