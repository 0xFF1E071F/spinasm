%include "asm_io.inc"

segment .data
    msg     db      "Find primes up to: ", 0

segment .bss
    limit   resd    1
    guess   resd    1

segment .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, msg                    ; output message
    call    print_string
    call    read_int                    ; read limit
    mov     [limit], eax
    
    mov     eax, 2                      ; output first two prime nums
    call    print_int                   ; 2 and 3
    call    print_nl
    mov     eax, 3
    call    print_int
    call    print_nl

    mov     dword [guess], 5            ; the next prime number guess
while_limit:                            ; is from 5, iterate only over odd nums
    mov     eax, [guess]                ; guess <= limit
    cmp     eax, [limit]
    jnbe    end_while_limit

    mov     ebx, 3                      ; factor starts from 3
while_factor:
    mov     eax, ebx                    ; factor * factor
    mul     eax
    jo      end_while_factor
    cmp     eax, [guess]                ; factor * factor < guess
    jnb     end_while_factor
    mov     eax, [guess]
    mov     edx, 0                      ; guess % factor != 0
    div     ebx
    cmp     edx, 0
    je      end_while_factor

    add     ebx, 2                      ; increment factor
    jmp     while_factor
end_while_factor:
    je      end_if                      ; guess % factor != 0
    mov     eax, [guess]                ; print prime number
    call    print_int
    call    print_nl

end_if:
    add     dword [guess], 2            ; increase guess
    jmp     while_limit

end_while_limit:

    popa
    mov     eax, 0
    leave
    ret
 
