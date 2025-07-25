package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {
	mode := flag.String("mode", "encode", "Mode: encode | decode")
	abiPath := flag.String("abi", "sample_abi.json", "Path to ABI file")
	function := flag.String("func", "", "Function name to encode")
	args := flag.String("args", "", "Comma-separated arguments")
	input := flag.String("input", "", "Hex input for decoding")

	flag.Parse()

	if *mode == "encode" {
		err := EncodeCommand(*abiPath, *function, *args)
		if err != nil {
			fmt.Println("Encode error:", err)
			os.Exit(1)
		}
	} else if *mode == "decode" {
		err := DecodeCommand(*abiPath, *function, *input)
		if err != nil {
			fmt.Println("Decode error:", err)
			os.Exit(1)
		}
	} else {
		fmt.Println("Unknown mode. Use encode or decode.")
	}
}
