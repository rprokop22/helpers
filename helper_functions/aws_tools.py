"""Helper functions for interacting with AWS services."""

from pathlib import Path
import subprocess
import time
from typing import List, Union

import awswrangler as wr
import boto3
from pandas import DataFrame
from rich import print

from .constants import (
    VALIDATOR_QUERY_RESULTS_BUCKET,
    VALIDATOR_QUERY_RESULTS_BUCKET_DEV,
)


class AWSTools:

    _athena_client = None
    _secretsmanager_client = None
    _kms_client = None
    _s3_client = None
    _session = None
    _valid_session = False

    def __init__(self, aws_profile: str):
        self.aws_profile = aws_profile

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

    @property
    def session(self):
        """Return a boto3 session object or reuse existing one if one exists."""
        self._check_aws_profile()
        if self._session is None:
            self._session = boto3.session.Session(profile_name=self.aws_profile)
        return self._session

    def _client_setter(self, resource_name: str):
        formatted = f"_{resource_name}_client"
        if hasattr(self, formatted):
            attr = getattr(self, formatted)
            if attr is None:
                setattr(self, formatted, self.session.client(resource_name))
            return getattr(self, formatted)
        else:
            raise ValueError(f"{resource_name} is not a valid resource.")

    @property
    def s3_client(self):
        return self._client_setter("s3")

    @property
    def athena_client(self):
        return self._client_setter("athena")

    @property
    def secretsmanager_client(self):
        return self._client_setter("secretsmanager")

    @property
    def kms_client(self):
        return self._client_setter("kms")

    def read_json(
        self, s3_path: Union[List[str], Union[str, Path]], orient=None, **kwargs
    ) -> DataFrame:
        """Read a JSON file from S3 and return it as a DataFrame."""
        if isinstance(s3_path, Path):
            s3_path = str(s3_path)
        if orient is None:
            args = {
                "path": s3_path,
                "boto3_session": self.session,
            }
        else:
            args = {"path": s3_path, "boto3_session": self.session, "orient": orient}
        return wr.s3.read_json(**args, **kwargs)

    def run_query(
        self,
        query: str,
        database: str,
    ):
        response = None
        # Power User in profile, most likely we have 'ower' from the power
        if "ower" in self.aws_profile:
            response = self.athena_client.start_query_execution(
                QueryString=query,
                QueryExecutionContext={"Database": database},
                ResultConfiguration={
                    "OutputLocation": VALIDATOR_QUERY_RESULTS_BUCKET_DEV
                },
            )
        else:
            response = self.athena_client.start_query_execution(
                QueryString=query,
                QueryExecutionContext={"Database": database},
                ResultConfiguration={"OutputLocation": VALIDATOR_QUERY_RESULTS_BUCKET},
            )
        return response["QueryExecutionId"]

    def get_query_results(self, query_execution_id: str, max_retries=5):

        retry_count = 0
        base_sleep_time = 1

        while retry_count <= max_retries:
            response = self.athena_client.get_query_execution(
                QueryExecutionId=query_execution_id
            )
            status = response["QueryExecution"]["Status"]["State"]

            if status in ["SUCCEEDED", "FAILED", "CANCELLED"]:
                break

            time.sleep(base_sleep_time * (2**retry_count))  # Exponential backoff

            retry_count += 1

        if retry_count > max_retries:
            raise Exception("Maximum Retries Exceeded")

        if status == "SUCCEEDED":
            result = self.athena_client.get_query_results(
                QueryExecutionId=query_execution_id
            )
            return result

        else:
            raise Exception(
                f"Query {status}: "
                f"{response['QueryExecution']['Status']['StateChangeReason']}"
            )

    def read_latest_json(self, s3_path: str, orient=None) -> DataFrame:
        """Reads the latest JSON file from a bucket and returns it as dataframe."""
        args = {"path": s3_path, "boto3_session": self.session}
        objs = wr.s3.describe_objects(**args)
        last_modified_datetime = sorted(
            (obj["LastModified"] for obj in objs.values()), reverse=True
        )[0]
        last_modified_file = [
            k for (k, v) in objs.items() if v["LastModified"] >= last_modified_datetime
        ][0]
        return self.read_json(last_modified_file, orient=orient)
