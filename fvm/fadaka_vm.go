package fvm

import (
	"fmt"
	"github.com/wasmerio/wasmer-go/wasmer"
)

type FVM struct {
	engine *wasmer.Engine
	store  *wasmer.Store
}

func NewFVM() *FVM {
	engine := wasmer.NewEngine()
	store := wasmer.NewStore(engine)
	return &FVM{engine, store}
}

func (fvm *FVM) ExecuteWASM(wasmBytes []byte, entry string, args ...int32) error {
	module, err := wasmer.NewModule(fvm.store, wasmBytes)
	if err != nil {
		return err
	}
	importObject := wasmer.NewImportObject()
	instance, err := wasmer.NewInstance(module, importObject)
	if err != nil {
		return err
	}
	function, err := instance.Exports.GetFunction(entry)
	if err != nil {
		return err
	}
	_, err = function(args...)
	return err
}
