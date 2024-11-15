bits 16
gdt_start:
    gdt_null_descriptor:
        dd 0
        dd 0
    gdt_code_descriptor:
        dw 0xffff ; first 16 bits of limit
        dw 0 ; 
        db 0 ; first 24 bits of base
        db 10011010b ; present, privilege, type + type flags
        db 11001111b ; other flags + 4 bits of limit
        db 0 ; last 8 bits of the base
    gdt_data_descriptor:
        dw 0xffff ; first 16 bits of limit
        dw 0 ; 
        db 0 ; first 24 bits of base
        db 10010010b ; present, privilege, type + type flags
        db 11001111b ; other flags + 4 bits of limit
        db 0 ; last 8 bits of the base
gdt_end:

_gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code_descriptor - gdt_start
DATA_SEG equ gdt_data_descriptor - gdt_start
