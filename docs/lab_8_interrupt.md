# Lab 8: 中断、异常和 Timer

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

`lab_8` 在 `lab_7_c_runtime` 基础上为教学 MIPS 五级流水 CPU 加入进入小型 OS 所需的前置能力：

- timer interrupt；
- 固定异常入口 `0x0000_0180`；
- 最小 CP0-like 控制寄存器与 `mfc0/mtc0/eret`；
- 中断进入时保存 EPC、置 EXL、flush 流水线，`eret` 时恢复 PC、清 EXL。

本实验是教学型最小实现，**不是**完整 MIPS32 CP0/MMU。当前范围聚焦“单级、非嵌套的 timer 中断闭环”，作为 `lab_10` Tiny OS 前的基础；通用上下文切换、异常分类、嵌套中断等留作后续扩展。

## 已实现的 COP0 指令

```text
mfc0
mtc0
eret
```

- `mfc0 rt, rd`：把 CP0 寄存器读到通用寄存器；
- `mtc0 rt, rd`：把通用寄存器写到 CP0 寄存器；
- `eret`：清 `Status.EXL`，从 `EPC` 恢复 PC。

保留 `lab_7` 全部指令（`lui/ori/andi/xori/bne/jal/jr/addu/subu/sll/srl` 与基础 `add/sub/and/or/slt/lw/sw/beq/addi/j`）。

## 最小 CP0 集合

按 `rd` 选择：

```text
9   Count     自增计数器（教学用，可由 mtc0 写）
11  Compare   可读写教学寄存器
12  Status    bit0 IE 全局中断使能；bit1 EXL 异常级
13  Cause     bits[15:8] 实时硬件 IRQ 线；bits[6:2] ExcCode
14  EPC       被中断指令的 PC
```

中断接受条件：`hwirq != 0 && Status.IE == 1 && Status.EXL == 0`，且当前 decode 槽是有效指令、未 stall。进入时硬件置 `EXL`（屏蔽嵌套）并保存 `EPC`；`eret` 清 `EXL`。

## 地址空间

在 `lab_7` SoC 地址空间上新增 timer 和中断控制器：

```text
0x0000_0000 - 0x0000_0fff    boot ROM, 4 KiB
0x0001_0000 - 0x0001_0fff    BRAM RAM
0x1000_0000 - 0x1000_00ff    GPIO / LED
0x1000_1000 - 0x1000_10ff    UART
0x1000_2000 - 0x1000_20ff    timer
0x1000_3000 - 0x1000_30ff    interrupt controller
```

Timer 寄存器：

```text
0x1000_2000 TIMER_COUNTER   读/写当前计数
0x1000_2004 TIMER_COMPARE   比较值（复位为 RTL 参数 DEFAULT_COMPARE）
0x1000_2008 TIMER_CONTROL   bit0 enable, bit1 irq_enable, bit2 auto_reload
0x1000_200c TIMER_STATUS    bit0 pending（写 1 清除）
```

中断控制器寄存器：

```text
0x1000_3000 IRQ_PENDING     bit0 timer pending（只读）
0x1000_3004 IRQ_ENABLE      bit0 timer 使能（复位默认 1）
0x1000_3008 IRQ_LINES       pending & enable，汇总到 CPU（只读）
```

`TIMER_COMPARE` 复位值来自 RTL 参数 `TIMER_TICK_CYCLES`：上板默认 `50_000_000`（50 MHz 下约 1 秒），仿真用很小的值快速触发。

## 异常入口

```text
reset vector:     0x0000_0000
exception vector: 0x0000_0180
```

流水线在接受中断时：

```text
flush pipeline（清掉 decode/fetch 错误路径）
保存 EPC
跳转 exception vector 0x180
eret 从 EPC 恢复 PC
```

## 软件生成方式

```bash
python3 software/lab_8/gen_lab8_boot.py
```

该脚本生成：

```text
src/lab_8_interrupt/lab_8_boot.mem
software/lab_8/gen_lab8_boot.lst
```

boot ROM 程序：

1. reset 用 `lui/ori` 构造 UART/GPIO/timer/IRQ MMIO 地址；
2. 用 `mtc0`/`mfc0` 自测 CP0 `Status` 通路（失败打印 `CP0 FAIL`）；
3. 打印：

   ```text
   step_into_mips lab8 interrupt
   IRQ READY
   ```

4. 初始化 timer（清 pending、使能 IRQ、`enable|irq_enable|auto_reload`）并 `mtc0 Status` 置 `IE=1`；
5. 进入 `idle` 循环；
6. 异常入口 `0x180` 的 handler：`mfc0` 读 `Cause`、检查并清 timer pending、LED 递增、打印 `tick\r\n`、`eret` 返回。

handler 仅使用 `$k0/$k1` 作为临时寄存器，不调用子程序，避免破坏被中断程序的 `$ra`；`EXL` 在 handler 期间屏蔽嵌套中断。生产级 handler 应将 UART 等慢操作移出中断上下文，这里为教学演示直接在 handler 内打印。

## How to use

生成 boot ROM：

```bash
python3 software/lab_8/gen_lab8_boot.py
```

运行仿真：

```bash
vivado -mode batch -source scripts/sim_lab8.tcl
```

构建 bitstream：

```bash
vivado -mode batch -source scripts/build_lab8.tcl
```

下载到 Nexys4 DDR：

```bash
vivado -mode batch -source scripts/program_lab8.tcl
```

串口参数：`115200 8N1`。Nexys4 DDR USB-UART 使用与 `lab_6/lab_7` 相同的已验证映射：FPGA `uart_rx_i` 接 C4，FPGA `uart_tx_o` 接 D4。

## 验收标准

仿真输出应包含：

```text
Simulation succeeded: lab_8 timer interrupt ticks verified
LAB8_SIM_DONE
```

上板后，PC 串口终端先看到：

```text
step_into_mips lab8 interrupt
IRQ READY
```

随后 timer 每约 1 秒触发一次中断，串口周期性打印：

```text
tick
```

每次 tick 同时递增 LED，作为中断活动指示。
