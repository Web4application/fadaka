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
        if op >= 0x60 && op <= 0x7f { // PUSHn
            pushBytes := int(op - 0x5f)
            if pc+pushBytes <= len(bytecode) {
                fmt.Printf("\t\tPUSH DATA: 0x%x\n", bytecode[pc:pc+pushBytes])
            }
            pc += pushBytes
        }
    }
}
