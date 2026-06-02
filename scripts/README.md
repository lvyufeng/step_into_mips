# Vivado batch scripts

This directory contains command-line scripts for simulation, bitstream generation, and JTAG programming. They are intended to keep every lab reproducible without opening the Vivado GUI.

## Environment

Source Vivado before running any script:

```bash
set +u
unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
```

Adjust the path if Vivado is installed elsewhere.

## Naming convention

```text
sim_labN.tcl      Run behavioral simulation for lab N
build_labN.tcl    Build bitstream for lab N
program_labN.tcl  Program Nexys4 DDR over JTAG for lab N
```

`program_*` scripts require a connected Nexys4 DDR board and a working JTAG connection. Build outputs are written under `build/` and should not be committed.

## Boot image generators

Labs 6-10 use generated boot ROM images. Regenerate them after changing the corresponding software generator:

```bash
python3 software/lab_6/gen_lab6_boot.py
python3 software/lab_7/gen_lab7_boot.py
python3 software/lab_8/gen_lab8_boot.py
python3 software/lab_9/gen_lab9_boot.py
python3 software/tiny_os/gen_lab10_boot.py
```

The generated `.mem` and `.lst` files are intentionally tracked as teaching/reference artifacts.

## Lab 10 quick flow

```bash
python3 software/tiny_os/gen_lab10_boot.py
vivado -mode batch -source scripts/sim_lab10.tcl
vivado -mode batch -source scripts/build_lab10.tcl
vivado -mode batch -source scripts/program_lab10.tcl
```

Expected simulation markers:

```text
Simulation succeeded: lab_10 StepOS shell and scheduler verified
LAB10_SIM_DONE
```

Expected build marker:

```text
LAB10_BITSTREAM=/mnt/data1/nexys4/step_into_mips/build/lab10_top.bit
```

Expected programming marker:

```text
LAB10_PROGRAMMED=xc7a100t_0 BITSTREAM=/mnt/data1/nexys4/step_into_mips/build/lab10_top.bit
```

After programming, use `/dev/ttyUSB1` at `115200 8N1` to test the StepOS shell.
