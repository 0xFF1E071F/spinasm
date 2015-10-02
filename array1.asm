%define ARR_SZ 100
%define NL 10

segment .data
    fstMsg  db  "First 10 elements of array", 0
    prompt  db  "Enter index of element to display: ", 0
    sndMsg  db  "Element %d is %d", NL, 0
    trdMsg  db  "Elements 20 to 29 of array", 0
    inpFmt  db  "%d", 0

segment .bss
    array   resd    ARR_SZ

segment .text
    extern  puts, printf, scanf, dump_line
    global  asm_main

asm_main:
    enter   0, 0
    push    ebx
    push    esi
        
; initialize array with values 100, 99, 98 ...
    mov     ecx, ARR_SZ
    mov     ebx, array
init_loop:
    mov     [ebx], ecx
    add     ebx, 4
    loop    init_loop

    push    dword fstMsg
    call    puts
    pop     ecx

    push    dword 10
    push    dword array
    call    print_array
    add     esp, 8

prompt_loop:
    push    dword prompt
    call    printf
    pop     ecx

    lea     eax, [ebp-4]                ; eax = address of local dword
    push    eax
    push    dword inpFmt
    call    scanf
    add     esp, 8
    cmp     eax, 1
    je      inputOK                     ; input valid

    call    dump_line                   ; skip rest of line
    jmp     prompt_loop                 ; input invalid

inputOK:
    mov     esi, [ebp-4]
    push    dword [array + 4*esi]
    push    esi
    push    dword sndMsg
    call    printf
    add     esp, 12

    push    dword trdMsg
    call    puts
    pop     ecx

    push    dword 10
    push    dword array + 20*4
    call    print_array 
    add     esp, 8

    pop     esi
    pop     ebx
    mov     eax, 0
    leave
    ret

segment .data
    outFmt  db  "%-5d %5d", NL, 0

segment .text
    global  print_array

print_array:
    enter   0, 0
    push    esi
    push    ebx

    xor     esi, esi
    mov     ecx, [ebp+12]
    mov     ebx, [ebp+8]

print_loop:
    push    ecx
    push    dword [ebx + 4*esi]
    push    esi
    push    dword outFmt
    call    printf
    add     esp, 12

    inc     esi
    pop     ecx
    loop    print_loop

    pop     ebx
    pop     esi
    leave
    ret
