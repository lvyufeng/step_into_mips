# Lab 6 UART routines (notes)
#
# The first ROM is generated as straight-line assembly by gen_lab6_boot.py.
# After lab_7 adds a larger ISA subset (lui/ori/bne/jal/jr/byte loads/stores),
# these routines can become real callable subroutines:
#
#   uart_putc($a0)
#   uart_getc() -> $v0
#   uart_puts($a0)
#   uart_getline($a0, $a1)
