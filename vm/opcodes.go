package vm

import "fmt"

var opcodeTable = map[byte]func(*VM){
    0x00: func(vm *VM) { // STOP
        vm.Halted = true
    },
    0x01: func(vm *VM) { // ADD
        a := vm.pop()
        b := vm.pop()
        vm.push(a + b)
    },
    0x02: func(vm *VM) { // MUL
        a := vm.pop()
        b := vm.pop()
        vm.push(a * b)
    },
    0x60: func(vm *VM) { // PUSH1
        val := uint64(vm.Code[vm.PC])
        vm.PC++
        vm.push(val)
    },
}

func (vm *VM) push(v uint64) {
    vm.Stack = append(vm.Stack, v)
}

func (vm *VM) pop() uint64 {
    if len(vm.Stack) == 0 {
        fmt.Println("🚨 Stack underflow!")
        vm.Halted = true
        return 0
    }
    val := vm.Stack[len(vm.Stack)-1]
    vm.Stack = vm.Stack[:len(vm.Stack)-1]
    return val
}

var opcodeTable = map[byte]func(*VM){
    0x00: func(vm *VM) { vm.Halted = true }, // STOP
    0x01: func(vm *VM) { vm.push(vm.pop() + vm.pop()) }, // ADD
    0x02: func(vm *VM) { vm.push(vm.pop() * vm.pop()) }, // MUL
    0x03: func(vm *VM) { b := vm.pop(); a := vm.pop(); vm.push(a - b) }, // SUB
    0x04: func(vm *VM) { b := vm.pop(); a := vm.pop(); if b != 0 { vm.push(a / b) } else { vm.Halted = true } }, // DIV
    0x05: func(vm *VM) { b := vm.pop(); a := vm.pop(); if b != 0 { vm.push(a % b) } else { vm.Halted = true } }, // MOD
    0x10: func(vm *VM) { b := vm.pop(); a := vm.pop(); if a < b { vm.push(1) } else { vm.push(0) } }, // LT
    0x11: func(vm *VM) { b := vm.pop(); a := vm.pop(); if a > b { vm.push(1) } else { vm.push(0) } }, // GT
    0x14: func(vm *VM) { b := vm.pop(); a := vm.pop(); if a == b { vm.push(1) } else { vm.push(0) } }, // EQ
    0x50: func(vm *VM) { _ = vm.pop() }, // POP
    0x56: func(vm *VM) { vm.PC = int(vm.pop()) }, // JUMP
    0x57: func(vm *VM) {
        dest := vm.pop()
        cond := vm.pop()
        if cond != 0 {
            vm.PC = int(dest)
        }
    }, // JUMPI
    0x60: func(vm *VM) { vm.push(uint64(vm.Code[vm.PC])); vm.PC++ }, // PUSH1
    0xfe: func(vm *VM) { fmt.Println("🚨 INVALID OPCODE"); vm.Halted = true },
}

func (vm *VM) execute(op byte) {
    gasCost := vm.gasTable[op]
    if vm.Gas < gasCost {
        fmt.Println("⛽ Out of gas!")
        vm.Halted = true
        return
    }
    vm.Gas -= gasCost
    if handler, exists := opcodeTable[op]; exists {
        handler(vm)
    } else {
        fmt.Printf("🚫 Invalid opcode: 0x%x\n", op)
        vm.Halted = true
    }
}

vm.gasTable = map[byte]uint64{
    0x00: 0, 0x01: 3, 0x02: 5, 0x03: 3, 0x04: 5,
    0x05: 5, 0x10: 3, 0x14: 3, 0x50: 2, 0x56: 8,
    0x60: 3,
}

0x51: func(vm *VM) {
    offset := vm.pop()
    if int(offset)+32 > len(vm.Memory) {
        vm.Halted = true
        return
    }
    var value uint64
    for i := 0; i < 8; i++ {
        value |= uint64(vm.Memory[int(offset)+i]) << (8 * (7 - i))
    }
    vm.push(value)
},

0x52: func(vm *VM) {
    offset := vm.pop()
    value := vm.pop()
    if int(offset)+8 > len(vm.Memory) {
        vm.Halted = true
        return
    }
    for i := 0; i < 8; i++ {
        vm.Memory[int(offset)+i] = byte(value >> (8 * (7 - i)))
    }
},
