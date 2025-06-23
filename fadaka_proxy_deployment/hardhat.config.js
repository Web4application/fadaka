require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    fadaka: {
      url: process.env.RPC_URL,
      accounts: [process.env.PRIVATE_KEY]
    },
  },
};
