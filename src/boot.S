.section .text._start

.global _start

// for now we just loop forever
_start:
    wfi
    b _start
