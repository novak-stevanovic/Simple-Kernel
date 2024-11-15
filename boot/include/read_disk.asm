%ifndef _READ_DISK_ASM
%define _READ_DISK_ASM
%include "print.asm"
%include "global.asm"

bits 16

.data:
    disk_read_err: db "Error when reading the disk.", 0
    disk_read_noerr: db "Successfully read the disk.", 0

_read_disk:
    ; mov bl, dl
    mov ah, 0x02

    mov dl, 0x00 ; drive
    mov ch, 0 ; ???? cylinder
    mov dh, 0 ; 0 ; track on first side of the floppy disk
    mov cl, 2 ; select 2nd sector
    mov al, SEGMENT_COUNT ; read SEGMENT_COUNT sector

    mov bx, 0
    mov es, bx
    mov bx, KERNEL_OFFSET

    int 0x13

    jc disk_error1

    cmp al, SEGMENT_COUNT
    jne disk_error2

    jmp no_errors

    disk_error1:
        mov si, disk_read_err
        call _print_string16
        jmp $

    disk_error2:
        mov si, disk_read_err
        call _print_string16
        jmp $

    no_errors:
        mov si, disk_read_noerr
        call _print_string16
        ret


%endif
