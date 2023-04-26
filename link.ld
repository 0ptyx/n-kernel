
/* SBI takes up 0x80000000 - 0x80046500 so put it somewhere else? */
/* or 0? */
__sbi_load_addr = 0x80000000;


ENTRY(__rpi_phys_binary_load_addr)

/* Flags:
 *     4 == R
 *     5 == RX
 *     6 == RW
 */
PHDRS
{
    segment_code PT_LOAD FLAGS(5);
}

SECTIONS
{
    . =  __sbi_load_addr;

    /***********************************************************************************************
    * Code
    ***********************************************************************************************/
    .text :
    {
        KEEP(*(.text._start))
    } :segment_code


}
