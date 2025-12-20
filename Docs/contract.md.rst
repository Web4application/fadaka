# Verify Proxy Contract
   
> Submit a proxy contract for verification.

export const chain = '1';

### Query Parameters

<ParamField query="apikey" type="string" default="YourApiKeyToken">
  Your Etherscan API key.
</ParamField>

<ParamField query="chainid" type="string" default="1">
  Chain ID to query, eg `1` for Ethereum, `8453` for Base from our [supported chains](/supported-chains).
</ParamField>

<ParamField query="module" type="string" default="contract">
  Set to `contract` for this endpoint.
</ParamField>

<ParamField query="action" type="string" default="verifyproxycontract">
  Set to `verifyproxycontract` for this endpoint.
</ParamField>

<ParamField query="address" type="string" default="0xcbdcd3815b5f975e1a2c944a9b2cd1c985a1cb7f">
  The proxy contract address to verify.
</ParamField>

<ParamField query="expectedimplementation" type="string" default="0xB0F24CEB2616F6Bb608B00875Db306167c0f2E8C">
  Optional implementation address to enforce during verification.
</ParamField>

<ResponseExample>
  ```json Response theme={null}
  {
      "status": "1",
      "message": "OK",
      "result": "a7lpxkm9kpcpicx7daftmjifrfhiuhf5vqqnawhkfhzfrcpnxj"
  }
  ```
</ResponseExample>


---

> To find navigation and other pages in this documentation, fetch the llms.txt file at: https://docs.etherscan.io/llms.txt
