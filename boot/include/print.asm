%ifndef _PRINT_ASM
%define _PRINT_ASM

bits 16
_print_string16:
    push ax

    TTY_MOD
    .print_string_int:
        lodsb
        cmp al, 0
        je .print_string_ret
        PRN_INT
        jmp .print_string_int

    .print_string_ret:
        pop ax
        ret

bits 32
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

_clear_video_mem32:
    pusha
    mov eax, 80
    mov ebx, 25
    mul ebx ; 80 * 25 = 2000

    mov edx, 0 ; counter

    mov ebx, VIDEO_MEMORY
    .clear_video_mem32_loop:
        cmp edx, eax
        je .clear_video_mem32_end

        inc edx
        inc ebx
        inc ebx

        mov al, ' '
        mov ah, WHITE_ON_BLACK
        mov [ebx], ax 
        jmp .clear_video_mem32_loop

    .clear_video_mem32_end:
    popa
    ret

; uses ebx
_print_string32:
    pusha

    call _clear_video_mem32

    mov edx, VIDEO_MEMORY
    mov ah, WHITE_ON_BLACK

    .print_string32_loop:
        mov al, [ebx]

        cmp al, 0
        je .print_string32_end

        mov [edx], ax

        add ebx, 1
        add edx, 2

        jmp .print_string32_loop

.print_string32_end:
    popa
    ret

%endif
