TARGET = hello
WASM_OUT = ../../wasm/$(TARGET).wasm

build:
	emcc main.cpp -O3 -s WASM=1 -s SIDE_MODULE=1 -o $(WASM_OUT)

clean:
	rm -f $(WASM_OUT)
