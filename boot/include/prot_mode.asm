bits 16
_prot_mode_switch:
    cli

    lgdt [_gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:_prot_mode_init

bits 32
_prot_mode_init:
    mov ax, DATA_SEG 
    mov ds, ax 
    mov ss, ax 
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, KERNEL_OFFSET 
    mov esp, ebp

    jmp _prot_mode_begin
