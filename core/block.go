package core

import (
	"bytes"
	"crypto/sha256"
	"encoding/gob"
	"encoding/hex"
	"time"
)

type Block struct {
	Index        int
	Timestamp    int64
	Transactions []Transaction
	PrevHash     string
	Hash         string
	Nonce        int
	Miner        string
}

func NewBlock(index int, txs []Transaction, prevHash, miner string) *Block {
	b := &Block{
		Index:        index,
		Timestamp:    time.Now().Unix(),
		Transactions: txs,
		PrevHash:     prevHash,
		Miner:        miner,
	}
	b.Hash = b.calculateHash()
	return b
}

func (b *Block) calculateHash() string {
	var txData bytes.Buffer
	_ = gob.NewEncoder(&txData).Encode(b.Transactions)

	data := []byte(
		string(b.Index) +
			string(b.Timestamp) +
			b.PrevHash +
			b.Miner +
			txData.String() +
			string(b.Nonce),
	)

	hash := sha256.Sum256(data)
	return hex.EncodeToString(hash[:])
}

func (b *Block) Mine(difficulty int) {
	target := bytes.Repeat([]byte("0"), difficulty)
	for {
		hash := b.calculateHash()
		if bytes.HasPrefix([]byte(hash), target) {
			b.Hash = hash
			break
		}
		b.Nonce++
	}
}
