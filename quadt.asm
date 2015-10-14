%define     a       qword [ebp+8]
%define     b       qword [ebp+16]
%define     c       qword [ebp+24]
%define     root1   dword [ebp+32]
%define     root2   dword [ebp+36]
%define     disc    qword [ebp-8]
%define     one2a   qword [ebp-16]

segment .data
    MinusFour   dw  -4

segment .text
    global  quadratic

quadratic:
