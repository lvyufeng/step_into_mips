# step_into_mips 后续实验路线：从教学 MIPS CPU 到可交互 SoC

本文档记录 2026-06-01 讨论确定的后续计划，目标是把当前 `step_into_mips` 从“基本 MIPS 指令/五级流水实验”逐步补全为 Nexys4 DDR 上可运行的教学 SoC，并为 bootloader、小型 monitor、RTOS/教学 OS 打基础。

## 0. 总体目标

当前仓库的主线是：

```text
lab_1  ALU 设计、存储器 IP 使用
lab_2  简单取指译码模块
lab_3  单周期 MIPS CPU
lab_4  简单五级流水线 MIPS CPU
```

后续继续保持这个教学梯度，不直接跳到 Linux，而是逐步加入 SoC 必需能力：

```text
lab_5  SoC 化：总线、统一地址空间、BRAM、GPIO/MMIO
lab_6  UART 与 boot monitor：串口交互和程序加载雏形
lab_7  C runtime 与 ISA 扩展：让 CPU 能跑受限 C 程序
lab_8  中断、异常、Timer：小型 OS 前置能力
lab_9  DDR2 外部内存：接入 Nexys4 DDR 板上内存
lab_10 Tiny OS / RTOS：教学 OS 综合实验
```

推荐近期目标先完成到 `lab_6`：

```text
MIPS 五级流水 CPU
  + 修复 lab_4 集成问题
  + 可复现 Verilog BRAM ROM/RAM
  + simple bus
  + GPIO LED
  + UART MMIO
  + boot monitor
  + Vivado batch build/program
  + Nexys4 DDR 上板验证
```

完成 `lab_6` 后，系统应当能在串口中显示：

```text
step_into_mips monitor
> help
> r 00010000
> w 00010000 12345678
> g 00010000
```

---

## 1. Lab 4 修复与现代化

严格说，新增实验之前应先让 `lab_4` 在当前 Vivado 2025.2 命令行环境下稳定仿真、综合、上板。

### 1.1 目标

- 修复五级流水 CPU 集成问题。
- 保留原有小指令集测试程序。
- 用可复现 Verilog memory 替代或旁路旧 Vivado Block Memory Generator `.xci` 依赖。
- 增加 batch 仿真/构建脚本。

### 1.2 已知问题

#### ALU 端口数量不匹配

`src/lab_4/datapath.v` 中 ALU 实例只连接 4 个端口，但 `alu.v` 模块声明包含 `overflow` 和 `zero`：

```verilog
alu alu(srca2E, srcb3E, alucontrolE, aluoutE);
```

应改成命名端口或补齐 unused wire。

#### `equalD` 方向错误/混乱

`equalD` 是 datapath 中比较器产生的结果，应作为 controller 输入，用来生成 `pcsrcD`。当前 controller 中将其声明为 output，需要修正接口方向。

#### 旧 Xilinx IP 依赖

当前 `inst_mem` / `data_mem` 主要依赖旧 `.xci`：

```text
src/lab_4/ip/inst_mem/inst_mem.xci
src/lab_4/ip/data_mem/data_mem.xci
```

后续建议加入普通 Verilog memory wrapper，支持 `$readmemh`，便于仿真和 batch 构建。

### 1.3 验收标准

- `lab_4` testbench 仍能检测到：写地址 `84`、写数据 `7`，输出 `Simulation succeeded`。
- Vivado/XSim batch 仿真通过。
- 如需要，上板程序可通过 LED 或 debug 输出确认运行。

---

## 2. Lab 5：SoC 总线与统一地址空间

### 2.1 教学目标

从：

```text
CPU + inst_mem ROM + data_mem RAM
```

过渡到：

```text
CPU + simple bus + boot ROM + BRAM RAM + MMIO GPIO
```

学生需要理解：

- CPU 通过地址访问不同设备。
- ROM/RAM/MMIO 都是统一地址空间中的一段。
- 外设寄存器与普通内存访问在硬件上如何区分。

### 2.2 建议系统结构

