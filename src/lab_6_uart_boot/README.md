# Lab 6 UART Boot RTL

`lab_6_uart_boot` adds UART MMIO to the lab_5 SoC.  The top-level design divides the Nexys4 DDR 100 MHz clock to 50 MHz for easier timing closure, while the UART keeps 115200 8N1 by using `UART_CLKS_PER_BIT=434`.

See `docs/lab_6_uart_boot.md` for the memory map, software image, and usage commands.
