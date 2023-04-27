use core::arch::{global_asm, asm};

global_asm!(include_str!("boot.S"));


const KERNEL_HELLO: &[u8] = b"nkernel init: Hello!\n";
#[no_mangle]
pub extern "C" fn _bootcore_init() -> ! {
    unsafe{asm!("ldr x1, [{header}]",
                "wfi",
                header = in(reg) &KERNEL_HELLO);}
    loop {}
}
