# This github action is for updating a specific, and all last ingestion pull date attributes for Shopify

This readme is for quick access to the data structure in Dynamodb


### sample inputs for testing
  - ORGANIZATION_NAME="qa_devills_qa_devills"
  - DATE_TIME_UTC="2024-02-02T12:00:00"
  - TABLE_NAME="kernel_ingestion_state"
  - PRODUCT_NAME="shopify"
  - ATTRIBUTE_TO_UPDATE="shopify_checkouts" (this is optional)

### Legacy Shopify data
<details>
  <summary>Expand Data</summary>

```js
{
 "api": "shopify",
 "client-name": "milb-seadogs",
 "config": {
  "ingestion_datetime": "2023-08-23 19:35:29",
  "shopify_checkouts": "2023-08-23T11:54:40",
  "shopify_customers": "2023-08-23T13:36:33",
  "shopify_orders": "2023-08-23T13:36:03",
  "shopify_products": "2023-08-23T13:37:04"
 }
}
```
</details>