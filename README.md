## 计算机组成原理实验与参考实现

本仓库包含重庆大学由2017年开始实施的计算机组成原理课程改革实验内容，通过合理的梯度划分，一步一步由单独器件连接构成CPU，最后实现一个简单的MIPS五级流水CPU。

本项目实验为《硬件综合设计》课程前导，同时也可作为NSCSCC（龙芯杯系统能力培养大赛）的入门教程。

****
课程实验如下：
1. ALU设计，存储器IP使用: [lab_1](https://github.com/cquca/step_into_mips/tree/lab_1)
2. 简单的取指译码模块: [lab_2](https://github.com/cquca/step_into_mips/tree/lab_2)
3. 单周期MIPS CPU设计: [lab_3](https://github.com/cquca/step_into_mips/tree/lab_3)
4. 简单五级流水线MIPS CPU设计: [lab_4](https://github.com/cquca/step_into_mips/tree/lab_4)
5. SoC 总线与统一地址空间: [lab_5_soc](docs/lab_5_soc.md)
6. UART 与 Boot Monitor: [lab_6_uart_boot](docs/lab_6_uart_boot.md)
7. 扩展 ISA 与 C Runtime: [lab_7_c_runtime](docs/lab_7_c_runtime.md)
8. 中断、异常和 Timer: [lab_8_interrupt](docs/lab_8_interrupt.md)
9. DDR2 外部内存: [lab_9_ddr](docs/lab_9_ddr.md)
10. Tiny OS / RTOS: [lab_10_tiny_os](docs/lab_10_tiny_os.md)

## How to use

### 准备 Vivado 环境

```bash
# 按实际安装路径调整；本机示例：/mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
source /path/to/Xilinx/2025.2/Vivado/settings64.sh
```

### 运行实验

- `lab_1` ~ `lab_3`：切换到对应分支查看工程、文档和仿真文件。
- `lab_4`：五级流水线 MIPS CPU，支持 Vivado batch 仿真和综合。

  ```bash
  vivado -mode batch -source scripts/sim_lab4.tcl
  vivado -mode batch -source scripts/build_lab4.tcl
  ```

- `lab_5_soc`：Nexys4 DDR 最小 SoC，CPU 从 boot ROM 启动，经 simple bus 写 GPIO/LED MMIO。

  ```bash
  vivado -mode batch -source scripts/sim_lab5.tcl
  vivado -mode batch -source scripts/build_lab5.tcl
  vivado -mode batch -source scripts/program_lab5.tcl
  ```

  其中 `build_lab5.tcl` 会生成 `build/lab5_top.bit`；`program_lab5.tcl` 会通过 JTAG 下载到已连接的 Nexys4 DDR，板上 LED 会按软件延时循环计数。

- `lab_6_uart_boot`：UART MMIO 与最小 boot monitor，启动后通过串口打印 banner 并回显输入字符。

  ```bash
  python3 software/lab_6/gen_lab6_boot.py
  vivado -mode batch -source scripts/sim_lab6.tcl
  vivado -mode batch -source scripts/build_lab6.tcl
  vivado -mode batch -source scripts/program_lab6.tcl
  ```

  串口参数为 `115200 8N1`。

- `lab_7_c_runtime`：扩展 ISA（`lui/ori/andi/xori/bne/jal/jr/addu/subu/sll/srl`）与带 byte strobe 的数据总线，运行 ISA 自测并通过 UART 打印 banner、`ISA PASS` 后进入字符回显。

  ```bash
  python3 software/lab_7/gen_lab7_boot.py
  vivado -mode batch -source scripts/sim_lab7.tcl
  vivado -mode batch -source scripts/build_lab7.tcl
  vivado -mode batch -source scripts/program_lab7.tcl
  ```

  串口参数为 `115200 8N1`。

- `lab_8_interrupt`：最小 CP0-like 寄存器与 `mfc0/mtc0/eret`、timer 外设、中断控制器与固定异常入口 `0x0000_0180`。启动后通过串口打印 banner、`IRQ READY`，随后 timer 每约 1 秒触发一次中断，handler 打印 `tick` 并递增 LED。

  ```bash
  python3 software/lab_8/gen_lab8_boot.py
  vivado -mode batch -source scripts/sim_lab8.tcl
  vivado -mode batch -source scripts/build_lab8.tcl
  vivado -mode batch -source scripts/program_lab8.tcl
  ```

  串口参数为 `115200 8N1`。

- `lab_9_ddr`：把 Nexys4 DDR 板载 DDR2 接入 `0x8000_0000 - 0x87ff_ffff`，CPU 数据访存接口升级为 `d_valid/d_ready` wait-state 模型；仿真使用行为级 `ddr_model`，上板使用真实 MIG 7-series DDR2 控制器。启动后等待 DDR calibration、写读 pattern，成功后 LED=`0x005a` 并通过 UART 周期性打印 `DDR PASS`。

  ```bash
  python3 software/lab_9/gen_lab9_boot.py
  vivado -mode batch -source scripts/sim_lab9.tcl
  vivado -mode batch -source scripts/build_lab9.tcl
  vivado -mode batch -source scripts/program_lab9.tcl
  ```

  串口参数为 `115200 8N1`。若从程序最开始捕获，可看到 `step_into_mips lab9 ddr`、`DDR CAL OK`、`DDR PASS`；若 JTAG 下载时 USB-UART 重新枚举，重新打开串口后仍会持续看到 `DDR PASS`。

- `lab_10_tiny_os`：在 Lab 9 DDR SoC 上实现教学型 StepOS baseline，包含 UART shell、DDR pattern test、timer tick 和两个任务 round-robin scheduler。仿真使用行为级 DDR model，上板使用真实 MIG DDR2 控制器。

  ```bash
  python3 software/tiny_os/gen_lab10_boot.py
  vivado -mode batch -source scripts/sim_lab10.tcl
  vivado -mode batch -source scripts/build_lab10.tcl
  vivado -mode batch -source scripts/program_lab10.tcl
  ```

  串口参数为 `115200 8N1`。启动后应看到 `step_into_mips lab10 tiny os`、`DDR CAL OK`、`DDR TEST OK`、`OS INIT OK`、`SCHED READY` 和 `step-os> `；shell 支持 `help`、`ps`、`mem`、`led 1`、`run demo`。

相关文档资料分别位于本仓库不同分支和 `docs/` 目录。

预备知识和器件实现:[prepare](https://github.com/cquca/step_into_mips/tree/prepare)

附录文档:[appendix](https://github.com/cquca/step_into_mips/tree/appendix)
****
**参考与致谢**

本实验内容以《Digital Design and Computer Architecture》为依托进行设计，同时引入了大量由龙芯中科提供的比赛资源，作为参考文档，特此感谢。

若有参考需求，请访问：

**DDCA:** [Elsevier Book Store](https://www.elsevier.com/books/digital-design-and-computer-architecture/harris/978-0-12-394424-5)

**NSCSCC:** [全国大学生系统能力培养大赛官网](http://www.nscscc.org/)

**vsllm:** [vsllm](https://vsllm.com)

****