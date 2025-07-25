package crypto

import (
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"math/big"
)

type Signature struct {
	R *big.Int
	S *big.Int
}

// Signer defines the interface for digital signature operations.
type Signer interface {
	Sign(data []byte) (*Signature, error)
	Verify(data []byte, sig *Signature) bool
	Address() string
	PublicKey() *ecdsa.PublicKey
}

// FadakaSigner implements the Signer interface using ECDSA
type FadakaSigner struct {
	privateKey *ecdsa.PrivateKey
}

func NewFadakaSigner(priv *ecdsa.PrivateKey) *FadakaSigner {
	return &FadakaSigner{privateKey: priv}
}

func GenerateFadakaSigner() (*FadakaSigner, error) {
	priv, err := ecdsa.GenerateKey(elliptic.P256(), randReader())
	if err != nil {
		return nil, err
	}
	return NewFadakaSigner(priv), nil
}

func (s *FadakaSigner) Sign(data []byte) (*Signature, error) {
	hash := sha256.Sum256(data)
	r, sigS, err := ecdsa.Sign(randReader(), s.privateKey, hash[:])
	if err != nil {
		return nil, err
	}
	return &Signature{R: r, S: sigS}, nil
}

func (s *FadakaSigner) Verify(data []byte, sig *Signature) bool {
	hash := sha256.Sum256(data)
	return ecdsa.Verify(&s.privateKey.PublicKey, hash[:], sig.R, sig.S)
}

func (s *FadakaSigner) Address() string {
	pub := s.privateKey.PublicKey
	pubBytes := append(pub.X.Bytes(), pub.Y.Bytes()...)
	addrHash := sha256.Sum256(pubBytes)
	return hex.EncodeToString(addrHash[len(addrHash)-20:])
}

func (s *FadakaSigner) PublicKey() *ecdsa.PublicKey {
	return &s.privateKey.PublicKey
}

func randReader() *RandomReader {
	return &RandomReader{}
}

type RandomReader struct{}

func (r *RandomReader) Read(p []byte) (n int, err error) {
	return rand.Read(p)
}
