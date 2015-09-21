%include "asm_io.inc"

segment .data
    prompt  db  "Input a number ", 0
    res     db  "Result ", 0

segment .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha
        
    mov     eax, prompt
    call    print_string
    call    read_int
    mov     ecx, eax                        ; put input int to counter reg
    mov     eax, 0                          ; the sum is in eax
 
loop_start:
    add     eax, ecx                        ; add counter to sum, eax += ecx
    loop    loop_start                      

    mov     ebx, eax                        
    mov     eax, res
    call    print_string                    ; output the result
    mov     eax, ebx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret
