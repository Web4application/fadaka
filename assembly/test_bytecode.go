package main

import (
    "encoding/hex"
    "fadaka/assembly"
)

func main() {
    bytecode, _ := hex.DecodeString("6080604052348015600f57600080fd5b")
    assembly.DecodeBytecode(bytecode)
}
