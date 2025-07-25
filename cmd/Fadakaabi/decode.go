package main

import (
	"encoding/hex"
	"fmt"
)

func DecodeCommand(abiFile, funcName, hexInput string) error {
	abi, err := LoadFadakaABI(abiFile)
	if err != nil {
		return err
	}

	var targetFunc *ABIEntry
	for _, f := range abi.Functions {
		if f.Name == funcName {
			targetFunc = &f
			break
		}
	}
	if targetFunc == nil {
		return fmt.Errorf("function not found: %s", funcName)
	}

	inputBytes, err := hex.DecodeString(hexInput)
	if err != nil {
		return err
	}

	// Skip selector (first 4 bytes)
	argsBytes := inputBytes[4:]

	fmt.Println("Decoded Args:")
	for i, typ := range targetFunc.Inputs {
		arg := argsBytes[i*32 : (i+1)*32]
		if typ == "address" {
			fmt.Printf("- %s: 0x%s\n", typ, hex.EncodeToString(arg[12:])) // last 20 bytes
		} else if typ == "uint256" {
			fmt.Printf("- %s: %s\n", typ, new(big.Int).SetBytes(arg).String())
		}
	}

	return nil
}
