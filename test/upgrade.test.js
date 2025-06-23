const CryptoUtils = require('./utils/CryptoUtils');
const Transaction = require('./blockchain/Transaction');
const Blockchain = require('./blockchain/Blockchain');

// Generate key pair
const { publicKey, privateKey } = CryptoUtils.generateKeyPair();
const blockchain = new Blockchain();

// Create a transaction
const transaction = new Transaction(publicKey, '0x456', 50);

// Sign the transaction
transaction.signTransaction(privateKey);
console.log('Transaction Signature:', transaction.signature);

// Verify the transaction
const isTransactionValid = transaction.verifyTransaction();
console.log('Is Transaction Valid?', isTransactionValid);

// Add the transaction to the blockchain
if (isTransactionValid) {
    blockchain.addTransaction(transaction);
    console.log('Transaction added to the blockchain.');
} else {
    console.log('Transaction verification failed.');
}

// Mine the transactions
blockchain.minePendingTransactions('0x123');

// Check balance of the receiver
console.log('Balance of receiver:', blockchain.getBalanceOfAddress('0x456'));

const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("FadakaToken Upgrade", function () {
  it("should upgrade to V2 and retain state", async function () {
    const [deployer] = await ethers.getSigners();

    const FadakaToken = await ethers.getContractFactory("FadakaTokenV2");
    const proxy = await upgrades.deployProxy(FadakaToken, [], {
      initializer: "initialize",
    });

    const proxyAddress = await proxy.getAddress();
    expect(await proxy.name()).to.equal("FadakaToken");

    const FadakaTokenV2 = await ethers.getContractFactory("FadakaTokenV2");
    const upgraded = await upgrades.upgradeProxy(proxyAddress, FadakaTokenV2);

    expect(await upgraded.version()).to.equal("Fadaka v2.0 - With Roles");
  });
});
