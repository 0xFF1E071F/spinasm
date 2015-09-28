%include "asm_io.inc"

segment .data
    sum dd  0

segment .bss
    input   resd    1

; pseudo-code algo
; i = 1
; sum = 0
; while (get_int(i, &input), input != 0) {
;   sum += input;
;   i++;
; }
; print_sum(num);

segment .text
    global _asm_main

_asm_main:
    enter   0, 0
    pusha

    mov     edx, 1                  ; edx is i in pseudo-code
while_loop:
    push    edx                     ; save i on stack
    push    dword input             ; push address of input on stack
    call    get_int
    add     esp, 8                  ; remove i and &input from stack

    mov     eax, [input]
    cmp     eax, 0
    je      end_while

    add     [sum], eax

    inc     edx
    jmp     short while_loop

end_while:
    push    dword [sum]             ; push [sum] to stack
    call    print_sum
    pop     ecx                     ; remove [sum] from stack

    popa
    leave
    ret

segment .data
    prompt  db  ") Enter an integer number (0 to quit): ", 0

segment .text
get_int:
    push    ebp
    mov     ebp, esp

    mov     eax, [ebp+12]
    call    print_int

    mov     eax, prompt
    call    print_string

    call    read_int
    mov     ebx, [ebp+8]
    mov     [ebx], eax              ; store input in memory
    
    pop     ebp
    ret                             ; jump back to caller

segment .data
    result  db  "The sum is ", 0

segment .text
print_sum:
    push    ebp
    mov     ebp, esp
    
    mov     eax, result
    call    print_string

    mov     eax, [ebp+8]
    call    print_int
    call    print_nl

    pop     ebp
    ret
