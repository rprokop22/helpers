import boto3
from typing import List

def delete_objects(bucket_names: List[str], prefix: str = "stellaralgo-dev-use1"):
    s3 = boto3.resource("s3")
    for bucket_name in bucket_names:
        temp_name = f"{prefix}-{bucket_name.replace('_', '-')}"
        print(f"Deleting objects in bucket {temp_name}")
        bucket = s3.Bucket(temp_name)
        objects = bucket.objects.all()

        for obj in objects:
            key = obj.key

            try:
                bucket.object_versions.filter(Prefix=key).delete()
                print("Permanently deleted all versions of object %s.", key)
            except Exception as e:
                print("Couldn't delete all versions of %s.", key)
                raise

if __name__ == "__main__":
    delete_objects()