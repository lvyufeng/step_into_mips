# StepOS software

This directory contains the generated software image for Lab 10 Tiny OS / RTOS.

The baseline keeps the implementation in `gen_lab10_boot.py`, following the earlier lab boot-ROM generator style.  The generator emits a compact MIPS machine-code image with:

- UART console routines;
- DDR status and pattern test;
- timer/IRQ/CP0 setup;
- a two-task round-robin scheduler;
- a small syscall-like ABI dispatch routine;
- a deterministic shell with `help`, `ps`, `mem`, `led 1`, and `run demo` commands.

Generate the image with:

```bash
python3 software/tiny_os/gen_lab10_boot.py
```

Generated outputs:

```text
src/lab_10_tiny_os/lab_10_boot.mem
software/tiny_os/gen_lab10_boot.lst
```

`kernel/`, `shell/`, and `user/` remain as source-organization placeholders for the next step, where StepOS can be moved from generated assembly into separate source files or a C toolchain flow.
