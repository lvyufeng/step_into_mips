# Lab 10 Tiny OS RTL

This directory derives the final teaching SoC from `lab_9_ddr` and boots a generated StepOS image.

## Main modules

- `top.v` — Nexys4 DDR hardware top. It keeps the Lab 9 clocking and true MIG DDR2 path, but instantiates the Lab 10 SoC and the generated `lab10_mig` IP.
- `soc.v` — MIPS SoC wrapper. The CPU runs on `clk`; `simple_bus` runs on `bus_clk`, preserving the half-cycle bus timing used by the previous labs.
- `simple_bus.v` — address decoder for the enlarged boot ROM, BRAM, GPIO, UART, timer, IRQ controller, DDR status, and DDR data window.
- `boot_rom.v` — 4096-word StepOS boot ROM, initialized from `lab_10_boot.mem`.
- `ddr_bridge.v`, `ddr_backend_cdc.v`, `mig_axi_adapter.v` — the Lab 9 single-outstanding DDR path reused by StepOS.
- `ddr_model.v` — fast behavioral DDR-like backend used only in simulation.
- `clk_100_to_200.v` — MMCM wrapper that generates the MIG system clock from the board 100 MHz clock.
- `mig/nexys4ddr_mig.prj` — Digilent Nexys4 DDR C.1 MIG project file used by `scripts/build_lab10.tcl` to generate `lab10_mig`.
- `mips_core/` — Lab 10 copy of the wait-state MIPS pipeline with CP0-like interrupt support.

## Address highlights

```text
0x0000_0000 - 0x0000_3fff    StepOS boot ROM
0x0001_0000 - 0x0001_ffff    BRAM RAM for TCBs, stacks, shell state
0x1000_0000 - 0x1000_00ff    GPIO/LED MMIO
0x1000_1000 - 0x1000_10ff    UART MMIO
0x1000_2000 - 0x1000_20ff    timer MMIO
0x1000_3000 - 0x1000_30ff    interrupt controller MMIO
0x1000_4000 - 0x1000_40ff    DDR status MMIO
0x8000_0000 - 0x87ff_ffff    DDR2 data window
```

## StepOS image

`software/tiny_os/gen_lab10_boot.py` generates `lab_10_boot.mem`. The image initializes UART/GPIO/timer/IRQ/DDR, verifies DDR, enables timer interrupts, and starts a two-task round-robin StepOS shell/demo pair. Hardware uses a 10 ms timer tick so the shell drains the single-byte UART RX register frequently enough for interactive input.

Supported shell commands are:

```text
help
ps
mem
led 1
run demo
```

## Simulation vs hardware

Simulation excludes the physical MIG IP and connects `soc` to `ddr_model`. Hardware build excludes `ddr_model` and generates `lab10_mig` from `mig/nexys4ddr_mig.prj`.

## Expected hardware output

At `115200 8N1`, the boot ROM prints:

```text
step_into_mips lab10 tiny os
DDR CAL OK
DDR TEST OK
OS INIT OK
SCHED READY
step-os>
```

The prompt is interactive; use `help`, `ps`, `mem`, `led 1`, and `run demo` for board bring-up.
