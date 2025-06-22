package main

import (
    "crypto/ecdsa"
    "crypto/ecdsa"
    "crypto/elliptic"
    "crypto/rand"
    "crypto/sha256"
    "crypto/x509"
    "crypto/x509/pkix"
    "math/big"
    "os"
    "time"
)

func main() {
    priv, _ := ecdsa.GenerateKey(elliptic.P384(), rand.Reader)
    cert := &x509.Certificate{
        SerialNumber: big.NewInt(1),
        Subject: pkix.Name{
            Organization: []string{"Fadaka"},
        },
        NotBefore: time.Now(),
        NotAfter: time.Now().Add(365 * 24 * time.Hour),
        KeyUsage: x509.KeyUsageKeyEncipherment | x509.KeyUsageDigitalSignature,
        ExtKeyUsage: []x509.ExtKeyUsage{x509.ExtKeyUsageServerAuth, x509.ExtKeyUsageClientAuth},
    }
    certBytes, err := x509.CreateCertificate(rand.Reader, cert, cert, &priv.PublicKey, priv)
    if err != nil {
        panic(err)
    }
    certFile, _ := os.Create("server.crt")
    certFile.Write(certBytes)
    certFile.Close()

    privFile, _ := os.Create("server.key")
    privFile.Write([]byte(priv))
    privFile.Close()
}
