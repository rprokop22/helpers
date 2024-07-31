import datetime
import json
from datetime import datetime as dt

import httpx

API_LIMIT = 50
API_VERSION = "2024-04"
API_TIMEOUT = 90  # seconds

shop_name = ""
access_token = ""

shop_url = f"{shop_name}.myshopify.com"
client = httpx.Client(
    headers={"X-Shopify-Access-Token": access_token},
    timeout=httpx.Timeout(API_TIMEOUT, connect=API_TIMEOUT),
    )

params = {
    "updated_at_min": "2024-07-31T00:00:00",
    "limit": API_LIMIT,
}

response = client.get(
    url=f"https://{shop_url}/admin/api/{API_VERSION}/checkouts.json",
    params=params,
)

data = response.json()

print(data)

# Extract the x-request-id from response headers
x_request_id = response.headers.get('x-request-id')
if x_request_id:
    print(f"Extracted x-request-id: {x_request_id}")
else:
    print("x-request-id not found in response headers")

print(response.headers)

