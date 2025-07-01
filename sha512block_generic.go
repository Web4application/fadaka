package main

import (
    "crypto/blake2b"
    "fmt"
)

func main() {
    // Create a new BLAKE2b hash
    hash, err := blake2b.New256(nil) // 256-bit output
    if err != nil {
        fmt.Println("Error creating hash:", err)
        return
    }

    // Write data to the hash
    data := []byte("Hello, Fadaka Blockchain!")
    hash.Write(data)

    // Compute the resulting hash
    hashedData := hash.Sum(nil)
    fmt.Printf("BLAKE2b Hash: %x\n", hashedData)
}
