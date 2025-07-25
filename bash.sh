$ pip install streamlit pandas

# Build (native arch)
$ docker build -t fadaka:latest .

# Build cross‑arch (e.g., arm64):
$ docker buildx build --platform linux/arm64 -t fadaka:arm64 .

# Run
$ docker run -it --rm \
  -p 30303:30303 -p 8545:8545 \
  fadaka:latest


# In a separate terminal, start local blockchain node
$ npx hardhat node
$ npx hardhat run scripts/deploy.js --network localhost

# Deploy contract to local node
$ npx hardhat run scripts/deploy.js --network localhost

$ npm run prepare
$ npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox dotenv
$ npm install @openzeppelin/contracts-upgradeable @openzeppelin/hardhat-upgrades
$ npm install husky eslint jest --save-dev

$ npx hardhat
$ npx hardhat compile
$ npx hardhat run scripts/deploy-v2.js --network fadakaTestnet
$ npx hardhat run scripts/deploy-fadaka-upgradeable.js --network fadakaTestnet
$ npx husky install
$ npx husky add .husky/pre-commit "npm run lint"
$ npx husky add .husky/pre-push "npm test"
$ npx hardhat node
$ npx hardhat compile
# Choose: "Create a JavaScript project"

$ npm install eslint jest --save-dev
$ cd backend
$ npm install
$ cd frontend
$ npm install

$ npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox dotenv
artifacts/contracts/MyContract.sol/MyContract.json
$ npm init -y
$ npm install --save-dev hardhat
$ npm install husky --save-dev

$ go install mvdan.cc/gofumpt@v0.4.0
$ go install honnef.co/go/tools/cmd/staticcheck@v0.4.2
$ go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.60.3
$ go install go.uber.org/nilaway/cmd/nilaway@latest
$ go install github.com/daixiang0/gci@v0.11.2

$ npx hardhat verify --network fadakaTestnet YOUR_PROXY_ADDRESS
const upgraded = await upgrades.upgradeProxy(proxyAddress, FadakaTokenV2);

$ npx hardhat run scripts/deploy-v2.js --network fadakaTestnet

$ npx hardhat verify --network fadakaTestnet YOUR_PROXY_ADDRESS

$ git clone https://github.com/Web4application/fadakacoin.git
$ cd fadakacoin/backend && npm install
$ cd ../frontend && npm install

# Set up .env
FADAKA_TESTNET_RPC=https://rpc.fadaka.io
FADAKA_PRIVATE_KEY=your_wallet_private_key
FADAKA_EXPLORER_API_KEY=optional_api_key

# Then run:
$ npx hardhat compile
$ npx hardhat run scripts/deploy-v2.js --network fadakaTestnet

./btfs init
./btfs daemon

# 1) Build/pull images (build locally if not yet pushed)
$ docker compose build        # or docker compose pull
# 2) Launch everything
$ docker compose up -d
# 3) Observe logs
$ docker compose logs -f node

$ curl -L https://foundry.paradigm.xyz | bash
$ cargo install --git https://github.com/foundry-rs/foundry --profile release --locked forge cast chisel anvil

# clone the repository
$ git clone https://github.com/foundry-rs/foundry.git
$ cd foundry
# install Forge
$ cargo install --path ./crates/forge --profile release --force --locked
# install Cast
$ cargo install --path ./crates/cast --profile release --force --locked
# install Anvil
$ cargo install --path ./crates/anvil --profile release --force --locked
# install Chisel
$ cargo install --path ./crates/chisel --profile release --force --locked

$ wget https://dist.ipfs.tech/kubo/v0.35.0/kubo_v0.35.0_linux-amd64.tar.gz
tar -xvzf kubo_v0.35.0_linux-amd64.tar.gz
cd kubo
./install.sh
ipfs init
ipfs daemon

$ git clone https://github.com/eveem-org/panoramix.git
$ pip3 install -r requirements.txt

# Fetch Postgres dependency
$ helm dependency update fadaka-chart/

# Dry‑run install
$ helm install fadaka fadaka-chart/ --namespace fadaka --create-namespace --dry-run

# Real install
$ helm install fadaka fadaka-chart/ --namespace fadaka --create-namespace

$ git clone https://github.com/Web4application/fadakacoin.git
$ cd fadakacoin

git clone https://github.com/ethereum/go-ethereum.git
cd go-ethereum

go install golang.org/dl/go1.23@latest
go1.23 download
go1.23 env

go build -o build/bin/geth ./cmd/geth

./build/bin/geth --http --dev --datadir "./data"

go get -u ./...

go vet ./...
staticcheck ./...
go test ./...

go build -ldflags="-s -w" -o build/geth ./cmd/geth

GOFLAGS="-ldflags=-linkmode=external -extldflags=-O2" go build ...

docker build -t geth-local .
docker run -p 5000:5000 geth-local --http:localhost:8000

# Go to the project root
cd fadaka_proxy_deployment/contracts

# Rename the file to remove the trailing space
git mv "ipfs_addr.h " "ipfs_addr.h"
git commit -m "Fix: Removed trailing space in filename"
git push

git rm --cached "fadaka_proxy_deployment/contracts/ipfs_addr.h "
git commit -m "Remove invalid file with trailing space"
git push

rm pnpm-lock.yaml node_modules -rf
pnpm install
