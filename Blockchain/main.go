package main

import (
    "crypto/sha256"
    "encoding/hex"
    "fmt"
    "strconv"
    "time"
)

type Block struct {
    Index     int
    Timestamp string
    Data      string
    PrevHash  string
    Hash      string
    Nonce     int
}

var Blockchain []Block

func calculateHash(block Block) string {
    record := strconv.Itoa(block.Index) + block.Timestamp + block.Data + block.PrevHash + strconv.Itoa(block.Nonce)
    h := sha256.New()
    h.Write([]byte(record))
    hashed := h.Sum(nil)
    return hex.EncodeToString(hashed)
}

func generateBlock(oldBlock Block, Data string) Block {
    var newBlock Block
    t := time.Now()

    newBlock.Index = oldBlock.Index + 1
    newBlock.Timestamp = t.String()
    newBlock.Data = Data
    newBlock.PrevHash = oldBlock.Hash
    newBlock.Nonce = 0

    for !isHashValid(newBlock.Hash) {
        newBlock.Nonce++
        newBlock.Hash = calculateHash(newBlock)
    }

    return newBlock
}

func isHashValid(hash string) bool {
    return hash[:4] == "0000"
}

func main() {
    genesisBlock := Block{0, time.Now().String(), "Genesis Block", "", "", 0}
    genesisBlock.Hash = calculateHash(genesisBlock)
    Blockchain = append(Blockchain, genesisBlock)

    newBlock := generateBlock(genesisBlock, "Web4asset Block")
    Blockchain = append(Blockchain, newBlock)

    for _, block := range Blockchain {
        fmt.Printf("Index: %d\n", block.Index)
        fmt.Printf("Timestamp: %s\n", block.Timestamp)
        fmt.Printf("Data: %s\n", block.Data)
        fmt.Printf("PrevHash: %s\n", block.PrevHash)
        fmt.Printf("Hash: %s\n", block.Hash)
        fmt.Printf("Nonce: %d\n", block.Nonce)
        fmt.Println()
    }
}
