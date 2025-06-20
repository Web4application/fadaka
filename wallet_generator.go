package main

import (
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/sha256"
	"crypto/sha512"
	"encoding/hex"
	"fmt"
	"os"
)

func main() {
	// Generate a new private key
	priv, err := ecdsa.GenerateKey(elliptic.P384(), rand.Reader)
	if err != nil {
		fmt.Println("Error generating private key:", err)
		return
	}

	// Generate public key from the private key
	pub := priv.PublicKey

	// Create a wallet address (using public key and hashing)
	walletAddress := generateWalletAddress(pub)

	// Save the private key and wallet address
	savePrivateKey(priv)
	saveWalletAddress(walletAddress)

	fmt.Println("Wallet Address:", walletAddress)
	fmt.Println("Private Key saved to file: private.key")
}

// generateWalletAddress hashes the public key to generate a wallet address
func generateWalletAddress(pub ecdsa.PublicKey) string {
	// The Ethereum-like process (hash the public key with SHA256 and then RIPEMD160)
	pubBytes := append(pub.X.Bytes(), pub.Y.Bytes()...)
	hash := sha256.New()
	hash.Write(pubBytes)
	shaHash := hash.Sum(nil)

	// You can add more sophisticated methods like RIPEMD160 here, but for simplicity:
	address := sha512.New()
	address.Write(shaHash)

	return hex.EncodeToString(address.Sum(nil)[:20]) // First 20 bytes are used for the address
}

// savePrivateKey saves the private key to a file
func savePrivateKey(priv *ecdsa.PrivateKey) {
	privBytes := priv.D.Bytes()

	file, err := os.Create("private.key")
	if err != nil {
		fmt.Println("Error saving private key:", err)
		return
	}
	defer file.Close()

	file.Write(privBytes)
}

// saveWalletAddress saves the wallet address to a file
func saveWalletAddress(address string) {
	file, err := os.Create("walletAddress.txt")
	if err != nil {
		fmt.Println("Error saving wallet address:", err)
		return
	}
	defer file.Close()

	file.WriteString(address)
}
