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

    mov     eax, msg
    call    print_string
    call    read_int
    mov     [limit], eax
    
    mov     eax, 2
    call    print_int
    call    print_nl
    mov     eax, 3
    call    print_int
    call    print_nl

    mov     dword [guess], 5
while_limit:
    mov     eax, [guess]
    cmp     eax, [limit]
    jnbe    end_while_limit

    mov     ebx, 3
while_factor:
    mov     eax, ebx
    mul     eax
    jo      end_while_factor
    cmp     eax, [guess]
    jnb     end_while_factor
    mov     eax, [guess]
    mov     edx, 0
    div     ebx
    cmp     edx, 0
    je      end_while_factor

    add     ebx, 2
    jmp     while_factor
end_while_factor:
    je      end_if
    mov     eax, [guess]
    call    print_int
    call    print_nl

end_if:
    add     dword [guess], 2
    jmp     while_limit

end_while_limit:

    popa
    mov     eax, 0
    leave
    ret
 
