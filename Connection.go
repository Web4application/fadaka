package main

import (
	"bufio"
	"fmt"
	"net"
	"os"
	"strings"
	"sync"
)

// List of known peers
var peers = make(map[string]net.Conn)
var mutex = &sync.Mutex{}

// Broadcasts message to all connected peers
func broadcast(sender net.Conn, message string) {
	mutex.Lock()
	defer mutex.Unlock()

	for _, conn := range peers {
		if conn != sender {
			fmt.Fprintf(conn, "%s\n", message)
		}
	}
}

// Handles a peer's connection (receive messages)
func handlePeerConnection(conn net.Conn) {
	defer conn.Close()

	reader := bufio.NewReader(conn)

	// Ask for name when a peer connects
	conn.Write([]byte("Enter your name: "))
	name, err := reader.ReadString('\n')
	if err != nil {
		return
	}
	name = strings.TrimSpace(name)

	// Add peer to the list
	mutex.Lock()
	peers[name] = conn
	mutex.Unlock()

	fmt.Println(name, "joined the chat")
	broadcast(conn, fmt.Sprintf("%s has joined the chat", name))

	// Receive and broadcast messages
	for {
		message, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println(name, "disconnected")
			mutex.Lock()
			delete(peers, name)
			mutex.Unlock()
			broadcast(conn, fmt.Sprintf("%s has left the chat", name))
			return
		}

		msg := fmt.Sprintf("%s: %s", name, strings.TrimSpace(message))
		fmt.Println(msg)
		broadcast(conn, msg)
	}
}

// Start the P2P chat
func startP2PChat(port string) {
	ln, err := net.Listen("tcp", ":"+port)
	if err != nil {
		fmt.Println("Error starting chat:", err)
		os.Exit(1)
	}
	defer ln.Close()

	fmt.Println("P2P chat started on port", port)

	for {
		conn, err := ln.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}

		// Handle incoming peer connection
		go handlePeerConnection(conn)
	}
}

// Connect to another peer (client mode)
func connectToPeer(address string) {
	conn, err := net.Dial("tcp", address)
	if err != nil {
		fmt.Println("Error connecting to peer:", err)
		return
	}
	defer conn.Close()

	fmt.Println("Connected to", address)

	// Start receiving messages from this peer
	go func() {
		reader := bufio.NewReader(conn)
		for {
			message, err := reader.ReadString('\n')
			if err != nil {
				fmt.Println("Disconnected from peer.")
				os.Exit(0)
			}
			fmt.Print(message)
		}
	}()

	// Send user input to this peer
	stdinReader := bufio.NewReader(os.Stdin)
	for {
		text, err := stdinReader.ReadString('\n')
		if err != nil {
			return
		}
		fmt.Fprintf(conn, text)
	}
}

// Main entry point
func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage:")
		fmt.Println("  go run main.go peer [port]")
		fmt.Println("  go run main.go connect [address:port]")
		return
	}

	mode := os.Args[1]

	if mode == "peer" {
		if len(os.Args) != 3 {
			fmt.Println("Please specify a port.")
			return
		}
		port := os.Args[2]
		startP2PChat(port)
	} else if mode == "connect" {
		if len(os.Args) != 3 {
			fmt.Println("Please specify an address:port to connect.")
			return
		}
		address := os.Args[2]
		connectToPeer(address)
	} else {
		fmt.Println("Unknown mode:", mode)
	}
}
