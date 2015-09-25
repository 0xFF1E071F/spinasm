%include "asm_io.inc"

section .data
    prompt  db  "Enter a number ", 0
    resMsg  db  "# of active bits is ", 0

section .bss
    input   resd    1

section .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, prompt
    call    print_string
    call    read_int

    xor     ebx, ebx
count_loop:
    mov     [input], eax
    cmp     eax, 0
    je      end
    sub     dword [input], 1
    and     eax, [input]
    inc     ebx
    loop    count_loop

end:
    mov     eax, resMsg
    call    print_string
    mov     eax, ebx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret
