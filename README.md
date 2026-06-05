# step_into_mips：计算机组成原理实验与参考实现

本仓库整理了一条从基础数字部件到 MIPS SoC、再到教学型 Tiny OS / RTOS 的实验路线。前半部分延续重庆大学计算机组成原理课程改革实验内容；后半部分在 Nexys4 DDR 上补充 SoC、UART、异常/中断、DDR2 和 StepOS baseline，作为《硬件综合设计》和 NSCSCC（龙芯杯系统能力培养大赛）入门的参考实现。

最终集成目标是 **Lab 10: StepOS Tiny OS / RTOS**：在 DDR-capable MIPS SoC 上启动一个小型操作系统 baseline，提供 UART shell、DDR pattern test、timer tick、两个任务 round-robin scheduler 和 syscall-like ABI。

## 实验进度

| Lab | 主题 | 说明 |
| --- | --- | --- |
| 1 | ALU 设计，存储器 IP 使用 | 早期实验仍可参考原分支 [`lab_1`](https://github.com/cquca/step_into_mips/tree/lab_1) |
| 2 | 简单取指译码模块 | 早期实验仍可参考原分支 [`lab_2`](https://github.com/cquca/step_into_mips/tree/lab_2) |
| 3 | 单周期 MIPS CPU | 早期实验仍可参考原分支 [`lab_3`](https://github.com/cquca/step_into_mips/tree/lab_3) |
| 4 | 五级流水 MIPS CPU | 本仓库提供 Vivado batch 仿真/综合脚本 |
| 5 | [SoC 总线与统一地址空间](docs/lab_5_soc.md) | Nexys4 DDR 最小 SoC、boot ROM、GPIO/LED MMIO |
| 6 | [UART 与 Boot Monitor](docs/lab_6_uart_boot.md) | UART MMIO、boot banner、字符回显 |
| 7 | [扩展 ISA 与 C Runtime](docs/lab_7_c_runtime.md) | 扩展指令、byte strobe 数据总线、ISA self-test |
| 8 | [中断、异常和 Timer](docs/lab_8_interrupt.md) | CP0-like `mfc0/mtc0/eret`、timer IRQ、固定异常入口 |
| 9 | [DDR2 外部内存](docs/lab_9_ddr.md) | `d_valid/d_ready` wait-state 访存、行为级 DDR model、true MIG |
| 10 | [Tiny OS / RTOS](docs/lab_10_tiny_os.md) | StepOS shell、DDR test、timer tick、两任务 round-robin scheduler |

Labs 5-10 的系统演进和设计取舍见 [`docs/lab_5_to_lab_10_roadmap.md`](docs/lab_5_to_lab_10_roadmap.md)。

## 仓库结构

```text
src/        RTL 源码，按 lab 分目录；src/common 放共享 UART 等模块
sim/        Vivado/XSim testbench
scripts/    Vivado batch 仿真、bitstream 构建和 JTAG 下载脚本
software/   boot image 生成器和教学软件镜像
constr/     Nexys4 DDR XDC 约束
coe/        早期实验使用的 COE 教学文件
docs/       Labs 5-10 文档、路线和设计说明
xpr/        早期实验 Vivado project 文件
tools/      预留/辅助工具目录
```

生成的 boot ROM 镜像（例如 `src/lab_10_tiny_os/lab_10_boot.mem`）和 listing（例如 `software/tiny_os/gen_lab10_boot.lst`）作为教学参考材料保留在仓库中；Vivado `build/`、`.jou`、`.log`、bitstream/checkpoint 等构建产物不应提交。

## Vivado 环境

本机示例环境为 Vivado 2025.2：

```bash
set +u
unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
```

如果安装路径不同，请调整 `settings64.sh` 路径。

## Lab 10 快速测试

### 1. 生成 StepOS boot ROM

```bash
cd /mnt/data1/nexys4/step_into_mips
python3 software/tiny_os/gen_lab10_boot.py
```

输出：

```text
src/lab_10_tiny_os/lab_10_boot.mem
software/tiny_os/gen_lab10_boot.lst
```

### 2. 行为级仿真

```bash
set +u
unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
vivado -mode batch -source scripts/sim_lab10.tcl
```

成功标志：

```text
Simulation succeeded: lab_10 StepOS shell and scheduler verified
LAB10_SIM_DONE
```

### 3. 构建 true-MIG bitstream

```bash
vivado -mode batch -source scripts/build_lab10.tcl
```

成功标志：

```text
LAB10_BITSTREAM=/mnt/data1/nexys4/step_into_mips/build/lab10_top.bit
```

并且 routed timing report 中应有：

```text
All user specified timing constraints are met.
```

### 4. 下载到 Nexys4 DDR

```bash
vivado -mode batch -source scripts/program_lab10.tcl
```

成功标志：

```text
LAB10_PROGRAMMED=xc7a100t_0 BITSTREAM=/mnt/data1/nexys4/step_into_mips/build/lab10_top.bit
```

### 5. UART shell 测试

串口参数：

```text
/dev/ttyUSB1
115200 8N1
```

推荐：

```bash
picocom -b 115200 --flow n --parity n --databits 8 /dev/ttyUSB1
```

如果串口打开时已经错过启动输出，保持串口打开后按 Nexys4 DDR 的 BTNC 中间按钮复位。期望启动输出：

```text
step_into_mips lab10 tiny os
DDR CAL OK
DDR TEST OK
OS INIT OK
SCHED READY
step-os>
```

Shell 不回显输入字符；直接输入命令并按 Enter 即可：

```text
help
ps
mem
led 1
run demo
```

期望响应：

```text
help ps mem led run
task0 shell
task1 demo
DDR CAL OK
DDR TEST OK
OK
demo started
```

## 其它实验常用命令

Lab 4：

```bash
vivado -mode batch -source scripts/sim_lab4.tcl
vivado -mode batch -source scripts/build_lab4.tcl
```

Lab 5：

```bash
vivado -mode batch -source scripts/sim_lab5.tcl
vivado -mode batch -source scripts/build_lab5.tcl
vivado -mode batch -source scripts/program_lab5.tcl
```

Lab 6-9 在仿真/构建前可先重新生成 boot image：

```bash
python3 software/lab_6/gen_lab6_boot.py
python3 software/lab_7/gen_lab7_boot.py
python3 software/lab_8/gen_lab8_boot.py
python3 software/lab_9/gen_lab9_boot.py
```

然后运行对应脚本：

```bash
vivado -mode batch -source scripts/sim_labN.tcl
vivado -mode batch -source scripts/build_labN.tcl
vivado -mode batch -source scripts/program_labN.tcl
```

其中 `N` 为 `6`、`7`、`8` 或 `9`。

## 文档入口

- Labs 5-10 系统演进：[`docs/lab_5_to_lab_10_roadmap.md`](docs/lab_5_to_lab_10_roadmap.md)
- Lab 10 StepOS：[`docs/lab_10_tiny_os.md`](docs/lab_10_tiny_os.md)
- 脚本说明：[`scripts/README.md`](scripts/README.md)
- StepOS 软件镜像说明：[`software/tiny_os/README.md`](software/tiny_os/README.md)

预备知识和器件实现可参考原仓库分支：[prepare](https://github.com/cquca/step_into_mips/tree/prepare)。

附录文档可参考原仓库分支：[appendix](https://github.com/cquca/step_into_mips/tree/appendix)。

## 参考与致谢

本实验内容以《Digital Design and Computer Architecture》为基础，同时引入由龙芯中科提供的比赛资源作为参考，特此感谢。

- DDCA: [Elsevier Book Store](https://www.elsevier.com/books/digital-design-and-computer-architecture/harris/978-0-12-394424-5)
- NSCSCC: [全国大学生系统能力培养大赛官网](http://www.nscscc.org/)
- linuxdo: [linuxdo](https://linux.do)
