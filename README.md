
# 🪙 Fadaka 

**Fadaka** is a custom-built Layer 1 blockchain protocol developed to power the next generation of decentralized applications. Built with performance, modularity, and developer-accessibility in mind, Fadaka merges secure peer-to-peer networking, smart contract logic, and integrated wallet systems under a unified Web4-ready infrastructure.

---

## 🚀 Features

- ⚙️ **Custom Blockchain Engine** – Built from scratch in Go
- 🔐 **TLS-Secured Peer-to-Peer Networking** – Encrypted node communication with registry support
- 🔄 **HD Wallet Integration** – BIP-39/44-based address generation and mnemonic recovery
- 🧠 **Fadaka Virtual Machine (FVM)** – Designed for smart contract execution (EVM/WASM compatible)
- 🔁 **Token Minting & Burning** – On-chain logic with event support and zero address handling
- 📡 **Transaction Signing & Broadcasting** – FastAPI backend integration for real-time transaction flow
- 🧪 **Upgradeable Contracts (Proxy Support)** – Transparent proxy pattern for live contract upgrades
- 💧 **Faucet & Mining** – Native faucet module for test tokens and PoW/PoA mining options
- 🌐 **Swift Beta Wallet Integration** – Frontend dashboard with QR code, swap, and contract control
- 🔍 **Contract Debugging & Explorer Hooks** – Bytecode and ABI interpretation tools
- 🧬 **Web4-AI Ready** – Connects with Web4Node, SwiftBot, and ProjectPilot AI

---

## 📁 Project Structure

```

fadaka-blockchain/
├── cmd/                 # Main CLI entry point
├── node/                # Peer logic, TLS networking
├── core/                # Blockchain core: ledger, state, VM
├── wallet/              # HD wallet tools, mnemonic generation
├── contracts/           # Smart contracts (mint, burn, faucet, proxy)
├── api/                 # FastAPI backend for signing/broadcasting
├── scripts/             # Deployment, testing, dev automation
└── README.md            # You are here

````

---

## 🔧 Getting Started

### Prerequisites
- Go 1.20+
- Python 3.10+ (for API backend)
- Node.js (for frontend integration)

### Run a Node
```bash
go run ./cmd/main.go
````

### Start the FastAPI Backend

```bash
cd api/
uvicorn main:app --reload
```

### Launch the Wallet UI (Optional)

```bash
# Serve Jekyll-based Swift Beta Wallet
cd wallet-ui/
bundle exec jekyll serve
```

---

## 🧠 Project Philosophy

Fadaka is more than a blockchain — it's a foundation for intelligent, secure, and future-ready systems. Built to integrate seamlessly with AI agents, decentralized apps, and dynamic contract workflows, Fadaka forms the core infrastructure of the **Web4 movement**.

---

## 🤝 Related Projects

* [SwiftBot](https://github.com/Web4application/swiftbot)
* [Web4Node](https://github.com/Web4application/web4node)
* [ProjectPilot AI](https://github.com/QUBUHUB-incs/projectpilot)
* [CertForge](https://github.com/Web4application/certforge)
* [Kubuverse](https://github.com/QUBUHUB-incs/kubuverse)

---

## 📜 License

MIT License © 2025 RODA
Feel free to fork, remix, or build on top of Fadaka — just don’t forget to give credit. 🔗

---

## 🌍 Join the Movement

Fadaka isn’t just software — it’s part of a vision for open, AI-powered, sovereign digital infrastructure.

**Build. Connect. Liberate.**

##L1

## 🪙 Fadaka Blockchain

> A secure, Go-based, Layer-1 blockchain powering the Web4 decentralized ecosystem.

[![Build Status](https://img.shields.io/github/actions/workflow/status/Web4application/fadaka/build.yml)](https://github.com/Web4application/fadaka/actions)
[![License](https://img.shields.io/github/license/Web4application/fadaka)](LICENSE)
[![Go Version](https://img.shields.io/badge/Go-1.22+-blue)](https://golang.org)

---

## 🧠 What is Fadaka?

**Fadaka** is a secure, AI-ready, Web4-compatible **Layer-1 blockchain** designed with:

- ⛓️ TLS-encrypted P2P networking
- ⚙️ Modular Go codebase
- 💡 Smart contract engine (proxy upgradeable, WASM/FVM-ready)
- 🔑 HD wallet support (BIP39/44)
- 🧪 Faucet, mining, and token tools
- 🧠 AI integration: alerting, analytics, assistant guidance
- 🔗 Built-in REST API + Web Wallet UI

It powers decentralized systems like
**FadakaCoin**
**Lola AI**
**Web4Node**
**RODAAI**

##and others.

---

## 📦 Project Structure

```
fadaka/
├── blockchain/          # Core blockchain node (Go)
├── api/                 # FastAPI backend for RPC + analytics
├── wallet-ui/           # Jekyll-based wallet frontend
├── faucet/              # CLI faucet tool
├── contracts/           # WASM/proxy smart contracts
├── certforge/           # TLS cert generator
├── swap-router/         # Token swap engine
├── .github/workflows/   # CI scripts
└── README.md

---
```

## 🚀 Getting Started

### 1. Clone the Repo

```bash
git clone https://github.com/Web4application/fadaka.git
cd fadaka

2. Run Blockchain Node

cd blockchain
go run ./cmd/main.go
```
3. Start API Backend (Python 3.11+)
```
cd api
pip install -r requirements.txt
uvicorn main:app --reload

```
4. Serve Wallet UI
```
cd wallet-ui
bundle install
bundle exec jekyll serve
```
Visit http://localhost:4000 to access your Fadaka Wallet

⸻

```
🧪 Test Wallet & Faucet

To generate wallets:

```bash
cd faucet
go run ./walletgen.go

```
Send coins using faucet CLI:

```
go run ./faucet.go --to=<wallet_address>

```
🧱 Smart Contracts

Contracts are built with upgradeable logic (proxy pattern):
```

mycontract.go
cd contracts
# Build WASM or Go plugin contracts
go build -buildmode=plugin -o mycontract.so
```
```
mycontract.go
```
Contract deploy & invoke handled via api/ or raw RPC calls.

⸻

🧠 AI Integration (Optional)

This repo supports integration with:
	•	Lola Assistant – notifications, summaries
	•	RODAAI – blockchain analytics, anomaly detection
	•	SwiftBot – on-chain assistant automation

⸻

🧰 Developer Notes
	•	Go Version: 1.22+
	•	Python: 3.11+
	•	Jekyll: 4.x
	•	TLS: Certificates generated via certforge/ or custom script
	•	RPC: Provided via /api/v1/rpc/* endpoints

⸻

🧑‍💻 Contributing
```

# Format Go code
gofmt -w .
# Run Python tests
cd api && pytest

Please fork, submit PRs, or open issues!

⸻
```

🛡 License

MIT License

⸻

🌐 Related Projects
	•	FadakaCoin – ERC-20 token + swap UI
	•	Web4App – Unified ecosystem
	•	RODAAI – Blockchain analytics
	•	Lola – Conversational agent

---

Here’s the file you can upload directly to the repo:  
📄 [`Fadaka_README_Improved.md`](sandbox:/mnt/data/Fadaka_README_Improved.md?_chatgptios_conversationID=688fb950-37a0-8000-985f-69e28ede4e33&_chatgptios_messageID=9360a687-e7f3-4e2b-8215-328544873f0b)

cd Docs/
```bash
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
