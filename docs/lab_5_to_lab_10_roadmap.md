# Labs 5-10：从教学 MIPS CPU 到 StepOS 的系统演进

本文档是 `step_into_mips` 后半段实验（Labs 5-10）的最终路线和设计 rationale。早期 Labs 1-4 完成基础数字部件、单周期 CPU 和五级流水 CPU；Labs 5-10 在此基础上逐步加入 SoC、UART、ISA/runtime、中断、DDR2 和 Tiny OS 能力，最终形成可在 Nexys4 DDR 上运行的 **StepOS** baseline。

主线目标不是直接移植 Linux，而是用可观察、可仿真、可上板验证的教学步骤，让学生理解一个最小 MIPS SoC 如何逐步具备操作系统所需的硬件和软件机制。

## 总体演进

```text
lab_1  ALU 设计、存储器 IP 使用
lab_2  简单取指译码模块
lab_3  单周期 MIPS CPU
lab_4  简单五级流水线 MIPS CPU
lab_5  SoC 总线与统一地址空间
lab_6  UART 与 Boot Monitor
lab_7  扩展 ISA 与 C Runtime 基础
lab_8  CP0-like 中断、异常和 Timer
lab_9  DDR2 外部内存与 wait-state 访存
lab_10 StepOS Tiny OS / RTOS baseline
```

Labs 5-10 的核心设计原则：

1. **每一层只引入一类关键能力**，避免一次性跨到完整系统软件。
2. **所有新增能力都有仿真验收和上板验收**。
3. **硬件机制保持教学可见性**：地址译码、MMIO、timer IRQ、DDR ready/valid、TCB/context switch 都可以在 RTL 或 testbench 中直接追踪。
4. **软件先使用 boot-ROM generator**，保证无外部交叉编译工具链时也能复现实验。
5. **Linux 明确不是主线目标**；Lab 10 交付 Tiny OS / RTOS baseline，Linux 可作为远期 appendix。

## 最终仓库结构

```text
src/lab_5_soc/          Lab 5 RTL：SoC bus + boot ROM + BRAM + GPIO
src/lab_6_uart_boot/    Lab 6 RTL：UART MMIO + boot monitor
src/lab_7_c_runtime/    Lab 7 RTL：扩展 ISA + byte strobe 数据通路
src/lab_8_interrupt/    Lab 8 RTL：CP0-like + timer IRQ + irq controller
src/lab_9_ddr/          Lab 9 RTL：DDR bridge + behavioral DDR + true MIG
src/lab_10_tiny_os/     Lab 10 RTL：StepOS boot ROM + Lab 9 hardware base

sim/lab_*_tb.v          对应实验的 XSim testbench
scripts/sim_lab*.tcl    行为级仿真脚本
scripts/build_lab*.tcl  bitstream 构建脚本
scripts/program_lab*.tcl JTAG 下载脚本
software/lab_*/         Labs 6-9 boot image generator
software/tiny_os/       Lab 10 StepOS generator
constr/                 Nexys4 DDR XDC
```

生成的 `.mem` 和 `.lst` 文件作为教学参考产物提交到仓库；Vivado `build/`、日志、bitstream、checkpoint 等构建输出不提交。

## Lab 5：SoC 总线与统一地址空间

### 教学目标

Lab 5 从“CPU 直接连接 instruction/data memory”过渡到最小 SoC：

```text
CPU + simple_bus + boot ROM + BRAM RAM + MMIO GPIO
```

学生需要理解：

- CPU 通过地址访问不同设备；
- ROM、RAM、MMIO 都是统一地址空间的一部分；
- 外设寄存器与普通内存访问在硬件上通过地址译码区分；
- boot ROM 可以让系统上电后自动运行固定程序。

### 最终结构

代表性文件：

```text
src/lab_5_soc/top.v
src/lab_5_soc/soc.v
src/lab_5_soc/simple_bus.v
src/lab_5_soc/boot_rom.v
src/lab_5_soc/bram_ram.v
src/lab_5_soc/gpio_mmio.v
sim/lab_5_soc_tb.v
scripts/sim_lab5.tcl
scripts/build_lab5.tcl
scripts/program_lab5.tcl
```

