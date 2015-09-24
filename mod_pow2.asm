%include "asm_io.inc"

section .data
    prompt  db  "Enter a number ", 0
    prompt2 db  "Enter a power of two ", 0
    quotmsg db  "Remainder: ", 0

section .bss
    input       resd    1
    quotient    resd    1

section .text
    global  _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, prompt
    call    print_string
    call    read_int
    mov     [input], eax
    
    mov     eax, prompt2
    call    print_string
    call    read_int
    mov     [quotient], eax

    sub     dword [quotient], 1
    mov     eax, [input]
    and     eax, [quotient]
    mov     ebx, eax

    mov     eax, quotmsg
    call    print_string
    mov     eax, ebx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret
