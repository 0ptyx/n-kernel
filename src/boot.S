.section .text._start

.global _start

// boot entry point
// Only boot if we're the bootcore.
_start:
    mrs x0, mpidr_el1
    and x0, x0, #0xff
    cbz x0, boot
halt:
    b halt

// bootcore entry point
boot:
    adr x0, __bss_start
    adr x1, __bss_end
    sub x1, x1, x0
bss_clear:
    stp xzr, xzr, [x0], #16
    subs x1, x1, #16
    b.gt bss_clear
    b _bootcore_init
