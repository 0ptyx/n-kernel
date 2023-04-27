TARGET = aarch64-unknown-none-softfloat
BUILD_PATH = target/$(TARGET)/release
KERNEL_ELF = $(BUILD_PATH)/kernel
RUSTFLAGS_RELEASE = -C link-arg=-Tlink.ld
COMPILER_ARGS = --target $(TARGET) --release
KERNEL_BIN = $(BUILD_PATH)/kernel.img


ifeq ($(DEBUG), 1)
	QEMU_DEBUG = -s -S
endif

.PHONY: all clean qemu

all: $(KERNEL_BIN)

$(KERNEL_ELF):
	RUSTFLAGS="$(RUSTFLAGS_RELEASE)" cargo rustc $(COMPILER_ARGS)

$(KERNEL_BIN): $(KERNEL_ELF)
	aarch64-linux-gnu-objcopy -O binary $< $@


qemu: $(KERNEL_BIN)
	qemu-system-aarch64 $(QEMU_DEBUG) -display none -serial stdio -cpu cortex-a53 -m 2G -smp 4 -machine virt -d in_asm $(QEMU_EXTRA) -kernel $(KERNEL_ELF)


clean:
	cargo clean
