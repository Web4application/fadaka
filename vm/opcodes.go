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
