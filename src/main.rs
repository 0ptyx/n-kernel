#![no_std]
#![no_main]

use core::arch::global_asm;
mod panic;
global_asm!(include_str!("boot.S"));

fn kmain() -> ! {
    loop {}
}
