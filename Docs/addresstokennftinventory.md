# Get Address ERC721 Token Inventory by Contract
---
> Retrieves the number of ERC-721 token IDs owned by a specific address for each NFT collection.

export const chain = '1';

<Note>This is a PRO endpoint, available to the [Standard Plan](/resources/rate-limits) and above</Note>

<Warning>This [historical endpoint](/resources/rate-limits) is throttled to 2 calls/s</Warning>

### Query Parameters
'
<ParamField query="apikey" type="string" default="YourApiKeyToken">
  Your Etherscan API key.
</ParamField>'
'
<ParamField query="chainid" type="string" default="1">
  Chain ID to query, eg `1` for Ethereum, `8453` for Base from our [supported chains](/supported-chains).
</ParamField>
<ParamField query="module" type="string" default="account">
  Set to `account` for this endpoint.
</ParamField>
<ParamField query="action" type="string" default="addresstokennftinventory">
  Set to `addresstokennftinventory` for this endpoint.
</ParamField>
<ParamField query="address" type="string" default="0x123432244443b54409430979df8333f9308a6040">
  Address to check for inventory.
</ParamField>
<ParamField query="contractaddress" type="string" default="0xed5af388653567af2f388e6224dc7c4b3241c544">
  ERC-721 token contract address to filter by.
</ParamField>
<ParamField query="page" type="integer" default="1">
  Page number for pagination.
</ParamField>
<ParamField query="offset" type="integer" default="100">
  Number of records per page. Limited to 1000 records per query; use the `page` parameter for subsequent records.
</ParamField>
<RequestExample>
  ```bash  theme={null}
  curl "https://api.etherscan.io/v2/api?chainid=1&module=account&action=addresstokennftinventory&address=0x123432244443b54409430979df8333f9308a6040&contractaddress=0xed5af388653567af2f388e6224dc7c4b3241c544&page=1&offset=100&apikey=YourApiKeyToken"
  ```
</RequestExample>
<ResponseExample>
  
  ```json  theme={null}
  {
    "status": "1",
    "message": "OK",
    "result": [
      {
        "TokenAddress": "0xed5af388653567af2f388e6224dc7c4b3241c544",
        "TokenId": "453"
      },
      {
        "TokenAddress": "0xed5af388653567af2f388e6224dc7c4b3241c544",
        "TokenId": "8160"
      }
    ]
  }
  ```
</ResponseExample>
---

> To find navigation and other pages in this documentation, fetch the llms.txt file at: https://docs.etherscan.io/llms.txt
