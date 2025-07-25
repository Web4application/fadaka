package main

import (
	"crypto/ecdsa"
	"encoding/json"
	"fadaka/core"
	"fadaka/crypto"
	"fmt"
	"log"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: fadaka_keys [generate|sign|verify] [args...]")
		return
	}

	switch os.Args[1] {
	case "generate":
		handleGenerate()

	case "sign":
		if len(os.Args) < 4 {
			log.Fatal("Usage: fadaka_keys sign <private_key_file> <tx_file.json>")
		}
		handleSign(os.Args[2], os.Args[3])

	case "verify":
		if len(os.Args) < 4 {
			log.Fatal("Usage: fadaka_keys verify <public_key_file> <tx_file.json>")
		}
		handleVerify(os.Args[2], os.Args[3])

	default:
		fmt.Println("Unknown command:", os.Args[1])
	}
}

func handleGenerate() {
	priv, pub := crypto.GenerateKeyPair()
	err := crypto.SavePrivateKey("fadaka_private.pem", priv)
	if err != nil {
		log.Fatal("Error saving private key:", err)
	}
	err = crypto.SavePublicKey("fadaka_public.pem", &pub)
	if err != nil {
		log.Fatal("Error saving public key:", err)
	}
	fmt.Println("✔ Keypair saved as fadaka_private.pem and fadaka_public.pem")
}

func handleSign(privPath, txPath string) {
	privKey, err := crypto.LoadPrivateKey(privPath)
	if err != nil {
		log.Fatal("Invalid private key:", err)
	}

	data, err := os.ReadFile(txPath)
	if err != nil {
		log.Fatal("Cannot read tx file:", err)
	}

	var tx core.Transaction
	if err := json.Unmarshal(data, &tx); err != nil {
		log.Fatal("Invalid tx format:", err)
	}

	if err := tx.Sign(privKey); err != nil {
		log.Fatal("Signing failed:", err)
	}

	updatedTx, _ := json.MarshalIndent(tx, "", "  ")
	os.WriteFile("signed_tx.json", updatedTx, 0644)
	fmt.Println("✅ Transaction signed and saved as signed_tx.json")
}

func handleVerify(pubPath, txPath string) {
	pubKey, err := crypto.LoadPublicKey(pubPath)
	if err != nil {
		log.Fatal("Invalid public key:", err)
	}

	data, err := os.ReadFile(txPath)
	if err != nil {
		log.Fatal("Cannot read tx file:", err)
	}

	var tx core.Transaction
	if err := json.Unmarshal(data, &tx); err != nil {
		log.Fatal("Invalid tx format:", err)
	}

	valid, err := tx.Verify(*pubKey)
	if err != nil {
		log.Fatal("Verification error:", err)
	}

	if valid {
		fmt.Println("✅ Signature is valid.")
	} else {
		fmt.Println("❌ Signature is invalid.")
	}
}
