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

func calculateHash(block Block) string {
    record := strconv.Itoa(block.Index) + block.Timestamp + block.Data + block.PrevHash + strconv.Itoa(block.Nonce)
    h := sha256.New()
    h.Write([]byte(record))
    return hex.EncodeToString(h.Sum(nil))
}

func isHashValid(hash string) bool {
    return hash[:4] == "0000"
}

func generateBlock(oldBlock Block, Data string) Block {
    var newBlock Block
    t := time.Now()

    newBlock.Index = oldBlock.Index + 1
    newBlock.Timestamp = t.String()
    newBlock.Data = Data
    newBlock.PrevHash = oldBlock.Hash
    newBlock.Nonce = 0

    for {
        newBlock.Hash = calculateHash(newBlock)
        if isHashValid(newBlock.Hash) {
            break
        }
        newBlock.Nonce++
    }

    return newBlock
}

func main() {
    genesisBlock := Block{0, time.Now().String(), "Genesis Block", "", "", 0}
    genesisBlock.Hash = calculateHash(genesisBlock)
    fmt.Println("Genesis Block:", genesisBlock)

    newBlock := generateBlock(genesisBlock, "Fadaka Chain Begins")
    fmt.Println("New Block:", newBlock)
}
