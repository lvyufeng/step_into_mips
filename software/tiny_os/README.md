# StepOS software image

This directory contains the software generator for **Lab 10 Tiny OS / RTOS**.

The final Lab 10 baseline intentionally keeps StepOS in `gen_lab10_boot.py`, following the boot-ROM generator style used in earlier labs. This keeps the experiment reproducible without requiring an external MIPS assembler, linker script, or C cross toolchain.

The generator emits a compact MIPS machine-code image with:

- UART console routines;
- DDR status polling and pattern test;
- timer/IRQ/CP0 setup;
- a two-task round-robin scheduler;
- a syscall-like callable ABI dispatch routine;
- a deterministic shell with `help`, `ps`, `mem`, `led 1`, and `run demo` commands.

Generate the image from the repository root:

```bash
python3 software/tiny_os/gen_lab10_boot.py
```

Generated outputs:

```text
src/lab_10_tiny_os/lab_10_boot.mem
software/tiny_os/gen_lab10_boot.lst
```

Both outputs are tracked intentionally as teaching/reference artifacts: the `.mem` file is consumed by `src/lab_10_tiny_os/boot_rom.v`, and the `.lst` file lets readers map generated machine code back to symbolic labels.

A future extension may split the generator into separate `kernel/`, `shell/`, and `user/` assembly/C sources with a linker flow. That source split is not required for the final Lab 10 baseline.
