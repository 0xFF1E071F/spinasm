%include "asm_io.inc"

segment .data
    prompt  db  ") Enter an integer number (0 to quit): ", 0

segment .text
    global  get_int, print_sum

get_int:
    push    ebp
    mov     ebp, esp
    ;enter   0, 0                   ; instead of previous 2 lines, only this one can be used
                                    ; enter instruction simplifies 'prologue', but it is slower

    mov     eax, [ebp+12]
    call    print_int

    mov     eax, prompt
    call    print_string

    call    read_int
    mov     ebx, [ebp+8]
    mov     [ebx], eax              ; store input in memory
   
    ;leave                          ; instead of next line, simplifies 'epilogue', but is slower
    pop     ebp
    ret                             ; jump back to caller

segment .data
    result  db  "The sum is ", 0

segment .text
print_sum:
    push    ebp
    mov     ebp, esp
    ;enter   0, 0                   ; reference: get_int subprogram

    mov     eax, result
    call    print_string

    mov     eax, [ebp+8]
    call    print_int
    call    print_nl

    ;leave                          ; reference: get_int subprogram
    pop     ebp
    ret
