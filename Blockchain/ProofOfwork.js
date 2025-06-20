class ProofOfWork {
    constructor(blockchain) {
        this.blockchain = blockchain;
        this.difficulty = 4; // Difficulty level (how many leading zeros required)
    }

    mineBlock(block) {
        let hash = block.calculateHash();
        while (!hash.startsWith('0'.repeat(this.difficulty))) { // Difficulty level with leading zeros
            block.timestamp++;
            hash = block.calculateHash();
        }
        console.log(`Block mined: ${hash}`);
        return hash;
    }
}

module.exports = ProofOfWork;
