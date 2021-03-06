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
    mov     edx, 0                      ; keep active bits in edx reg
    mov     ecx, 32                     

count_bits_loop:
    rol     eax, 1                      ; rotate to left, msb bit kept in CF(carry flag)
    adc     edx, 0                      ; use adc instruction to add the CF value
    loop    count_bits_loop

    call    print_int                   ; output result
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
