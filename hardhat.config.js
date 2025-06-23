require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
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