### 验收

- 仿真：CPU 从 boot ROM 取指，向 GPIO/LED MMIO 写入可检测值。
- 上板：Nexys4 DDR LED 按 boot ROM 程序变化。

## Lab 6：UART 与 Boot Monitor

### 教学目标

Lab 6 加入串口 MMIO，使 SoC 不再只能通过 LED 观察状态，而可以通过 USB-UART 打印 banner、接收输入并回显。

新增能力：

- UART TX/RX；
- UART status/data MMIO register；
- boot monitor 风格的软件入口；
- testbench 中 UART bit-level 收发验证。

### 最终结构

代表性文件：

```text
src/lab_6_uart_boot/uart_mmio.v
src/common/uart_tx.v
src/common/uart_rx.v
software/lab_6/gen_lab6_boot.py
src/lab_6_uart_boot/lab_6_boot.mem
sim/lab_6_uart_boot_tb.v
scripts/sim_lab6.tcl
scripts/build_lab6.tcl
scripts/program_lab6.tcl
```

### 验收

- 仿真和硬件 UART 输出 boot banner。
- 串口输入字符后系统回显。
- 串口参数：`115200 8N1`。

## Lab 7：扩展 ISA 与 C Runtime 基础

### 教学目标

Lab 7 补足运行更复杂软件所需的基础指令和数据通路能力，重点是让 boot image 可以执行更像 runtime/self-test 的程序。

新增能力包括：

```text
lui / ori / andi / xori / bne / jal / jr / addu / subu / sll / srl
byte strobe data bus
更完整的 boot ROM self-test
```

### 设计意义

- `lui/ori` 让软件能构造 32-bit 地址和常量；
- `jal/jr` 让 generator 能组织子程序；
- byte strobe 是后续 MMIO、UART 和 C runtime 的基础；
- ISA self-test 让 CPU 行为更容易回归验证。

### 验收

- 仿真输出 `ISA PASS`。
- 上板 UART 输出 banner 和 `ISA PASS`，随后进入字符回显。

## Lab 8：中断、异常和 Timer

### 教学目标

Lab 8 引入最小 CP0-like 机制、固定异常入口和 timer interrupt，为 OS scheduler 做准备。

核心机制：

```text
CP0 Count / Compare / Status / Cause / EPC
mfc0 / mtc0 / eret
fixed exception vector: 0x0000_0180
timer_mmio + irq_controller
```

### 设计取舍

Lab 8 实现的是教学用 CP0-like 子集，不是完整 MIPS32 privileged architecture。它足以支撑：

- 开关全局中断；
- timer pending；
- 进入固定异常入口；
- 保存 EPC 并通过 `eret` 返回。

同步异常分类、TLB/MMU、用户态/内核态隔离等留作远期扩展。

### 验收

- 启动后 UART 输出 banner 和 `IRQ READY`。
- timer 周期触发 interrupt，handler 打印 `tick` 并递增 LED。
- 仿真检查 tick 输出和 LED 变化。

## Lab 9：DDR2 外部内存与 wait-state 访存

### 教学目标

Lab 9 把 Nexys4 DDR 板载 DDR2 接入 SoC，让 CPU 面对真实外部存储器延迟。

关键新增能力：

```text
d_valid / d_ready wait-state 数据访存接口
DDR address window: 0x8000_0000 - 0x87ff_ffff
behavioral ddr_model for simulation
true MIG 7-series DDR2 backend for hardware
bus/CPU stall while DDR transaction is outstanding
```

### 设计意义

早期 Labs 的 BRAM/MMIO 都可以单周期响应；DDR2 必须引入可停顿的数据访存协议。Lab 9 因此是从“简单 SoC”走向“真实外设/内存系统”的关键一步。

### 验收

- 仿真：行为级 `ddr_model` calibration done 后，DDR pattern 写读通过。
- 上板：true MIG calibration done，DDR pattern 写读通过。
- UART 可看到：

```text
step_into_mips lab9 ddr
DDR CAL OK
DDR PASS
```

## Lab 10：StepOS Tiny OS / RTOS baseline

### 教学目标

Lab 10 在 Lab 9 DDR-capable SoC 上实现教学型 Tiny OS / RTOS baseline：**StepOS**。

