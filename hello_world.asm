section .text
    global _start
_start:
    mov edx, lenMsg
    mov ecx, msg
    mov ebx, 1                      ; 1 = stdout file descriptor
    mov eax, 4                      ; sys_write syscall
    int 0x80
    
    mov eax, 1
    int 0x80

section .data
    msg db 'Hello, world!', 0xa
    lenMsg equ $ - msg
