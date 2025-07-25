package assembly

import (
    "fmt"
)

func DecodeBytecode(bytecode []byte) {
    for pc := 0; pc < len(bytecode); {
        op := bytecode[pc]
        name, ok := Opcodes[op]
        if !ok {
            name = "UNKNOWN"
        }

        fmt.Printf("0x%04x:\t%s\n", pc, name)
        pc += 1

        // PUSHn detection
        if op >= 0x60 && op <= 0x7f {
            pushBytes := int(op - 0x5f)
            if pc+pushBytes <= len(bytecode) {
                data := bytecode[pc : pc+pushBytes]
                fmt.Printf("\t\tPUSH DATA: 0x%x\n", data)
            }
            pc += pushBytes
        }
    }
}