```text
                 +----------------+
                 |  MIPS Pipeline |
                 |                |
                 |  instr addr    |
                 |  data addr     |
                 +---+--------+---+
                     |        |
              +------+        +------+
              |                    |
        instruction bus       data bus
              |                    |
              +---------+----------+
                        |
                 +------v------+
                 |  SoC Bus    |
                 +------+------+ 
                        |
       +----------------+----------------+
       |                |                |
+------v------+  +------v------+  +------v------+
| Boot ROM    |  | BRAM RAM    |  | MMIO GPIO   |
| 0x00000000  |  | 0x00010000  |  | 0x10000000  |
+-------------+  +-------------+  +-------------+
```

### 2.3 第一版地址空间

```text
0x0000_0000 - 0x0000_3fff    boot ROM, 16 KiB
0x0001_0000 - 0x0001_ffff    BRAM RAM, 64 KiB
0x1000_0000 - 0x1000_00ff    GPIO / LED
0x1000_0100 - 0x1000_01ff    debug registers
```

### 2.4 CPU 外部接口

`lab_5` 初期可以继续兼容当前 `lab_4` 的简单数据接口：

```verilog
output wire        memwriteM,
output wire [31:0] aluoutM,
output wire [31:0] writedataM,
input  wire [31:0] readdataM
```

外部加 bus decoder：

```verilog
simple_bus bus(
    .clk(clk),
    .rst(rst),

    .i_addr(pc),
    .i_rdata(instr),

    .d_we(memwrite),
    .d_addr(dataadr),
    .d_wdata(writedata),
    .d_rdata(readdata),

    .gpio_led(led)
);
```

后续 `lab_7` 再升级为支持 byte-enable 和 wait-state 的接口。

### 2.5 目录建议

```text
src/lab_5_soc/
  top.v
  soc.v
  simple_bus.v
  boot_rom.v
  bram_ram.v
  gpio_mmio.v
  mips_core/
```

### 2.6 验收标准

仿真：

```text
CPU 从 boot ROM 取指；
向 GPIO 地址 0x10000000 写入数据；
testbench 检测写入值。
```

上板：

```text
boot ROM 程序通过 GPIO/MMIO 控制 Nexys4 DDR LED 闪烁或递增。
```

---

## 3. Lab 6：UART 与 Boot Monitor

### 3.1 教学目标

让 CPU 能通过串口和 PC 通信，进入“可交互系统”。

### 3.2 系统结构

```text
MIPS CPU
  + Boot ROM
  + BRAM RAM
  + GPIO
  + UART
```

### 3.3 地址空间扩展

```text
0x0000_0000 - 0x0000_3fff    boot ROM
0x0001_0000 - 0x0001_ffff    BRAM RAM
0x1000_0000 - 0x1000_00ff    GPIO
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

### 3.4 UART 模块

新增：

```text
src/common/uart_tx.v
src/common/uart_rx.v
src/lab_6_uart_boot/uart_mmio.v
```

参数：

```text
clk  = 100 MHz
baud = 115200
```

### 3.5 Boot monitor 第一版

初版 monitor 可用汇编实现，先不依赖 C 编译器。

功能：

```text
h              help
r addr         read word
w addr data    write word
g addr         jump
```

后续再加：

```text
load addr len  通过串口加载 hex/bin 程序
```

### 3.6 软件目录

```text
software/lab_6/
  boot.S
  uart.S
  monitor.S
  linker.ld
```

### 3.7 验收标准

上板后在 PC 端串口看到：

```text
step_into_mips boot monitor
> 
```

串口命令示例：

```text
> w 00010000 12345678
OK
> r 00010000
12345678
```

---

## 4. Lab 7：扩展 ISA 与 C Runtime

### 4.1 教学目标

让 CPU 不再只能跑极小手写汇编，而是能跑受限 C 程序。

### 4.2 当前指令集

当前只支持：

```text
add/sub/and/or/slt
lw/sw/beq/addi/j
```

### 4.3 必须补的指令

第一批：

```text
lui
ori
bne
jr
jal
addu
subu
sll
srl
```

第二批：

```text
andi
xori
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

