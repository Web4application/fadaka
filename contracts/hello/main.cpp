// C++ Contract for Fadaka WASM
extern "C" {
    void fadaka_log(int val);
}

extern "C" int hello() {
    fadaka_log(2025);
    return 2025;
}
