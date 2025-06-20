class Transaction {
  constructor(sender, recipient, amount) {
    this.sender = sender;
    this.recipient = recipient;
    this.amount = amount;
    this.timestamp = Date.now();
  }
}

class Blockchain {
  constructor() {
    this.transactions = [];
  }

  addTransaction(transaction) {
    // Validate transaction
    if (!transaction.sender || !transaction.recipient || transaction.amount <= 0) {
      throw new Error("Invalid transaction");
    }
    this.transactions.push(transaction);
  }

  getTransactions() {
    return this.transactions;
  }
}
