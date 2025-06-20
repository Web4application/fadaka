const crypto = require('crypto');

class TransactionValidator {
    static validateTransaction(transaction, senderBalance) {
        if (transaction.amount > senderBalance) {
            return false; // Not enough funds
        }
        return true;
    }

    static verifySignature(transaction, senderPublicKey) {
        const verify = crypto.createVerify('SHA256');
        verify.update(JSON.stringify(transaction));
        return verify.verify(senderPublicKey, transaction.signature, 'hex');
    }
}

module.exports = TransactionValidator;
