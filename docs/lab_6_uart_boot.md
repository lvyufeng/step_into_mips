# Lab 6: UART 与 Boot Monitor

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

在 `lab_5` SoC 基础上加入 UART MMIO，使 CPU 可以通过串口和 PC 交互，并运行最小 boot monitor。

## UART 地址

```text
0x1000_1000 UART_TXDATA
0x1000_1004 UART_RXDATA
0x1000_1008 UART_STATUS
```

`UART_STATUS`：

```text
bit 0: tx_ready
bit 1: rx_valid
```

为兼容当前 lab_4/lab_5 的极简 ISA，RTL 同时提供一个低地址 alias，便于用 16-bit immediate 访问：

```text
0x0000_1000 UART_TXDATA
0x0000_1004 UART_RXDATA
0x0000_1008 UART_STATUS
```

后续 `lab_7` 增加 `lui/ori` 后，软件应改用正式的 `0x1000_1000` 地址。

## 第一版 monitor 命令

目标命令集：

```text
h              help
r addr         read word
w addr data    write word
g addr         jump
```

当前 lab_6 第一阶段先完成 UART 硬件链路和最小 monitor 验收：启动后打印 banner，并 echo 输入字符；完整命令解析将在 lab_7 补齐 byte/shift/jal/jr/bne 等指令后实现。

## How to use

生成 boot ROM：

```bash
python3 software/lab_6/gen_lab6_boot.py
```

仿真：

```bash
source /path/to/Xilinx/2025.2/Vivado/settings64.sh
vivado -mode batch -source scripts/sim_lab6.tcl
```

构建 bitstream：

```bash
vivado -mode batch -source scripts/build_lab6.tcl
```

下载到 Nexys4 DDR：

```bash
vivado -mode batch -source scripts/program_lab6.tcl
```

串口参数：`115200 8N1`。Nexys4 DDR USB-UART 引脚使用 Digilent master XDC 的 `UART_TXD_IN=C4`、`UART_RXD_OUT=D4`，其中命名是 USB 主机视角：FPGA `uart_rx_i` 接 C4，FPGA `uart_tx_o` 接 D4。顶层把 100 MHz 输入时钟分频到 50 MHz 运行 SoC，UART 参数对应设置为 `UART_CLKS_PER_BIT=434`。下载后顶层会自动产生一个短暂的 power-on reset，不需要手动按 BTNC 才能启动 CPU。

## 验收标准

上板后，PC 串口终端看到：

```text
step_into_mips boot monitor
> 
```

在终端继续输入字符时，开发板会回显字符，并递增 LED 作为 RX 活动指示。
