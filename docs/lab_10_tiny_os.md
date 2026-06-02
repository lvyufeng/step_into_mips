# Lab 10: Tiny OS / RTOS

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

Lab 10 在前面实验形成的 MIPS SoC 上实现一个教学型 Tiny OS / RTOS baseline，命名为 **StepOS**。它不是 Linux，而是用最小硬件和最小软件机制展示：boot、UART console、timer tick、任务切换、内核调用和 shell。

Lab 10 继承 Lab 9 的硬件基础：

- Lab 7 ISA 扩展；
- Lab 8 CP0-like `mfc0/mtc0/eret`、timer interrupt 和 IRQ controller；
- Lab 9 `d_valid/d_ready` wait-state 数据访存和 DDR2 后端；
- 行为级 DDR 仿真模型 + 上板 true MIG 7-series DDR2 控制器。

## 功能范围

StepOS baseline 包含：

```text
boot
UART console
timer tick
two tasks round-robin
syscall-like putchar/getchar/yield/led/ps/mem
simple shell
```

为了控制教学和验证复杂度，本实验没有新增真正的 MIPS `syscall` 指令异常入口。当前采用 callable ABI 形式的 syscall-like 服务：

```text
$v0 = service id
$a0/$a1/$a2 = arguments
jal os_call
return value in $v0
```

服务号：

```text
1: putchar
2: getchar / getchar_poll
3: yield
4: led
5: ps
6: mem
```

真正的同步 `syscall` exception、Cause.ExcCode 细分和用户/内核隔离可作为后续扩展。

## 地址空间

```text
0x0000_0000 - 0x0000_3fff    StepOS boot ROM, exception vector at 0x0000_0180
0x0001_0000 - 0x0001_ffff    BRAM RAM: TCBs, stacks, shell/global state
0x1000_0000 - 0x1000_00ff    GPIO/LED MMIO
0x1000_1000 - 0x1000_10ff    UART MMIO
0x1000_2000 - 0x1000_20ff    timer MMIO
0x1000_3000 - 0x1000_30ff    interrupt controller MMIO
0x1000_4000 - 0x1000_40ff    DDR status MMIO
0x8000_0000 - 0x87ff_ffff    DDR2, 128 MiB
```

Boot ROM 从 Lab 9 的 1024 words 扩展到 4096 words，以容纳 StepOS shell 和 scheduler。OS 的关键状态保存在 BRAM；DDR 主要由 `mem` 命令做 calibration/status 和 pattern test，避免把任务切换关键路径绑到慢外存上。

## StepOS boot flow

`software/tiny_os/gen_lab10_boot.py` 生成 `src/lab_10_tiny_os/lab_10_boot.mem` 和 listing。启动流程：

1. 设置 UART/GPIO/timer/IRQ/DDR status/DDR base 的基地址寄存器。
2. 关闭 CP0 interrupt，初始化 LED。
3. 打印 banner：
   ```text
   step_into_mips lab10 tiny os
   ```
4. 等待 DDR calibration done。
5. 在 DDR 中写读 pattern，成功打印：
   ```text
   DDR CAL OK
   DDR TEST OK
   ```
6. 清零 BRAM 中的 TCB/global 区域。
7. 初始化两个任务：
   - task0: shell task；
   - task1: demo task。
8. 配置 timer/IRQ controller，开启 CP0 Status.IE。
9. 打印：
   ```text
   OS INIT OK
   SCHED READY
   step-os>
   ```
10. 进入 shell task；timer interrupt 按 round-robin 在 shell/demo 两个任务之间切换。硬件顶层默认使用 10 ms tick（50 MHz 下 `500000` cycles），让 shell 能频繁运行并及时清空单字节 UART RX holding register。

## Scheduler 和 TCB

Timer interrupt 入口仍为固定异常向量 `0x0000_0180`。handler 做：

```text
clear timer pending
tick_count++
save current task GPRs + EPC
current_task ^= 1
next_task.run_count++
restore next task GPRs + EPC
eret
```

教学实现保存所有通用寄存器和 EPC，避免只按 ABI 子集保存带来的隐藏 bug。handler 不在 timer ISR 中打印 UART，避免阻塞式 UART 拉长中断延迟；任务运行情况通过 `ps` 命令和仿真中的 BRAM run counter 验证。

## Shell

Shell prompt：

```text
step-os>
```

支持命令：

```text
help      打印命令列表
ps        打印两个任务
mem       打印 DDR calibration/test 结果
led 1     点亮 LED0 并打印 OK
run demo  允许 demo task 增加 demo counter
```

示例：

```text
step-os> help
help ps mem led run
step-os> ps
task0 shell
task1 demo
step-os> mem
DDR CAL OK
DDR TEST OK
step-os> led 1
OK
step-os> run demo
demo started
```

## 使用方法

生成 StepOS boot ROM：

```bash
python3 software/tiny_os/gen_lab10_boot.py
```

运行行为级仿真：

```bash
set +u; unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
vivado -mode batch -source scripts/sim_lab10.tcl
```

期望看到：

```text
Simulation succeeded: lab_10 StepOS shell and scheduler verified
LAB10_SIM_DONE
```

构建 true-MIG bitstream：

```bash
set +u; unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
vivado -mode batch -source scripts/build_lab10.tcl
```

期望看到：

```text
LAB10_BITSTREAM=/.../build/lab10_top.bit
```

并且 routed timing summary 中：

```text
All user specified timing constraints are met.
```

下载到 Nexys4 DDR：

```bash
vivado -mode batch -source scripts/program_lab10.tcl
```

期望看到：

```text
LAB10_PROGRAMMED=xc7a100t_0 BITSTREAM=...
```

串口参数为 `115200 8N1`。硬件验收至少应看到：

```text
step_into_mips lab10 tiny os
DDR CAL OK
DDR TEST OK
OS INIT OK
SCHED READY
step-os>
```

随后可手动输入 `help`、`ps`、`mem`、`led 1`、`run demo` 验证 shell 和任务切换。

## 验收标准

- 行为级仿真通过 `LAB10_SIM_DONE`。
- true MIG bitstream 构建成功，timing met。
- JTAG program 成功，startup status HIGH。
- Nexys4 DDR 硬件 UART 输出 StepOS banner、DDR OK、SCHED READY 和 `step-os>` prompt。
- Shell 命令 `help/ps/mem/led 1/run demo` 可用，LED 命令能改变板上 LED。

## Linux 定位

Linux 需要 MMU/TLB、完整 MIPS32 CP0、cache/uncached segment、复杂异常处理、device tree 或平台代码、完整 ABI 和工具链支持。这已经超出主线教学 CPU 补完范围。Lab 10 的主线目标是 TinyMIPS OS / StepOS；Linux 可作为远期 appendix。

## 限制和下一步

- 当前 syscall 是 callable ABI，不是 MIPS `syscall` 指令异常。
- 当前没有用户态/内核态隔离、MMU、TLB 或进程地址空间。
- Shell parser 只识别最小命令集的首字母/固定形式，目的是确定性验证。
- OS 镜像仍由 Python 生成机器码；后续可把 `software/tiny_os/kernel/`、`shell/`、`user/` 逐步迁移为汇编/C 源码和 linker flow。
- Scheduler 是两任务 round-robin，无优先级和阻塞队列。
