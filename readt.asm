section .data
    format  db  "%lf", 0

segment .text
    global  read_doubles
    extern  fscanf

%define SZ_DOUBLE   8
%define FP          dword [ebp+8]
%define ARR_PTR     dword [ebp+12]
%define ARR_SZ      dword [ebp+16]
%define TEMP_DOUBLE [ebp-8]

read_doubles:
    push    ebp
    mov     ebp, esp
    sub     esp, SZ_DOUBLE

    push    esi
    mov     esi, ARR_PTR
    xor     edx, edx

while_loop:
    cmp     edx, ARR_SZ
    jnl     short quit

    push    edx
    lea     eax, TEMP_DOUBLE
    push    eax
    push    dword format
    push    FP
    call    fscanf
    add     esp, 12
    pop     edx
    cmp     eax, 1
    jne     short quit

    mov     eax, [ebp-8]
    mov     [esi+8*edx], eax
    mov     eax, [ebp-4]
    mov     [esi+8*edx+4], eax

    inc     edx
    jmp     while_loop

quit:
    pop     esi

    mov     eax, edx

    mov     esp, ebp
    pop     ebp
    ret
