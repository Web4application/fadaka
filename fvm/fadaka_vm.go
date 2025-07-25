func (fvm *FVM) ExecuteContract(wasm []byte, entry string, args ...int32) error {
	module, err := wasmer.NewModule(fvm.store, wasm)
	if err != nil {
		return fmt.Errorf("WASM compile error: %w", err)
	}

	// Create WASM import for `fadaka_log`
	fadakaLog := wasmer.NewFunction(
		fvm.store,
		wasmer.NewFunctionType(
			wasmer.NewValueTypes(wasmer.I32), []wasmer.ValueType{}),
		func(args []wasmer.Value) ([]wasmer.Value, error) {
			logVal := args[0].I32()
			fmt.Printf("[FVM Log] Contract says: %d\n", logVal)
			return nil, nil
		},
	)

	imports := wasmer.NewImportObject()
	imports.Register(
		"env",
		map[string]wasmer.IntoExtern{
			"fadaka_log": fadakaLog,
		},
	)

	instance, err := wasmer.NewInstance(module, imports)
	if err != nil {
		return fmt.Errorf("WASM instantiation error: %w", err)
	}

	function, err := instance.Exports.GetFunction(entry)
	if err != nil {
		return fmt.Errorf("entry '%s' not found: %w", entry, err)
	}

	_, err = function(args...)
	return err
}
