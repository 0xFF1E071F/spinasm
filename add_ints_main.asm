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
    global  _asm_main
    extern  get_int, print_sum  

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
