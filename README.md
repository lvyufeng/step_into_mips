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

- `lab_6_uart_boot` ~ `lab_10_tiny_os`：查看 `docs/` 中对应实验文档和 `src/`、`software/` 下的目录骨架。

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