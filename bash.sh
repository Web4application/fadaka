git clone https://github.com/Web4application/fadaka.git
cd fadaka

git checkout -b renovate/fix-typechain-range

git clone https://github.com/eveem-org/panoramix.git
pip3 install -r requirements.txt
 pip install streamlit pandas

# Build (native arch)
 docker build -t fadaka:latest .

# Build cross‑arch (e.g., arm64):
 docker buildx build --platform linux/arm64 -t fadaka:arm64 .

# Run
 docker run -it --rm \
  -p 30303:30303 -p 8545:8545 \
  fadaka:latest

cd rodaai-backend
uvicorn app.main:app --host 0.0.0.0 --port 7000
# In a separate terminal, start local blockchain node
 npx hardhat node
 npx hardhat run scripts/deploy.js --network localhost

# Deploy contract to local node
npx hardhat run scripts/deploy.js --network localhost
npm run prepare
 npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox dotenv
 npm install @openzeppelin/contracts-upgradeable @openzeppelin/hardhat-upgrades
 npm install husky eslint jest --save-dev
 npx hardhat
 npx hardhat compile
 npx hardhat run scripts/deploy-v2.js --network fadakaTestnet
 npx hardhat run scripts/deploy-fadaka-upgradeable.js --network fadakaTestnet
 npx husky install
 npx husky add .husky/pre-commit "npm run lint"
 npx husky add .husky/pre-push "npm test"
 npx hardhat node
 npx hardhat compile
# Choose: "Create a JavaScript project"

 npm install eslint jest --save-dev
 cd backend
 npm install
cd frontend
npm install

 npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox dotenv
artifacts/contracts/MyContract.sol/MyContract.json
 npm init -y
 npm install --save-dev hardhat
 npm install husky --save-dev

 go install mvdan.cc/gofumpt@v0.4.0
 go install honnef.co/go/tools/cmd/staticcheck@v0.4.2
 go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.60.3
 go install go.uber.org/nilaway/cmd/nilaway@latest
 go install github.com/daixiang0/gci@v0.11.2

 npx hardhat verify --network fadakaTestnet YOUR_PROXY_ADDRESS
const upgraded = await upgrades.upgradeProxy(proxyAddress, FadakaTokenV2);

 npx hardhat run scripts/deploy-v2.js --network fadakaTestnet

 npx hardhat verify --network fadakaTestnet YOUR_PROXY_ADDRESS

 git clone https://github.com/Web4application/fadakacoin.git
 cd fadakacoin/backend && npm install
 cd ../frontend && npm install

# Set up .env
FADAKA_TESTNET_RPC=https://rpc.fadaka.io
FADAKA_PRIVATE_KEY=your_wallet_private_key
FADAKA_EXPLORER_API_KEY=optional_api_key

# Then run:
 npx hardhat compile
 npx hardhat run scripts/deploy-v2.js --network fadakaTestnet

./btfs init
./btfs daemon

# 1) Build/pull images (build locally if not yet pushed)
 docker compose build        # or docker compose pull
# 2) Launch everything
 docker compose up -d
# 3) Observe logs
 docker compose logs -f node

 curl -L https://foundry.paradigm.xyz | bash
 cargo install --git https://github.com/foundry-rs/foundry --profile release --locked forge cast chisel anvil

# clone the repository
 git clone https://github.com/foundry-rs/foundry.git
 cd foundry
# install Forge
 cargo install --path ./crates/forge --profile release --force --locked
# install Cast
 cargo install --path ./crates/cast --profile release --force --locked
# install Anvil
 cargo install --path ./crates/anvil --profile release --force --locked
# install Chisel
 cargo install --path ./crates/chisel --profile release --force --locked

 wget https://dist.ipfs.tech/kubo/v0.35.0/kubo_v0.35.0_linux-amd64.tar.gz
tar -xvzf kubo_v0.35.0_linux-amd64.tar.gz
cd kubo
./install.sh
ipfs init
ipfs daemon

 git clone https://github.com/eveem-org/panoramix.git
 pip3 install -r requirements.txt

# Fetch Postgres dependency
 helm dependency update fadaka-chart/

# Dry‑run install
 helm install fadaka fadaka-chart/ --namespace fadaka --create-namespace --dry-run

# Real install
 helm install fadaka fadaka-chart/ --namespace fadaka --create-namespace

 git clone https://github.com/Web4application/fadakacoin.git
 cd fadakacoin

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

git apply fix-typechain-version.patch

go install github.com/ethereum/go-ethereum/cmd/abigen@latest

go run assembly/cli.go decode 0x6080604052348015600f57600080fd5b

forge test --match-path tests/Quest.t.sol

go run cmd/fadaka_keys.go generate
go run cmd/fadaka_keys.go sign fadaka_private.pem tx.json
go run cmd/fadaka_keys.go verify fadaka_public.pem signed_tx.json

