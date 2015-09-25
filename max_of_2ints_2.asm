; Find the maximum of 2 signed integers without branching
; Ref: pcasm book

%include "asm_io.inc"

segment .data
    msg1    db  "Enter first number ", 0
    msg2    db  "Enter second number ", 0
    maxMsg  db  "The maximum is ", 0 

segment .bss
    input   resd    1

segment .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, msg1
    call    print_string
    call    read_int
    mov     [input], eax

    mov     eax, msg2
    call    print_string
    call    read_int

    xor     ebx, ebx            ; ebx = 0
    cmp     eax, [input]
    setg    bl
    neg     ebx                 ; complement of 2
    mov     ecx, ebx
    and     ecx, eax
    not     ebx
    and     ebx, [input]
    or      ecx, ebx

    mov     eax, maxMsg
    call    print_string
    mov     eax, ecx
    call    print_int
    call    print_nl    

    popa
    mov     eax, 0
    leave
    ret
