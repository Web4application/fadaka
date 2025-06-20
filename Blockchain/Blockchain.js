const Block = require('./Block');
const Transaction = require('./Transaction');
const ProofOfWork = require('./ProofOfWork');
const CryptoUtils = require('../utils/CryptoUtils');
const config = require('../config/config');

class Blockchain {
    constructor() {
        this.chain = [this.createGenesisBlock()];
        this.pendingTransactions = [];
        this.miningReward = config.blockchain.miningReward;
    }

    /**
     * Create the Genesis Block (first block of the blockchain)
     * @returns {Block} - The genesis block
     */
    createGenesisBlock() {
        const genesisData = {
            sender: "0x0000",
            receiver: "0x0000",
            amount: 0,
        };

        return new Block(0, Date.now(), genesisData, "0");
    }

    /**
     * Get the latest block in the chain
     * @returns {Block} - The latest block
     */
    getLatestBlock() {
        return this.chain[this.chain.length - 1];
    }

    /**
     * Add a new transaction to the list of pending transactions
     * @param {Transaction} transaction - The transaction object
     */
    addTransaction(transaction) {
        // Verify the transaction signature
        const isValid = CryptoUtils.verifySignature(
            transaction.sender,
            transaction,
            transaction.signature
        );

        if (!isValid) {
            throw new Error('Transaction signature is invalid.');
        }

        this.pendingTransactions.push(transaction);
    }

    /**
     * Mine pending transactions and reward the miner
     * @param {string} miningRewardAddress - The address of the miner
     */
    minePendingTransactions(miningRewardAddress) {
        const proofOfWork = new ProofOfWork(this);
        const newBlock = new Block(
            this.chain.length,
            Date.now(),
            this.pendingTransactions,
            this.getLatestBlock().hash
        );

        newBlock.hash = proofOfWork.mineBlock(newBlock);
        this.chain.push(newBlock);

        // Reward the miner
        const rewardTransaction = new Transaction(null, miningRewardAddress, this.miningReward, null);
        this.pendingTransactions = [rewardTransaction];
    }

    /**
     * Get the balance of a specific address
     * @param {string} address - The wallet address
     * @returns {number} - The balance
     */
    getBalanceOfAddress(address) {
        let balance = 0;

        for (const block of this.chain) {
            for (const transaction of block.data) {
                if (transaction.sender === address) {
                    balance -= transaction.amount;
                }
                if (transaction.receiver === address) {
                    balance += transaction.amount;
                }
            }
        }

        return balance;
    }

    /**
     * Verify the integrity of the blockchain
     * @returns {boolean} - True if valid, false otherwise
     */
    isChainValid() {
        for (let i = 1; i < this.chain.length; i++) {
            const currentBlock = this.chain[i];
            const previousBlock = this.chain[i - 1];

            if (currentBlock.hash !== currentBlock.calculateHash()) {
                return false;
            }

            if (currentBlock.previousHash !== previousBlock.hash) {
                return false;
            }
        }
        return true;
    }
}

module.exports = Blockchain;
