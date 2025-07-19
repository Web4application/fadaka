class Block {
  constructor(index, previousHash, timestamp, data, hash) {
    this.index = index;
    this.previousHash = previousHash;
    this.timestamp = timestamp;
    this.data = data;
    this.hash = hash;
  }
}

class Blockchain {
  constructor() {
    this.chain = [this.createGenesisBlock()];
  }

  createGenesisBlock() {
    return new Block(0, "0", Date.now(), "Genesis Block", this.calculateHash(0, "0", Date.now(), "Genesis Block"));
  }

  getLatestBlock() {
    return this.chain[this.chain.length - 1];
  }

  addBlock(newBlock) {
    newBlock.previousHash = this.getLatestBlock().hash;
    newBlock.hash = this.calculateHash(newBlock.index, newBlock.previousHash, newBlock.timestamp, newBlock.data);
    this.chain.push(newBlock);
  }

  calculateHash(index, previousHash, timestamp, data) {
    return `${index}${previousHash}${timestamp}${data}`; // Use a more complex hash algorithm (SHA-256) for production
  }

  isValid() {
    for (let i = 1; i < this.chain.length; i++) {
      const currentBlock = this.chain[i];
      const previousBlock = this.chain[i - 1];

      if (currentBlock.previousHash !== previousBlock.hash) return false;
      if (currentBlock.hash !== this.calculateHash(currentBlock.index, currentBlock.previousHash, currentBlock.timestamp, currentBlock.data)) return false;
    }
    return true;
  }
}

// Example Usage:
let fadakaBlockchain = new Blockchain();
fadakaBlockchain.addBlock(new Block(1, "", Date.now(), "First Transaction", ""));
fadakaBlockchain.addBlock(new Block(2, "", Date.now(), "Second Transaction", ""));
console.log(fadakaBlockchain);
