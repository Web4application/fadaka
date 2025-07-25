git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
./emsdk install latest
./emsdk activate latest
source ./emsdk_env.sh

emcc main.cpp -O3 -s WASM=1 -s SIDE_MODULE=1 -o hello_contract.wasm