StepOS 展示最小 OS 所需的主干机制：

```text
boot
UART console
timer tick
two tasks round-robin
syscall-like ABI
simple shell
DDR mem command
```

### 硬件基础

Lab 10 复用 Lab 9 的硬件主干：

- CP0-like interrupt path；
- timer/irq controller；
- UART/GPIO MMIO；
- `d_valid/d_ready` wait-state memory；
- behavioral DDR model；
- true MIG DDR2 backend。

Lab 10 的 boot ROM 扩展到 4096 words，读取：

```text
src/lab_10_tiny_os/lab_10_boot.mem
```

### 软件结构

StepOS baseline 由 Python generator 生成机器码：

```text
software/tiny_os/gen_lab10_boot.py
software/tiny_os/gen_lab10_boot.lst
```

这样保持与前面 boot-ROM generator 实验一致，不强制引入外部汇编器、链接脚本或 C cross toolchain。未来可以把 generator 中的 kernel/shell/user 逻辑拆成独立源码，但这不是 Lab 10 baseline 的必需条件。

### Shell contract

启动输出：

```text
step_into_mips lab10 tiny os
DDR CAL OK
DDR TEST OK
OS INIT OK
SCHED READY
step-os>
```

支持命令：

```text
help
ps
mem
led 1
run demo
```

当前 shell 不回显输入字符；这是为了保持实现和验证简单。输入命令后按 Enter，系统直接输出结果和下一个 prompt。

### 验收

Lab 10 已具备三层验收：

1. 行为级仿真：`LAB10_SIM_DONE`。
2. true-MIG bitstream：routed timing met。
3. Nexys4 DDR 硬件：JTAG startup HIGH，UART shell 命令通过。

## 地址空间演进

Labs 5-10 使用的最终主地址空间如下：

```text
0x0000_0000 - 0x0000_3fff    boot ROM / StepOS ROM
0x0001_0000 - 0x0001_ffff    BRAM RAM / stacks / TCBs / globals
0x1000_0000 - 0x1000_00ff    GPIO / LED MMIO
0x1000_1000 - 0x1000_10ff    UART MMIO
0x1000_2000 - 0x1000_20ff    timer MMIO
0x1000_3000 - 0x1000_30ff    interrupt controller MMIO
0x1000_4000 - 0x1000_40ff    DDR status MMIO
0x8000_0000 - 0x87ff_ffff    DDR2 data window
```

早期实验只使用其中一部分；后续实验逐步扩展，而不是改变已有区域的语义。

## 为什么 Lab 10 不是 Linux

Linux 需要远超过当前教学 CPU baseline 的机制：

- MMU/TLB 和完整地址空间隔离；
- 完整 MIPS32 CP0 privileged architecture；
- cache/uncached segment 语义；
- 更完整异常分类和系统调用路径；
- device tree 或平台代码；
- 成熟 ABI、启动协议和 cross toolchain。

这些内容适合作为远期 appendix 或比赛进阶路线。Labs 5-10 的主线目标是 TinyMIPS OS / StepOS：用最少机制演示 boot、console、timer、任务切换、内核服务和 DDR 资源管理。

## 最终验证命令

Lab 10 generator：

```bash
python3 software/tiny_os/gen_lab10_boot.py
```

Lab 10 simulation：

```bash
set +u
unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
vivado -mode batch -source scripts/sim_lab10.tcl
```

期望：

```text
Simulation succeeded: lab_10 StepOS shell and scheduler verified
LAB10_SIM_DONE
```

Lab 10 bitstream：

```bash
vivado -mode batch -source scripts/build_lab10.tcl
```

期望：

```text
LAB10_BITSTREAM=/mnt/data1/nexys4/step_into_mips/build/lab10_top.bit
All user specified timing constraints are met.
```

Lab 10 program：

```bash
vivado -mode batch -source scripts/program_lab10.tcl
```

期望：

```text
LAB10_PROGRAMMED=xc7a100t_0 BITSTREAM=/mnt/data1/nexys4/step_into_mips/build/lab10_top.bit
```

UART：`/dev/ttyUSB1`，`115200 8N1`。
