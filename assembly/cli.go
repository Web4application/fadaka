package main

import (
    "encoding/hex"
    "fmt"
    "os"
    "fadaka/assembly"
)

func main() {
    if len(os.Args) < 3 || os.Args[1] != "decode" {
        fmt.Println("Usage: fadakaasm decode <hexbytecode>")
        return
    }

    hexStr := os.Args[2]
    if len(hexStr) >= 2 && hexStr[:2] == "0x" {
        hexStr = hexStr[2:]
    }

    bytecode, err := hex.DecodeString(hexStr)
    if err != nil {
        fmt.Println("Invalid hex:", err)
        return
    }

    assembly.DecodeBytecode(bytecode)
}
