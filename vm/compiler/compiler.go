package compiler

func Assemble(program []string) []byte {
    opcodeMap := map[string]byte{
        "STOP": 0x00, "ADD": 0x01, "MUL": 0x02, "SUB": 0x03,
        "DIV": 0x04, "MOD": 0x05, "EQ": 0x14, "LT": 0x10,
        "PUSH1": 0x60, "POP": 0x50, "MLOAD": 0x51, "MSTORE": 0x52,
        "JUMP": 0x56, "JUMPI": 0x57, "SLOAD": 0x54, "SSTORE": 0x55,
        "CREATE": 0xf0,
    }

    bytecode := []byte{}
    for i := 0; i < len(program); i++ {
        token := program[i]
        if op, ok := opcodeMap[token]; ok {
            bytecode = append(bytecode, op)
            if op >= 0x60 && op <= 0x7f { // PUSHn
                i++
                // Assume next is a hex string like "0x2a"
                value := program[i]
                val := ParseUint(value) // add parser
                bytecode = append(bytecode, byte(val))
            }
        }
    }
    return bytecode
}
