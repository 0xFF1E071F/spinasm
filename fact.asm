segment .text
    global _fact

_fact:
    enter   0, 0

    mov     eax, [ebp+8]
    cmp     eax, 1
    jbe     term_cond
    dec     eax
    push    eax
    call    _fact
    pop     ecx
    mul     dword [ebp+8]
    jmp     short end_fact

term_cond:
    mov     eax, 1

end_fact:
    leave
    ret
