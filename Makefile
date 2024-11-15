ASM = nasm
ASMFLAGS = -f bin -I./boot/include
CC = gcc
CFLAGS = -ffreestanding -m32 -fno-pie -c
LDFLAGS = -m elf_i386 --oformat binary
BUILD_DIR = build

OS_IMG_BIN = os-image.bin
OS_IMG_FLP = os-image.flp

C_SRC = $(wildcard kernel/*.c drivers/*.c)
C_OBJ = ${patsubst %.c,$(BUILD_DIR)/%.o,$(C_SRC)}

.PHONY: build

$(BUILD_DIR)/$(OS_IMG_FLP): $(BUILD_DIR)/boot.bin $(BUILD_DIR)/kernel.bin
	cat $< > $(BUILD_DIR)/$(OS_IMG_BIN)
	cat $(BUILD_DIR)/kernel.bin >> $(BUILD_DIR)/$(OS_IMG_BIN)
	dd if=$(BUILD_DIR)/$(OS_IMG_BIN) of=$(BUILD_DIR)/$(OS_IMG_FLP)

build:
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/boot.bin: boot/boot.asm build
	$(ASM) $(ASMFLAGS) $< -o $@

$(BUILD_DIR)/kernel.bin: $(C_OBJ)
	ld $(LDFLAGS) -o $@ $(BUILD_DIR)/kernel/kernel.o -e kernel_main

$(BUILD_DIR)/%.o : %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)

