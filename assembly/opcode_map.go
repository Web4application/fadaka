package assembly

var Opcodes = map[byte]string{
    0x00: "STOP",
    0x01: "ADD",
    0x02: "MUL",
    0x03: "SUB",
    0x04: "DIV",
    0x05: "SDIV",
    // ... Fill in remaining EVM opcodes
}
