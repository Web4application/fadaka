package main

import (
	"encoding/hex"
	"fmt"
	"strings"
)

func EncodeCommand(abiFile, funcName, rawArgs string) error {
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

	args := strings.Split(rawArgs, ",")
	if len(args) != len(targetFunc.Inputs) {
		return fmt.Errorf("argument count mismatch: got %d, expected %d", len(args), len(targetFunc.Inputs))
	}

	encoded, err := EncodeFadakaCall(*targetFunc, args)
	if err != nil {
		return err
	}

	fmt.Println("Encoded hex:", hex.EncodeToString(encoded))
	return nil
}