这些指令支持后，简单 C runtime 和 UART driver 才比较自然。

### 4.4 数据通路变化

需要增加：

- shamt 输入 ALU。
- zero/sign extension。
- byte lane select。
- byte enable。
- load data align。
- store data mask。
- `$31` link register 写入 `PC+8` 或 `PC+4`。
- `jr/jalr` 寄存器跳转。

### 4.5 内存接口升级

当前接口只有 1 bit 写使能：

```verilog
output wire memwriteM
```

`lab_7` 起建议改成：

```verilog
output wire        d_we;
output wire [3:0]  d_wstrb;
output wire [31:0] d_addr;
output wire [31:0] d_wdata;
input  wire [31:0] d_rdata;
```

这样支持：

```text
sb/sh/sw
lb/lh/lw
```

### 4.6 软件工具链

新增：

```text
tools/bin2mem.py
tools/mem2coe.py
tools/serial_loader.py
software/common/start.S
software/common/linker.ld
```

第一阶段可以先用汇编生成 `.mem`，之后再引入：

```bash
mipsel-linux-gnu-gcc -nostdlib -nostartfiles
```

或 clang/LLVM MIPS target。

### 4.7 验收标准

可以运行简单 C-like 程序：

```c
int main() {
    puts("hello mips\n");
    while (1) {
        int c = getchar();
        putchar(c);
    }
}
```

串口 echo 成功。

---

## 5. Lab 8：中断、异常和 Timer

### 5.1 教学目标

进入 OS 前置能力：

```text
timer interrupt
exception entry
context save/restore
eret
```

### 5.2 新增硬件

```text
timer_mmio.v
irq_controller.v
cp0.v
exception_controller.v
```

### 5.3 地址空间扩展

```text
0x1000_2000 - 0x1000_20ff    timer
0x1000_3000 - 0x1000_30ff    interrupt controller
```

Timer 寄存器：

```text
0x1000_2000 TIMER_COUNTER
0x1000_2004 TIMER_COMPARE
0x1000_2008 TIMER_CONTROL
0x1000_200c TIMER_STATUS
```

### 5.4 最小 CP0 集合

```text
Status
Cause
EPC
Count
Compare
```

新增指令：

```text
mfc0
mtc0
eret
```

### 5.5 异常入口

```text
reset vector:     0x0000_0000
exception vector: 0x0000_0180
```

### 5.6 Pipeline 要处理

异常/中断发生时：

```text
flush pipeline
保存 EPC
跳转 exception vector
eret 恢复 PC
```

### 5.7 验收标准

裸机程序：

```text
每 1 秒 timer interrupt
LED 递增
串口打印 tick
```

---

## 6. Lab 9：DDR2 外部内存

### 6.1 目标

接入 Nexys4 DDR 板上 DDR2，让系统不再受 BRAM 限制。

### 6.2 地址空间扩展

```text
0x0000_0000 - 0x0000_3fff    boot ROM
0x0001_0000 - 0x0001_ffff    BRAM RAM
0x1000_0000 - 0x1000_ffff    MMIO
0x8000_0000 - 0x87ff_ffff    DDR2, 128 MiB
```

### 6.3 推荐结构

不要让 MIPS core 直接面对 MIG。中间加一层：

```text
CPU bus
  +-- local ROM/RAM/MMIO
  +-- ddr_bridge
        +-- MIG/AXI/native DDR2
```

### 6.4 难点

必须引入：

```text
ready/valid
wait-state
pipeline stall
clock domain handling
DDR calibration
```

所以在进入 `lab_9` 之前，CPU memory interface 应升级为：

```verilog
d_valid
d_ready
d_we
d_wstrb
d_addr
d_wdata
d_rdata
```

### 6.5 验收标准

Boot ROM 启动后：

```text
检测 DDR calibration done
向 DDR 写 pattern
从 DDR 读回校验
串口打印 pass/fail
```

---

