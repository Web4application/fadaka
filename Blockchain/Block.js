const crypto = require('crypto');

class Block {
    constructor(index, timestamp, data, previousHash = '') {
        this.index = index;
        this.timestamp = timestamp;
        this.data = data; // Transaction data
        this.previousHash = previousHash;
        this.hash = this.calculateHash();
    }

    calculateHash() {
        return crypto.createHash('sha256').update(this.index + this.previousHash + this.timestamp + JSON.stringify(this.data)).digest('hex');
    }
}

module.exports = Block;
