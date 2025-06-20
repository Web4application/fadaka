package main

import (
    "time"
)

type Transaction struct {
    Sender    string
    Receiver  string
    Amount    int
    Timestamp string
}

func createTransaction(sender, receiver string, amount int) Transaction {
    return Transaction{
        Sender:    sender,
        Receiver:  receiver,
        Amount:    amount,
        Timestamp: time.Now().String(),
    }
}

func validateTransaction(tx Transaction) bool {
    // Add validation logic (e.g., check balances, signatures)
    return true
}
