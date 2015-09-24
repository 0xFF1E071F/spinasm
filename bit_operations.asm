%include "asm_io.inc"

section .data
    prompt  dw  "Enter a number ", 0
    indmsg1 dw  "Enter the index of the bit to activate[0-31] ", 0
    indmsg2 dw  "Enter the index of the bit to deactivate[0-31] ", 0
    resmsg1 dw  "Result of OR: ", 0
    resmsg2 dw  "result of AND: ", 0

section .bss
    input   resd    1
    index   resd    1

section .text
    global _asm_main

_asm_main:
    enter   0,0
    pusha

    mov     eax, prompt                 ; output prompt message
    call    print_string
    call    read_int                    ; read input value
    mov     [input], eax

    mov     eax, indmsg1                ; output indmsg1
    call    print_string
    call    read_int                    ; read index value
    mov     [index], eax

    mov     eax, [input]
    mov     edx, 1                      ; activate first bit with value 1
    mov     cl, [index]
    shl     edx, cl                     ; edx will become 2^index
    or      eax, edx
    mov     [input], eax

    mov     eax, resmsg1                ; output OR op result
    call    print_string
    mov     eax, [input]
    call    print_int
    call    print_nl

    mov     eax, indmsg2                ; output indmsg2
    call    print_string
    call    read_int                    ; read index value
    mov     [index], eax
    
    mov     eax, [input]                ; execute and op
    mov     edx, 1
    mov     cl, [index]
    shl     edx, cl
    not     edx
    and     eax, edx
    mov     [input], eax

    mov     eax, resmsg2                ; output AND op result
    call    print_string
    mov     eax, [input]
    call    print_int
    call    print_nl    

    popa
    mov     eax, 0
    leave
    ret
