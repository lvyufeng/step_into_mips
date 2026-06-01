# Lab 6 monitor command parser placeholder
#
# Target command set from docs/lab_6_uart_boot.md:
#
#   h              help
#   r addr         read word
#   w addr data    write word
#   g addr         jump
#
# The first hardware milestone prints the monitor banner and echoes typed bytes.
# Full parsing becomes much smaller after lab_7 adds shifts, byte access, bne,
# jal/jr, and real 0x1000_0000 address construction.
