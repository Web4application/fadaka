class Blockchain {
  constructor() {
    this.chain = [this.createGenesisBlock()];
    this.difficulty = 4; // Define difficulty
  }

  mineBlock(newBlock) {
    let nonce = 0;
    let hash = this.calculateHash(newBlock.index, newBlock.previousHash, newBlock.timestamp, newBlock.data, nonce);
    while (!hash.startsWith('0'.repeat(this.difficulty))) {
      nonce++;
      hash = this.calculateHash(newBlock.index, newBlock.previousHash, newBlock.timestamp, newBlock.data, nonce);
    }
    return { hash, nonce };
  }

  calculateHash(index, previousHash, timestamp, data, nonce) {
    return `${index}${previousHash}${timestamp}${data}${nonce}`;
  }

  addBlock(newBlock) {
    newBlock.previousHash = this.getLatestBlock().hash;
    const minedData = this.mineBlock(newBlock);
    newBlock.hash = minedData.hash;
    this.chain.push(newBlock);
  }
}

