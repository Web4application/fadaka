#!/bin/bash
echo "🧪 Testing FastAPI Tx and Sign API..."

curl -X POST http://localhost:9000/api/sign -H "Content-Type: application/json" -d '{"from":"0x123...", "to":"0x456...", "amount":1000}'
echo