## 7. Lab 10：Tiny OS / RTOS

### 7.1 定位

不建议第一阶段直接叫 Linux。更合理的是：

```text
StepOS
TinyMIPS OS
```

### 7.2 最小 OS 功能

```text
boot
UART console
timer tick
two tasks round-robin
syscall putchar/getchar
simple shell
```

### 7.3 Shell 示例

```text
step-os> help
step-os> ps
step-os> mem
step-os> led 1
step-os> run demo
```

### 7.4 Linux 放到 appendix

Linux 需要：

```text
MMU/TLB
MIPS32 CP0 完整兼容
cache/uncached segment
device tree 或平台代码
复杂异常处理
完整 toolchain ABI
```

这已经超出主线教学 CPU 补完范围。建议作为远期 appendix，而不是 main lab。

---

## 8. 推荐目录结构

```text
step_into_mips/
  src/
    common/
      bram_sp.v
      bram_dp.v
      uart_tx.v
      uart_rx.v
      sync_reset.v

    lab_5_soc/
      top.v
      soc.v
      simple_bus.v
      boot_rom.v
      bram_ram.v
      gpio_mmio.v
      mips_core/

    lab_6_uart_boot/
      top.v
      soc.v
      simple_bus.v
      uart_mmio.v
      boot_rom.v
      bram_ram.v
      mips_core/

    lab_7_c_runtime/
      top.v
      soc.v
      bus/
      peripherals/
      mips_core/

    lab_8_interrupt/
      top.v
      soc.v
      cp0.v
      timer_mmio.v
      irq_controller.v
      exception_controller.v
      mips_core/

    lab_9_ddr/
      top.v
      soc.v
      ddr_bridge.v
      mig/

    lab_10_tiny_os/
      top.v
      soc.v

  sim/
    lab_5_soc_tb.v
    lab_6_uart_boot_tb.v
    lab_7_c_runtime_tb.v
    lab_8_interrupt_tb.v

  software/
    common/
      start.S
      linker.ld
      uart.S
      crt0.S

    lab_5/
      led_test.S

    lab_6/
      boot.S
      uart.S
      monitor.S
      linker.ld

    lab_7/
      hello_c/
      echo/
      loader_test/

    lab_8/
      timer_irq/
      context_switch/

    tiny_os/
      kernel/
      user/
      shell/

  tools/
    bin2mem.py
    mem2coe.py
    serial_loader.py

  constr/
    nexys4ddr_lab5.xdc
    nexys4ddr_lab6.xdc
    nexys4ddr_lab7.xdc

  scripts/
    build_lab4.tcl
    sim_lab4.tcl
    build_lab5.tcl
    build_lab6.tcl
    program.tcl

  docs/
    lab_5_to_lab_10_roadmap.md
    lab_5_soc.md
    lab_6_uart_boot.md
    lab_7_c_runtime.md
    lab_8_interrupt.md
    lab_9_ddr.md
    lab_10_tiny_os.md
```

---

## 9. 第一阶段执行顺序

### Step 1：修复 lab_4

- 修 ALU 端口。
- 修 `equalD` 方向。
- 加 Verilog ROM/RAM wrapper。
- 加 batch 仿真脚本。
- 保证原始 lab_4 程序仿真通过。

### Step 2：创建 `lab_5_soc`

- simple bus。
- boot ROM。
- BRAM RAM。
- GPIO LED。
- Nexys4 DDR XDC。
- Vivado batch build/program。

### Step 3：创建 `lab_6_uart_boot`

- UART TX/RX。
- UART MMIO。
- 汇编 boot monitor。
- 串口输出 banner。

---

## 10. 与 RISC-V 的关系

主线仍保持 MIPS，因为仓库定位是 `step_into_mips`。

RISC-V 可作为 appendix：

```text
appendix_riscv/
  picorv32_soc/
  litex_nexys4ddr/
```

如果未来目标转为“更快跑 bootloader/DDR/OS”，推荐 LiteX + VexRiscv；如果目标是补完教学 CPU，则继续 MIPS 主线。
