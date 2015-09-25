%include "asm_io.inc"

segment .data
    fstNumMsg   db  "Please enter first number ", 0
    sndNumMsg   db  "Please enter second number ", 0
    maxMsg      db  "The maximum is ", 0
    equalMsg    db  "The numbers are equal", 0

segment .bss
    fstNum  resd    1
    sndNum  resd    1

segment .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, fstNumMsg
    call    print_string
    call    read_int
    mov     [fstNum], eax
    
    mov     eax, sndNumMsg
    call    print_string
    call    read_int
    mov     [sndNum], eax

    mov     eax, [fstNum]
    mov     edx, [sndNum]
    cmp     eax, edx
    je      equal
    jg      greater
    mov     [fstNum], edx
    jmp     greater

equal:
    mov     eax, equalMsg
    call    print_string
    call    print_nl
    jmp     end

greater:
    mov     eax, maxMsg
    call    print_string
    mov     eax, [fstNum]
    call    print_int
    call    print_nl

end:
    popa
    mov     eax, 0
    leave
    ret
