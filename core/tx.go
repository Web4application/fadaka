package core

import (
	"crypto/ecdsa"
	"encoding/json"
	"errors"
	"fadaka/crypto"
	"time"
)

// Transaction represents a Fadaka blockchain transaction.
type Transaction struct {
	From      string `json:"from"`
	To        string `json:"to"`
	Value     uint64 `json:"value"`
	Nonce     uint64 `json:"nonce"`
	Timestamp int64  `json:"timestamp"`
	Signature string `json:"signature"` // r|s in hex
}

// NewTransaction creates a new unsigned transaction.
func NewTransaction(from, to string, value, nonce uint64) *Transaction {
	return &Transaction{
		From:      from,
		To:        to,
		Value:     value,
		Nonce:     nonce,
		Timestamp: time.Now().Unix(),
	}
}

// Serialize returns the JSON-encoded message to be signed (excluding signature).
func (tx *Transaction) Serialize() ([]byte, error) {
	// Create a clone with empty signature
	copyTx := *tx
	copyTx.Signature = ""
	return json.Marshal(copyTx)
}

// Sign signs the transaction using the given private key.
func (tx *Transaction) Sign(privKey *ecdsa.PrivateKey) error {
	data, err := tx.Serialize()
	if err != nil {
		return err
	}
	sig, err := crypto.SignMessage(privKey, data)
	if err != nil {
		return err
	}
	tx.Signature = sig
	return nil
}

// Verify checks if the transaction signature is valid for the given public key.
func (tx *Transaction) Verify(pubKey ecdsa.PublicKey) (bool, error) {
	if tx.Signature == "" {
		return false, errors.New("no signature to verify")
	}
	data, err := tx.Serialize()
	if err != nil {
		return false, err
	}
	return crypto.VerifySignature(pubKey, data, tx.Signature)
}
