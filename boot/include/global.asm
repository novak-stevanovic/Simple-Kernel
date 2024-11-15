%ifndef _GLOBAL_ASM
%define _GLOBAL_ASM 1

%define ONE_BIT 0x01
%define TTY_MOD mov ah, 0x0E
%define PRN_INT int 0x10
%define KERNEL_OFFSET 0x7E01
%define SEGMENT_COUNT 15

%macro PRN_NL 0
    TTY_MOD
    mov al, 10
    PRN_INT
    mov al, 13
    PRN_INT
%endmacro

%endif
