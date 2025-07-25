package main

import (
	"fmt"
	"os"
	"github.com/wasmerio/wasmer-go/wasmer"
)

func main() {
	wasmBytes, _ := os.ReadFile("../wasm/hello.wasm")
	engine := wasmer.NewEngine()
	store := wasmer.NewStore(engine)

	// Define Fadaka Host Function
	fadakaLog := wasmer.NewFunction(
		store,
		wasmer.NewFunctionType([]*wasmer.ValueType{wasmer.I32}, []*wasmer.ValueType{}),
		func(args []wasmer.Value) ([]wasmer.Value, error) {
			fmt.Println("[FADAKA LOG]", args[0].I32())
			return []wasmer.Value{}, nil
		},
	)

	// Instantiate WASM
	imports := wasmer.NewImportObject()
	imports.Register("env", map[string]wasmer.IntoExtern{
		"fadaka_log": fadakaLog,
	})
	module, _ := wasmer.NewModule(store, wasmBytes)
	instance, _ := wasmer.NewInstance(module, imports)

	// Call `hello`
	helloFunc, _ := instance.Exports.GetFunction("hello")
	result, _ := helloFunc()
	fmt.Println("[FADAKA RESULT]", result)
}
