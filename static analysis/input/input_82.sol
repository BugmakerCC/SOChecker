block.timestamp >= _openingTime

curl -X POST \
  http:
  -H 'Content-Type: application/json' \
  -d '{
    "jsonrpc": "1.0",
    "id": "curltest",
    "method": "evm_increaseTime",
    "params": [
      100000
  ]
}'


