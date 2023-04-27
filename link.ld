
__kernel_load_addr = 0x50000000;


ENTRY(_start)

/* Flags:
 *     4 == R
 *     5 == RX
 *     6 == RW
 */
PHDRS
{
    segment_code PT_LOAD FLAGS(5);
    segment_data PT_LOAD FLAGS(6);
}

SECTIONS
{
    . =  __kernel_load_addr;

    /***********************************************************************************************
    * Code
    ***********************************************************************************************/
    .text :
    {
        KEEP(*(.text._start))
    } :segment_code

    .rodata : ALIGN(8)
    {
        *(.rodata*)
    } :segment_code
    
    .data :
    {
        *(.data*)
    } :segment_data

    .bss (NOLOAD) : ALIGN(16)
    {
        __bss_start = .;
        *(.bss*)
        __bss_end = .;
    } :segment_data
}
