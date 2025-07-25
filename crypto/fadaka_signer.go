package crypto

import (
	"crypto/ecdsa"
	"crypto/elliptic"
	crand "crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"math/big"
)

// FadakaKeyPair represents a secp256k1 keypair.
type FadakaKeyPair struct {
	PrivateKey *ecdsa.PrivateKey
	PublicKey  ecdsa.PublicKey
}

// GenerateKeyPair creates a new ECDSA secp256k1 keypair.
func GenerateKeyPair() (*FadakaKeyPair, error) {
	privKey, err := ecdsa.GenerateKey(elliptic.P256(), crand.Reader) // Swap with secp256k1 if using full lib
	if err != nil {
		return nil, err
	}
	return &FadakaKeyPair{
		PrivateKey: privKey,
		PublicKey:  privKey.PublicKey,
	}, nil
}

// SignMessage signs a message and returns r||s hex string.
func SignMessage(privateKey *ecdsa.PrivateKey, message []byte) (string, error) {
	hash := sha256.Sum256(message)
	r, s, err := ecdsa.Sign(crand.Reader, privateKey, hash[:])
	if err != nil {
		return "", err
	}
	return r.Text(16) + "|" + s.Text(16), nil
}

// VerifySignature verifies a signature given r||s and message.
func VerifySignature(pubKey ecdsa.PublicKey, message []byte, signature string) (bool, error) {
	parts := splitSignature(signature)
	if parts == nil {
		return false, errors.New("invalid signature format")
	}
	r, s := parts[0], parts[1]
	hash := sha256.Sum256(message)
	return ecdsa.Verify(&pubKey, hash[:], r, s), nil
}

// splitSignature parses "r|s" into *big.Ints.
func splitSignature(sig string) []*big.Int {
	parts := make([]*big.Int, 2)
	split := [2]string{}
	copy(split[:], splitSig(sig))

	if len(split[0]) == 0 || len(split[1]) == 0 {
		return nil
	}
	r := new(big.Int)
	s := new(big.Int)
	r.SetString(split[0], 16)
	s.SetString(split[1], 16)
	parts[0], parts[1] = r, s
	return parts
}

func splitSig(sig string) []string {
	return splitOnce(sig, "|")
}

func splitOnce(s, sep string) []string {
	i := -1
	for j := 0; j < len(s); j++ {
		if string(s[j]) == sep {
			i = j
			break
		}
	}
	if i == -1 {
		return []string{}
	}
	return []string{s[:i], s[i+1:]}
}
