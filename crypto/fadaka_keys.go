package crypto

import (
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"math/big"
)

type FadakaKeyPair struct {
	PrivateKey *ecdsa.PrivateKey
	PublicKey  ecdsa.PublicKey
}

func NewKeyPair() (*FadakaKeyPair, error) {
	priv, err := ecdsa.GenerateKey(elliptic.P256(), rand.Reader) // You can replace with secp256k1 if needed
	if err != nil {
		return nil, err
	}
	return &FadakaKeyPair{
		PrivateKey: priv,
		PublicKey:  priv.PublicKey,
	}, nil
}

func (kp *FadakaKeyPair) Sign(data []byte) (r, s *big.Int, err error) {
	hash := sha256.Sum256(data)
	return ecdsa.Sign(rand.Reader, kp.PrivateKey, hash[:])
}

func (kp *FadakaKeyPair) Verify(data []byte, r, s *big.Int) bool {
	hash := sha256.Sum256(data)
	return ecdsa.Verify(&kp.PublicKey, hash[:], r, s)
}

func (kp *FadakaKeyPair) Address() string {
	pubBytes := append(kp.PublicKey.X.Bytes(), kp.PublicKey.Y.Bytes()...)
	addrHash := sha256.Sum256(pubBytes)
	return hex.EncodeToString(addrHash[len(addrHash)-20:])
}
