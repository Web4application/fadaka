package main

import (
	"crypto/tls"
	"fmt"
	"net"
	"os"
	"os/exec"
	"sync"
)

var peers = make(map[string]string)
var mutex = &sync.Mutex{}

// Generate TLS certificates using OpenSSL
func generateTLSCerts() error {
	cmd := exec.Command("openssl", "req", "-x509", "-newkey", "rsa:4096", "-keyout", "server.key", "-out", "server.crt", "-days", "365", "-nodes",
		"-subj", "/CN=fadaka-blockchain")
	cmd.Stdout = nil
	cmd.Stderr = nil
	err := cmd.Run()
	if err != nil {
		return fmt.Errorf("❌ Failed to generate TLS certs: %v", err)
	}
	fmt.Println("🔐 TLS certificates generated successfully")
	return nil
}

// Register a peer in the network
func registerPeer(name, address string) {
	mutex.Lock()
	defer mutex.Unlock()
	peers[name] = address
	fmt.Printf("🔗 Registered peer: %s at %s\n", name, address)
}

// Get all registered peers
func getPeers() map[string]string {
	mutex.Lock()
	defer mutex.Unlock()
	copy := make(map[string]string)
	for k, v := range peers {
		copy[k] = v
	}
	return copy
}

// TLS-secured registry server
func startSecureRegistryServer(address string) {
	cert, err := tls.LoadX509KeyPair("server.crt", "server.key")
	if err != nil {
		fmt.Println("❌ Error loading TLS certificates:", err)
		os.Exit(1)
	}

	config := &tls.Config{Certificates: []tls.Certificate{cert}}
	ln, err := tls.Listen("tcp", address, config)
	if err != nil {
		fmt.Println("❌ Error starting TLS server:", err)
		os.Exit(1)
	}
	defer ln.Close()

	fmt.Println("✅ Secure Registry Server started on", address)

	for {
		conn, err := ln.Accept()
		if err != nil {
			fmt.Println("⚠️ Error accepting connection:", err)
			continue
		}
		go handleRegistryConnection(conn)
	}
}

// Handle incoming peer commands
func handleRegistryConnection(conn net.Conn) {
	defer conn.Close()
	buffer := make([]byte, 1024)

	n, err := conn.Read(buffer)
	if err != nil {
		return
	}

	message := string(buffer[:n])
	switch message {
	case "register":
		conn.Write([]byte("Send your name:"))
		n, _ = conn.Read(buffer)
		name := string(buffer[:n])

		conn.Write([]byte("Send your address:"))
		n, _ = conn.Read(buffer)
		address := string(buffer[:n])

		registerPeer(name, address)
		conn.Write([]byte("✅ Registration successful\n"))

	case "getPeers":
		peerList := getPeers()
		for name, addr := range peerList {
			conn.Write([]byte(fmt.Sprintf("%s - %s\n", name, addr)))
		}

	default:
		conn.Write([]byte("❓ Unknown command\n"))
	}
}

// Entry point
func main() {
	if _, err := os.Stat("server.crt"); os.IsNotExist(err) {
		fmt.Println("📦 TLS certs not found. Generating...")
		if err := generateTLSCerts(); err != nil {
			fmt.Println(err)
			return
		}
	}

	startSecureRegistryServer(":9443")
}
