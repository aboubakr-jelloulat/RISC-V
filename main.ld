ENTRY(_start)

MEMORY
{
    RAM (rxw) : ORIGIN = 0x80000000, LENGTH = 4K
}

SECTIONS
{
    . = ORIGIN(RAM);

    .text :
    {
        *(.text*)
    } > RAM

    .rodata :
    {
        *(.rodata*)
    } > RAM

    .data :
    {
        *(.data*)
    } > RAM

    .bss :
    {
        *(.bss*)
        *(COMMON)
    } > RAM
}
