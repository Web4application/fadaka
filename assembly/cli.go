package main

import (
    "encoding/hex"
    "fmt"
    "os"
    "fadaka/assembly"
)

func main() {
    if len(os.Args) < 3 || os.Args[1] != "decode" {
        fmt.Println("Usage: fadakaasm decode --bytecode 0x...")
        return
    }

    hexData := os.Args[2]
    if hexData[:2] == "0x" {
        hexData = hexData[2:]
    }

    bytecode, err := hex.DecodeString(hexData)
    if err != nil {
        fmt.Println("Invalid bytecode:", err)
        return
    }

    assembly.DecodeBytecode(bytecode)
}
