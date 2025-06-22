package main

import (
    "bufio"
    "crypto/tls"
    "fmt"
    "io"
    "net"
)

func handlePeerConnection(conn net.Conn) {
    defer conn.Close()

    tlsConn, ok := conn.(*tls.Conn)
    if !ok {
        fmt.Println("Not a valid TLS connection")
        return
    }

    err := tlsConn.Handshake()
    if err != nil {
        fmt.Println("TLS handshake error:", err)
        return
    }

    fmt.Println("New peer connected from:", conn.RemoteAddr())

    reader := bufio.NewReader(tlsConn)
    for {
        message, err := reader.ReadString('\n')
        if err == io.EOF {
            fmt.Println("Peer disconnected:", conn.RemoteAddr())
            break
        } else if err != nil {
            fmt.Println("Read error:", err)
            break
        }

        fmt.Printf("Message from %s: %s", conn.RemoteAddr(), message)
        // You can add message handling logic here, e.g., parse JSON commands or broadcast.
    }
}
