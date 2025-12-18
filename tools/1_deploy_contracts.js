const Fadaka = artifacts.require("Fadaka");

module.exports = function (deployer) {
  deployer.deploy(Fadaka, 1000000000);
};
