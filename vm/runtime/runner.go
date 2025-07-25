var storage = map[int32]int32{}

fadakaStorageWrite := wasmer.NewFunction(...func(args []wasmer.Value) ([]wasmer.Value, error) {
	key := args[0].I32()
	val := args[1].I32()
	storage[key] = val
	fmt.Printf("[STORAGE WRITE] %d = %d\n", key, val)
	return nil, nil
})

fadakaStorageRead := wasmer.NewFunction(...func(args []wasmer.Value) ([]wasmer.Value, error) {
	key := args[0].I32()
	val := storage[key]
	fmt.Printf("[STORAGE READ] %d -> %d\n", key, val)
	return []wasmer.Value{wasmer.NewI32(val)}, nil
})
