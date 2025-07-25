package debugger

import (
	"fmt"
	"github.com/wasmerio/wasmer-go/wasmer"
)

func TraceContract(wasmBytes []byte) error {
	engine := wasmer.NewEngine()
	store := wasmer.NewStore(engine)
	module, err := wasmer.NewModule(store, wasmBytes)
	if err != nil {
		return err
	}
	for _, exp := range module.Exports() {
		fmt.Printf("Export: %s -> %s\n", exp.Name(), exp.Type().Kind())
	}
	return nil
}
