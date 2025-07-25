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

var storage = map[int32]int32{}

fadakaStorageWrite := wasmer.NewFunction(
	store,
	wasmer.NewFunctionType([]*wasmer.ValueType{wasmer.I32, wasmer.I32}, []*wasmer.ValueType{}),
	func(args []wasmer.Value) ([]wasmer.Value, error) {
		key := args[0].I32()
		val := args[1].I32()
		storage[key] = val
		fmt.Printf("[STORAGE WRITE] key=%d val=%d\n", key, val)
		return nil, nil
	},
)

fadakaStorageRead := wasmer.NewFunction(
	store,
	wasmer.NewFunctionType([]*wasmer.ValueType{wasmer.I32}, []*wasmer.ValueType{wasmer.I32}),
	func(args []wasmer.Value) ([]wasmer.Value, error) {
		key := args[0].I32()
		val := storage[key]
		fmt.Printf("[STORAGE READ] key=%d -> val=%d\n", key, val)
		return []wasmer.Value{wasmer.NewI32(val)}, nil
	},
)

imports.Register("env", map[string]wasmer.IntoExtern{
	"fadaka_log": fadakaLog,
	"fadaka_storage_write": fadakaStorageWrite,
	"fadaka_storage_read": fadakaStorageRead,
})
