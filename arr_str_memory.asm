global asm_copy, asm_find, asm_strlen, asm_strcpy

segment .text

%define     dest    [ebp+8]
%define     src     [ebp+12]
%define     sz      [ebp+16]


; copies (sz) blocks of memory from src to dest
; void asm_copy(void *dest, const void *src, unsigned sz);
; parameters:
; dest - pointer, copy to
; src  - pointer, copy from
; sz   - natural number, num of bytes to copy 
asm_copy:
    enter   0, 0
    push    esi
    push    edi

    mov     esi, src                    ; address to copy from
    mov     edi, dest                   ; address to copy to
    mov     ecx, sz                     ; number of bytes to copy

    cld                                 ; [!!!] clear direction flag
    rep     movsb

    pop     edi
    pop     esi
    leave
    ret

; searches memory for a given byte
; void * asm_find(const void *src, char target, unsigned sz);
; parameters:
; src    - pointer, where to search
; target - byte, what to search
; sz     - natural number, bytes in src
; returns:
; if target is found, pointer to first occurrence
; else NULL
%define     src     [ebp+8]
%define     dest    [ebp+12]
%define     sz      [ebp+16]

asm_find:
    enter   0, 0
    push    edi

    mov     eax, target
    mov     edi, src
    mov     ecx, sz
    
    cld
    repne   scasb                       ; scan until ECX == 0 or [ES:EDI] == AL
    
    je      found_tg
    mov     eax, 0
    jmp     short quit

found_tg:
    mov     eax, edi
    dec     eax                         

quit:
    pop     edi
    leave
    ret

; return the size of a string
; unsigned asm_strlen(const char *);
; parameter
; src - pointer to a string
; returns:
; natural number

%define     src     [ebp+8]

asm_strlen:
    enter   0, 0
    push    edi

    mov     edi, src
    mov     ecx, 0FFFFFFFFh             ; use largest possible value
    xor     al, al                      ; ls 8 bits of eax = 0
    cld

    repnz   scasb                       ; scan for terminating 0

    mov     eax, 0FFFFFFFEh             ; E not F, repnz will be go one step off
    sub     eax, ecx

    pop     edi
    leave
    ret
