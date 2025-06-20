require("@nomiclabs/hardhat-ethers");
require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan"); // Optional if Fadaka supports verification
require("hardhat-contract-sizer")
require("@typechain/hardhat");

module.exports = {
  solidity: "0.8.21",
  networks: {
    fadaka: {
      url: process.env.FADAKA_RPC_URL,
      accounts: [process.env.FADAKA_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.FADAKA_EXPLORER_API_KEY || "" // Optional
  },
  contractSizer: {
    runOnCompile: true,
    strict: false,
    only: []
  }
};

module.exports = {
  solidity: "0.8.21",
  networks: {
    fadaka: {
      url: "https://rpc.fadaka.chain",  // Replace with your Fadaka RPC
      accounts: ["0xYOUR_PRIVATE_KEY"] // Never commit this key!
    }
  }
};

module.exports = {
  solidity: "0.8.21",
  defaultNetwork: "fadakaTestnet",
  networks: {
    fadakaTestnet: {
      url: process.env.FADAKA_TESTNET_RPC,
      accounts: [process.env.FADAKA_PRIVATE_KEY]
    },
    fadakaMainnet: {
      url: process.env.FADAKA_MAINNET_RPC,
      accounts: [process.env.FADAKA_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.FADAKA_EXPLORER_API_KEY || ""
  },
  contractSizer: {
    runOnCompile: true,
    strict: false
  },
  typechain: {
    outDir: "types",
    target: "ethers-v6"
  }
};

networks: {
  fadaka: {
    url: "https://rpc.fadaka.io",
    accounts: [PRIVATE_KEY_HERE]
  }
}
