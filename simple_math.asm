%include "asm_io.inc"

segment .data
    prompt      db  "Enter a number ", 0
    square_msg  db  "Square of input is ", 0
    cube_msg    db  "Cube of input is ", 0
    cube25_msg  db  "Cube of input times 25 is ", 0
    quot_msg    db  "Quotient of cube/100 is ", 0
    rem_msg     db  "Remainder of cube/100 is ", 0
    neg_msg     db  "The negative of the remainder is ", 0

segment .bss
    input resd  1

segment .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     eax, prompt                 ; output prompt message
    call    print_string

    call    read_int                    ; read an integer
    mov     [input], eax

    imul    eax                         ; for 32-bit reg the rule is
                                        ; imul source -> edx:eax = eax * source
                                        ; so this is edx:eax = eax * eax
    mov     ebx, eax                    ; save result in ebx
    mov     eax, square_msg
    call    print_string                ; output square_msg
    mov     eax, ebx
    call    print_int                   ; output square of input
    call    print_nl

    mov     ebx, eax
    imul    ebx, [input]                ; ebx *= [input]
                                        ; [input] is value at mem loc of input
                                        ; same as dereferencing a C pointer
    mov     eax, cube_msg
    call    print_string
    mov     eax, ebx
    call    print_int
    call    print_nl

    imul    ecx, ebx, 25                ; ecx = ebx * 25
    mov     eax, cube25_msg
    call    print_string
    mov     eax, ecx
    call    print_int
    call    print_nl

    mov     eax, ebx
    cdq                                 ; initialize edx by sign extension
                                        ; otherwise the program will give an error
    mov     ecx, 100                    ; can't divide by an immediate value, store it in a reg
    idiv    ecx                         ; edx:eax / ecx
    mov     ecx, eax
    mov     eax, quot_msg
    call    print_string
    mov     eax, ecx
    call    print_int
    call    print_nl
    mov     eax, rem_msg
    call    print_string
    mov     eax, edx
    call    print_int
    call    print_nl

    neg     edx                         ; negate the remainder
    mov     eax, neg_msg
    call    print_string
    mov     eax, edx
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret
