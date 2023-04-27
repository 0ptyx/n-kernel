#![no_std]
#![no_main]

use core::arch::global_asm;
mod panic;
mod boot;

fn kmain() -> ! {
    loop {}
}
