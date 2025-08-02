package main

import (
    "fmt"
    "os/exec"
)

func main() {
    fmt.Println("Compiling MyToken.sol...")
    cmd := exec.Command("solc", "--bin", "--abi", "MyToken.sol", "-o", "build")
    output, err := cmd.CombinedOutput()
    if err != nil {
        fmt.Println("Compilation error:", string(output))
        return
    }
    fmt.Println("Compiled successfully. ABI and BIN written to /build")
}