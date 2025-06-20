const CryptoUtils = require('../utils/CryptoUtils');

class Transaction {
    /**
     * Constructor for a Transaction object
     * @param {string} sender - Sender's public key
     * @param {string} receiver - Receiver's public key
     * @param {number} amount - Amount to transfer
     * @param {string} signature - Signature of the transaction
     */
    constructor(sender, receiver, amount, signature = null) {
        this.sender = sender;
        this.receiver = receiver;
        this.amount = amount;
        this.signature = signature;
    }

    /**
     * Sign the transaction using the sender's private key
     * @param {string} privateKey - Sender's private key
     */
    signTransaction(privateKey) {
        const transactionData = {
            sender: this.sender,
            receiver: this.receiver,
            amount: this.amount,
        };

        this.signature = CryptoUtils.signData(privateKey, transactionData);
    }

    /**
     * Verify the transaction signature
     * @returns {boolean} - True if valid, false otherwise
     */
    verifyTransaction() {
        if (!this.sender || !this.signature) {
            throw new Error('Transaction is not properly signed.');
        }

        return CryptoUtils.verifySignature(this.sender, this, this.signature);
    }
}

module.exports = Transaction;

