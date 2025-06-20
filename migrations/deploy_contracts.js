const Fadaka = artifacts.require("Fadaka");

module.exports = function (deployer) {
  deployer.deploy(Fadaka, 10000000000);
};
