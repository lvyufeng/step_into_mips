/* Placeholder linker script for the later lab_6/lab_7 assembled monitor. */
ENTRY(reset)

SECTIONS
{
  . = 0x00000000;
  .text : { *(.text*) }
  .rodata : { *(.rodata*) }
  .data : { *(.data*) }
  .bss : { *(.bss*) *(COMMON) }
}
