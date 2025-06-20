const crypto = require('crypto');

class Wallet {
    constructor() {
        this.generateKeyPair();
    }

    generateKeyPair() {
        const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', {
            modulusLength: 2048, // Key length
        });
        this.publicKey = publicKey.export({ type: 'pkcs1', format: 'pem' });
        this.privateKey = privateKey.export({ type: 'pkcs1', format: 'pem' });
    }

    signTransaction(transaction) {
        const sign = crypto.createSign('SHA256');
        sign.update(JSON.stringify(transaction));
        return sign.sign(this.privateKey, 'hex');
    }
}

module.exports = Wallet;
