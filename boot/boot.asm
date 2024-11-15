%define START 0x7C00
org START
bits 16

jmp _start

%include "global.asm"
%include "read_disk.asm"
%include "gdt.asm"
%include "prot_mode.asm"
%include "print.asm"
bits 16

.data:
    mode16_msg: db "Welcome.", 0
    mode32_msg: db "Welcome to 32-bit protected mode.", 0

_start:

_real_mode_begin:
    mov bp, START
    mov sp, bp

    mov si, mode16_msg
    call _print_string16

    call _read_disk

    call _prot_mode_switch
    jmp $


bits 32
_prot_mode_begin:

    mov ebx, mode32_msg
    call _print_string32

    call KERNEL_OFFSET

    jmp $

times 510 - ($-$$) db 0
db 0x55, 0xAA

