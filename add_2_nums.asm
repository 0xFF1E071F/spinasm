%include "asm_io.inc"

segment .data
    prompt1 db "Enter first number: ", 0
    prompt2 db "Enter second number: ", 0
    outmsg1 db "You entered ", 0
    outmsg2 db " and ", 0
    outmsg3 db ", the sum of these is ", 0

segment .bss
    num1 resd 1
    num2 resd 1

segment .text
    global _asm_main

_asm_main:
    enter 0, 0
    pusha

    mov eax, prompt1
    call print_string

    call read_int
    mov [num1], eax

    mov eax, prompt2
    call print_string

    call read_int
    mov [num2], eax

    mov eax, [num1]
    add eax, [num2]
    mov ebx, eax

    dump_regs 1
    dump_mem 2, outmsg1, 1

    mov eax, outmsg1
    call print_string
    mov eax, [num1]
    call print_int
    mov eax, outmsg2
    call print_string
    mov eax, [num2]
    call print_int
    mov eax, outmsg3
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