cd contracts/hello
make build

go run vm/runner.go

fadaka-cli deploy SovereignIdentity --upgradeable
fadaka-cli deploy DAOModerator --trust-gated
fadaka-cli deploy QuestEngine --agent Web4Node
fadaka-cli deploy VaultTreasury --strategy AI

go build -o fadaka ./cmd/fadaka
./fadaka start
go mod tidy
git clone https://github.com/Web4application/fadakacoin.git
cd fadakacoin

git clone https://github.com/Web4application/fadaka.git
cd fadaka

mkdir web4app-fadaka && cd web4app-fadaka
mkdir assets
---

```bash
fadaka/
├── index.html
├── wallet.html
├── dapp.html
├── network.html
├── settings.html
├── contracts.html
├── about.html
├── config.js
├── .env.development
├── .env.production
├── favicon.ico
└── assets/
    ├── style.css
    └── app.js

    cd your-fadaka-repo
unzip ../fadaka-typechain-setup.zip
cd contracts && rm Example.sol && rm -rf test # if you already have them
cd ../ # back to root
npm install

git clone https://github.com/Web4application/fadaka.git
cd fadaka
git checkout -b renovate/fix-typechain-range

 pip install streamlit pandas

# Build (native arch)
 docker build -t fadaka:latest .

# Build cross‑arch (e.g., arm64):
 docker buildx build --platform linux/arm64 -t fadaka:arm64 .

# Run
 docker run -it --rm \
  -p 30303:30303 -p 8545:8545 \
  fadaka:latest

cd rodaai-backend
uvicorn app.main:app --host 0.0.0.0 --port 7000
# In a separate terminal, start local blockchain node
 npx hardhat node
 npx hardhat run scripts/deploy.js --network localhost

# Deploy contract to local node
npx hardhat run scripts/deploy.js --network localhost
npm run prepare
 npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox dotenv
 npm install @openzeppelin/contracts-upgradeable @openzeppelin/hardhat-upgrades
 npm install husky eslint jest --save-dev
 npx hardhat
 npx hardhat compile
 npx hardhat run scripts/deploy-v2.js --network fadakaTestnet
 npx hardhat run scripts/deploy-fadaka-upgradeable.js --network fadakaTestnet
 npx husky install
 npx husky add .husky/pre-commit "npm run lint"
 npx husky add .husky/pre-push "npm test"
 npx hardhat node
 npx hardhat compile
# Choose: "Create a JavaScript project"

 npm install eslint jest --save-dev
 cd backend
 npm install
cd frontend
npm install

 npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox dotenv
artifacts/contracts/MyContract.sol/MyContract.json
 npm init -y
 npm install --save-dev hardhat
 npm install husky --save-dev

 go install mvdan.cc/gofumpt@v0.4.0
 go install honnef.co/go/tools/cmd/staticcheck@v0.4.2
 go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.60.3
 go install go.uber.org/nilaway/cmd/nilaway@latest
 go install github.com/daixiang0/gci@v0.11.2

 npx hardhat verify --network fadakaTestnet YOUR_PROXY_ADDRESS
const upgraded = await upgrades.upgradeProxy(proxyAddress, FadakaTokenV2);

 npx hardhat run scripts/deploy-v2.js --network fadakaTestnet

 npx hardhat verify --network fadakaTestnet YOUR_PROXY_ADDRESS

 git clone https://github.com/Web4application/fadakacoin.git
 cd fadakacoin/backend && npm install
 cd ../frontend && npm install

# Set up .env
FADAKA_TESTNET_RPC=https://rpc.fadaka.io
FADAKA_PRIVATE_KEY=your_wallet_private_key
FADAKA_EXPLORER_API_KEY=optional_api_key

# Then run:
 npx hardhat compile
 npx hardhat run scripts/deploy-v2.js --network fadakaTestnet

./btfs init
./btfs daemon

# 1) Build/pull images (build locally if not yet pushed)
 docker compose build        # or docker compose pull
# 2) Launch everything
 docker compose up -d
# 3) Observe logs
 docker compose logs -f node

 curl -L https://foundry.paradigm.xyz | bash
 cargo install --git https://github.com/foundry-rs/foundry --profile release --locked forge cast chisel anvil

# clone the repository
 git clone https://github.com/foundry-rs/foundry.git
 cd foundry
# install Forge
 cargo install --path ./crates/forge --profile release --force --locked
# install Cast
 cargo install --path ./crates/cast --profile release --force --locked
# install Anvil
 cargo install --path ./crates/anvil --profile release --force --locked
# install Chisel
 cargo install --path ./crates/chisel --profile release --force --locked

 wget https://dist.ipfs.tech/kubo/v0.35.0/kubo_v0.35.0_linux-amd64.tar.gz
tar -xvzf kubo_v0.35.0_linux-amd64.tar.gz
cd kubo
./install.sh
ipfs init
ipfs daemon

 git clone https://github.com/eveem-org/panoramix.git
 pip3 install -r requirements.txt

# Fetch Postgres dependency
 helm dependency update fadaka-chart/

# Dry‑run install
 helm install fadaka fadaka-chart/ --namespace fadaka --create-namespace --dry-run

# Real install
 helm install fadaka fadaka-chart/ --namespace fadaka --create-namespace

 git clone https://github.com/Web4application/fadakacoin.git
 cd fadakacoin

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

git apply fix-typechain-version.patch

go install github.com/ethereum/go-ethereum/cmd/abigen@latest

go run assembly/cli.go decode 0x6080604052348015600f57600080fd5b

forge test --match-path tests/Quest.t.sol

go run cmd/fadaka_keys.go generate
go run cmd/fadaka_keys.go sign fadaka_private.pem tx.json
go run cmd/fadaka_keys.go verify fadaka_public.pem signed_tx.json

cd contracts/hello
make build

go run vm/runner.go

fadaka-cli deploy SovereignIdentity --upgradeable
fadaka-cli deploy DAOModerator --trust-gated
fadaka-cli deploy QuestEngine --agent Web4Node
fadaka-cli deploy VaultTreasury --strategy AI

go build -o fadaka ./cmd/fadaka
./fadaka start
go mod tidy
git clone https://github.com/Web4application/fadakacoin.git
cd fadakacoin

git clone https://github.com/Web4application/fadaka.git
cd fadaka

mkdir web4app-fadaka && cd web4app-fadaka
mkdir assets
---
web4app-fadaka/
├── index.html
├── wallet.html
├── dapp.html
├── network.html
├── settings.html
├── contracts.html
├── about.html
├── config.js
├── .env.development
├── .env.production
├── favicon.ico
└── assets/
    ├── style.css
    └── app.js

cd your-fadaka-repo
unzip ../fadaka-typechain-setup.zip
cd contracts && rm Example.sol && rm -rf test # if you already have them
cd ../ # back to root
npm install

$ WEB3_PROVIDER_URI=http://localhost:7545 panoramix 0xa0C5F9c82e7A67eb995da394bEa78b056561Eb11
$ panoramix 0x608060405234801561000f575f80fd5b50600436106100c4575f3560e01c80633eaaf86b1161007d578063a9059cbb11610058578063a9059cbb14610194578063b09f1266146101a7578063d28d8852146101cb575f80fd5b80633eaaf86b1461015257806370a082311461016057806395d89b4114610173575f80fd5b806323b872dd116100ad57806323b872dd14610112578063313ce5671461013557806332424aa31461014a575f80fd5b806306fdde03146100c857806318160ddd146100fb575b5f80fd5b6040805180820190915260058152642a37b5b2b760d91b60208201525b6040516100f2919061034a565b60405180910390f35b6001600160fd1b035b6040519081526020016100f2565b6101256101203660046103b1565b6101ef565b60405190151581526020016100f2565b60125b60405160ff90911681526020016100f2565b610138601281565b6101046001600160fd1b0381565b61010461016e3660046103ea565b61028a565b604080518082019091526005815264045524332360dc1b60208201526100e5565b6101256101a236600461040a565b6102f3565b6100e560405180604001604052806005815260200164045524332360dc1b81525081565b6100e5604051806040016040528060058152602001642a37b5b2b760d91b81525081565b5f80546001600160a01b03163214610233576040517f0bf9dbd100000000000000000000000000000000000000000000000000000000815260040160405180910390fd5b826001600160a01b0316846001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef8460405161027891815260200190565b60405180910390a35060019392505050565b5f6001600160fd1b034442336040516020016102cb93929190928352602083019190915260601b6bffffffffffffffffffffffff1916604082015260540190565b604051602081830303815290604052805190602001205f1c6102ed9190610432565b92915050565b5f826001600160a01b0316326001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef8460405161033991815260200190565b60405180910390a350600192915050565b5f602080835283518060208501525f5b818110156103765785810183015185820160400152820161035a565b505f604082860101526040601f19601f8301168501019250505092915050565b80356001600160a01b03811681146103ac575f80fd5b919050565b5f805f606084860312156103c3575f80fd5b6103cc84610396565b92506103da60208501610396565b9150604084013590509250925092565b5f602082840312156103fa575f80fd5b61040382610396565b9392505050565b5f806040838503121561041b575f80fd5b61042483610396565b946020939093013593505050565b5f82610465577f4e487b71000000000000000000000000000000000000000000000000000000005f52601260045260245ffd5b50069056fea164736f6c6343000817000a
