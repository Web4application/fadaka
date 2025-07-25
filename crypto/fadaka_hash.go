package crypto

import (
	"crypto/sha256"
	"golang.org/x/crypto/sha3"
)

// HashType defines the supported hashing algorithm
type HashType int

const (
	SHA256 HashType = iota
	Keccak256
)

func Hash(data []byte, hashType HashType) []byte {
	switch hashType {
	case Keccak256:
		hash := sha3.NewLegacyKeccak256()
		hash.Write(data)
		return hash.Sum(nil)
	case SHA256:
		fallthrough
	default:
		hash := sha256.Sum256(data)
		return hash[:]
	}
}
