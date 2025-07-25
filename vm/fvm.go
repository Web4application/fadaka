package vm

import (
    "fmt"
)

type VM struct {
    PC     int
    Stack  []uint64
    Code   []byte
    Gas    uint64
    Halted bool
}

func NewFVM(code []byte, gas uint64) *VM {
    return &VM{
        PC:     0,
        Stack:  make([]uint64, 0),
        Code:   code,
        Gas:    gas,
        Halted: false,
    }
}

func (vm *VM) Run() {
    for !vm.Halted && vm.PC < len(vm.Code) {
        op := vm.Code[vm.PC]
        vm.PC++

        if handler, ok := opcodeTable[op]; ok {
            handler(vm)
        } else {
            fmt.Printf("🚫 Unknown opcode: 0x%x\n", op)
            vm.Halted = true
        }
    }
}

Storage map[uint64]uint64 // Simple key-value for now
