#!/bin/bash
echo "💧 Testing Faucet Mint..."

curl -X POST http://localhost:9000/api/faucet -H "Content-Type: application/json" -d '{"address":"0xYourWalletAddress"}'
echo
