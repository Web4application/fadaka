module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*",
    },
    web4asset: {
      provider: () => new Web3.providers.HttpProvider("http://localhost:8545"),
      network_id: "1234",  // Web4Asset's network ID
      gas: 4500000,
    }
  },
  compilers: {
    solc: {
      version: "^0.4.17",  // Your Solidity version
    }
  }
};
