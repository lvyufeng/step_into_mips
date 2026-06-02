# Lab 7: 扩展 ISA 与 C Runtime

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

`lab_7` 从 `lab_6_uart_boot` 的最小 UART boot monitor 继续推进，扩展教学 MIPS 五级流水 CPU 的指令集、控制流和数据总线接口，使它具备运行受限 C/C-like 裸机程序的前置能力。

本实验不是一次性接入完整 libc 或 Linux ABI，而是先完成后续 C runtime 需要的硬件基础：

- 通过 `lui/ori` 构造 32-bit MMIO 地址；
- 通过 `jal/jr` 支持函数调用和返回；
- 通过 `bne`、`andi/xori`、`sll/srl` 支持常见控制流和位操作；
- 把数据总线写接口升级为 byte strobe，为后续 `char`、字符串和子字访问铺路；
- 用可复现的 Python 小汇编器生成 boot ROM，先验证 ISA 和 UART echo，再逐步过渡到真正的 `start.S`、`linker.ld`、`uart.c` 和交叉编译器流程。

## 已实现的第一批指令

```text
lui
ori
andi
xori
bne
jr
jal
addu
subu
sll
srl
```

保留原有指令：

```text
add/sub/and/or/slt
lw/sw/beq/addi/j
```

其中 `jal` 写 `$31`，返回地址采用无 delay-slot 教学语义下的 `PC+4`；`jr` 使用寄存器作为跳转目标。`addu/subu` 在当前尚无异常机制的教学 CPU 中复用 add/sub 的结果，不触发 overflow 异常。

## 待后续补充的第二批指令

```text
sra
sltu
lb
lbu
lh
lhu
sb
sh
jalr
```

`lab_7` 当前已经把数据写接口升级到 `d_wstrb[3:0]` 并让 BRAM RAM 支持 byte lane 写，后续实现 `lb/lbu/lh/lhu/sb/sh` 时可以在此基础上补 load align、store align 和 sign/zero extension。

## 内存接口升级

从 `lab_6` 的单 bit 写使能：

```verilog
memwriteM
aluoutM
writedataM
readdataM
```

升级为：

```verilog
d_we
d_wstrb[3:0]
d_addr[31:0]
d_wdata[31:0]
d_rdata[31:0]
```

当前 `sw` 生成 `d_wstrb=4'b1111`。BRAM RAM 按 little-endian byte lane 写入：

```text
wstrb[0] -> data[7:0]
wstrb[1] -> data[15:8]
wstrb[2] -> data[23:16]
wstrb[3] -> data[31:24]
```

UART 和 GPIO 仍按 word MMIO 使用；UART TXDATA 取 `wdata[7:0]`。

## 地址空间

继续沿用 `lab_6` 的 SoC 地址空间：

```text
0x0000_0000 - 0x0000_0fff    boot ROM, 4 KiB
0x0001_0000 - 0x0001_0fff    BRAM RAM
0x1000_0000 - 0x1000_00ff    GPIO / LED
0x1000_1000 - 0x1000_10ff    UART
```

UART 寄存器：

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

`lab_7` 软件使用正式高地址 `0x1000_1000`，不再依赖 `lab_6` 为极简 ISA 提供的低地址 alias。

## 软件生成方式

当前可复现路径：

```bash
python3 software/lab_7/gen_lab7_boot.py
```

该脚本会生成：

```text
src/lab_7_c_runtime/lab_7_boot.mem
software/lab_7/gen_lab7_boot.lst
```

boot ROM 程序包含：

1. 使用 `lui/ori` 构造 UART/GPIO 正式 MMIO 地址；
2. 调用 `run_isa_tests` 自测新增 ISA；
3. 打印：

   ```text
   step_into_mips lab7 c-runtime
   ISA PASS
   >
   ```

4. 进入 UART echo loop；
5. 输入字符时回显并递增 LED。

## How to use

生成 boot ROM：

```bash
python3 software/lab_7/gen_lab7_boot.py
```

运行仿真：

```bash
vivado -mode batch -source scripts/sim_lab7.tcl
```

构建 bitstream：

```bash
vivado -mode batch -source scripts/build_lab7.tcl
```

下载到 Nexys4 DDR：

```bash
vivado -mode batch -source scripts/program_lab7.tcl
```

串口参数：`115200 8N1`。Nexys4 DDR USB-UART 使用与 `lab_6` 相同的已验证映射：FPGA `uart_rx_i` 接 C4，FPGA `uart_tx_o` 接 D4。

## 验收标准

仿真输出应包含：

```text
Simulation succeeded: lab_7 ISA PASS and UART echo verified
LAB7_SIM_DONE
```

上板后，PC 串口终端看到：

```text
step_into_mips lab7 c-runtime
ISA PASS
>
```

继续输入字符时，开发板会回显字符，并递增 LED 作为 RX 活动指示。
