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

