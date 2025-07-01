# Build
docker build -t fadaka:latest .

# Run mainnet node
docker run -it --rm \
  -p 30303:30303 -p 8545:8545 \
  --name fadaka \
  fadaka:latest

# Run on Sepolia testnet
docker run -it --rm \
  -e FADAKA_NETWORK=sepolia \
  fadaka:latest node --network sepolia
