%include "asm_io.inc"

section .data
    prompt1 db  "Enter first number ", 0
    prompt2 db  "Enter second number ", 0
    outmsg1 db  "Sum of ", 0
    outmsg2 db  " and ", 0
    outmsg3 db  " is ", 0

section .bss
    num1    resd    1
    num2    resd    1

section .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, prompt1
    call    print_string

    mov     ebx, num1               ; store address of num1 into ebx
    mov     ecx, ret_addr
    jmp     short get_int

ret_addr:
    mov     eax, prompt2
    call    print_string

    mov     ebx, num2
    mov     ecx, $ + 7              ; ecx = this addr + 7
    jmp     short get_int

    mov     eax, [num1]
    add     eax, [num2]
    mov     ebx, eax

    mov     eax, outmsg1
    call    print_string
    mov     eax, [num1]
    call    print_int
    mov     eax, outmsg2
    call    print_string
    mov     eax, [num2]
    call    print_int
    mov     eax, outmsg3
    call    print_string
    mov     eax, ebx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret

get_int:
    call    read_int
    mov     [ebx], eax
    jmp     ecx
