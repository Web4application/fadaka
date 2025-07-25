// C++ Contract for Fadaka WASM
extern "C" {
    void fadaka_log(int val);
}

extern "C" int hello() {
    fadaka_log(2025);
    return 2025;
}

extern "C" {
    void fadaka_log(int val);
    void fadaka_storage_write(int key, int value);
    int fadaka_storage_read(int key);
}

extern "C" int hello() {
    int key = 42;
    fadaka_storage_write(key, 2025);
    int stored = fadaka_storage_read(key);
    fadaka_log(stored);
    return stored;
}
