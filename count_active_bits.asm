%include "asm_io.inc"

segment .data
    prompt   dw  "Enter a number ", 0
    outmsg1  dw  " has ", 0
    outmsg2  dw  " active bits.", 0
    

segment .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, prompt
    call    print_string
    call    read_int                    ; read int into eax reg
    mov     ebx, eax                    ; save int for later use
    mov     edx, 0                      ; keep active bits in edx reg
    mov     ecx, 32                     

count_bits_loop:
    shl     eax, 1                      ; shift to left, lost bit kept in CF(carry flag)
    jnc     skip_inc                    ; if CF is not 1 skip increment step
    inc     edx
skip_inc:
    loop count_bits_loop

    mov     eax, ebx                    ; output result
    call    print_int
    mov     eax, outmsg1
    call    print_string
    mov     eax, edx
    call    print_int
    mov     eax, outmsg2
    call    print_string
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret
