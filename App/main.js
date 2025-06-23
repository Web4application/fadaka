const express = require('express');
const bodyParser = require('body-parser');
const Blockchain = require('../blockchain/Blockchain');
const Transaction = require('../blockchain/Transaction');
const Wallet = require('../wallet/Wallet');
const TransactionValidator = require('../wallet/TransactionValidator');

const app = express();
app.use(bodyParser.json());

const blockchain = new Blockchain();
const myWallet = new Wallet();

const config = require('./config/config');
const express = require('express');
const app = express();

// Use API port configuration
const port = config.api.port;

app.listen(port, () => {
    console.log(`API server running on port ${port}`);
});

// Send Fadaka Coins
app.post('/sendTransaction', (req, res) => {
    const { sender, receiver, amount } = req.body;
    const transaction = new Transaction(sender, receiver, amount);

    // Sign the transaction with the wallet's private key
    transaction.signature = myWallet.signTransaction(transaction);

    // Validate the transaction
    if (!TransactionValidator.validateTransaction(transaction, blockchain.getBalanceOfAddress(sender))) {
        return res.status(400).json({ message: 'Insufficient funds' });
    }

    if (!TransactionValidator.verifySignature(transaction, sender)) {
        return res.status(400).json({ message: 'Invalid signature' });
    }

    blockchain.addTransaction(transaction);
    res.status(200).json({ message: 'Transaction added successfully' });
});

// Mine Pending Transactions
app.post('/mine', (req, res) => {
    const { miningRewardAddress } = req.body;
    blockchain.minePendingTransactions(miningRewardAddress);
    res.status(200).json({ message: 'Mining complete' });
});

// Check Balance
app.get('/balance/:address', (req, res) => {
    const balance = blockchain.getBalanceOfAddress(req.params.address);
    res.status(200).json({ balance });
});

// Start the Server
app.listen(8080, () => {
    console.log('Blockchain API is running on http://localhost:5000');
});
