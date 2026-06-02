# Lab 9: DDR2 外部内存

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

Lab 9 把 Nexys4 DDR 板载 128 MiB DDR2 接入前面实验形成的 MIPS SoC。完成后，CPU 不再只能访问片上 BRAM，而是可以在统一地址空间中读写 `0x8000_0000` 起始的外部 DDR2。

本实验采用两套后端：

- **仿真后端**：`ddr_model.v`，行为级 DDR-like model，带 calibration delay 和读写延迟，仿真速度快。
- **硬件后端**：Xilinx MIG 7-series，使用 Digilent Nexys4 DDR board file 中的 DDR2 `.prj` 配置生成真实 DDR2 控制器。

CPU 不直接面对 MIG。MIPS 数据访存接口先升级为 `d_valid/d_ready` wait-state 模型，再通过 `ddr_bridge`、CDC 和 AXI adapter 接入 MIG。

## 地址空间

```text
0x0000_0000 - 0x0000_0fff    boot ROM
0x0001_0000 - 0x0001_ffff    BRAM RAM
0x1000_0000 - 0x1000_00ff    GPIO/LED MMIO
0x1000_1000 - 0x1000_10ff    UART MMIO
0x1000_2000 - 0x1000_20ff    timer MMIO
0x1000_3000 - 0x1000_30ff    interrupt controller MMIO
0x1000_4000 - 0x1000_40ff    DDR status MMIO
0x8000_0000 - 0x87ff_ffff    DDR2, 128 MiB
```

DDR status MMIO 当前只读：

```text
bit 0: calib_done
bit 1: busy
```

boot ROM 会轮询 `0x1000_4000` bit0，等待 MIG calibration 完成后再做 DDR pattern test。

## CPU wait-state 接口

Lab 8 以前的 CPU/SoC 假设数据访存单周期完成。DDR2 和 MIG 不满足这个条件，因此 Lab 9 在 M stage 增加：

```verilog
output wire d_validM;
input  wire d_readyM;
```

- `lw/sw` 在 M stage 令 `d_validM=1`。
- local ROM/BRAM/MMIO 仍可单周期返回 `d_readyM=1`。
- DDR 区域访问会让 `d_readyM=0`，直到 `ddr_bridge` 收到后端 response。
- `d_validM && !d_readyM` 时，PC、D/E/M/W 数据寄存器和控制寄存器整体 hold。
- interrupt/eret entry 也会在 memory wait 期间被延后，避免旧访存事务还未完成就切换控制流。

这仍是教学友好的阻塞式模型：一次只允许一个 outstanding DDR transaction。

## DDR bridge 和后端

### 行为级仿真模型

`sim/lab_9_ddr_tb.v` 直接实例化 `soc` 和 `ddr_model`。`ddr_model` 提供：

- configurable calibration delay；
- configurable read/write latency；
- byte write strobe；
- `init_calib_complete` 和 `busy` 状态。

仿真不拉入 MIG/Micron DDR2 模型，因此可以快速验证 CPU wait-state、DDR 地址 decode 和 boot ROM pattern test。

### 真实 MIG 硬件路径

硬件 top 使用：

```text
simple_bus -> ddr_bridge -> ddr_backend_cdc -> mig_axi_adapter -> lab9_mig
```

关键点：

- `src/lab_9_ddr/mig/nexys4ddr_mig.prj` 来自 Digilent Nexys4 DDR C.1 board file，配置为：
  - part: `xc7a100t-csg324/-1`
  - memory: `MT47H64M16HR-25E`
  - data width: 16
  - size: 128 MiB
  - AXI port: 64-bit data, 27-bit address
- `clk_100_to_200.v` 用板载 100 MHz 产生 MIG 所需约 200 MHz `sys_clk_i`。
- CPU/本地 SoC 保持前面实验已验证的 50 MHz 时钟；MIG AXI 运行在 MIG `ui_clk` 域。
- `ddr_backend_cdc.v` 用单 outstanding toggle CDC 在 50 MHz bus 域和 MIG UI 域之间传递 request/response。
- `mig_axi_adapter.v` 把 32-bit CPU 读写映射成 64-bit AXI 单拍事务，按 `addr[2]` 选择低/高 32-bit lane。

## Boot ROM 测试

`software/lab_9/gen_lab9_boot.py` 生成 `src/lab_9_ddr/lab_9_boot.mem`。程序流程：

1. 初始化 UART/GPIO/DDR status/DDR base 地址寄存器。
2. 打印：
   ```text
   step_into_mips lab9 ddr
   ```
3. 轮询 DDR status bit0；等待期间周期性打印：
   ```text
   DDR WAIT
   ```
4. calibration done 后打印：
   ```text
   DDR CAL OK
   ```
5. 在 `0x8000_0000` 起始的多个 offset 写入并读回 pattern。
6. 成功时 LED=`0x005a`，并周期性打印：
   ```text
   DDR PASS
   ```
7. 失败时 LED=`0x00f0 + fail_code`，并周期性打印：
   ```text
   DDR FAIL <code>
   ```

周期性打印用于上板 bring-up：JTAG programming 可能导致 USB-UART 重新枚举，若只打印一次 banner，串口捕获容易错过早期输出。

## 使用方法

生成 boot ROM：

```bash
python3 software/lab_9/gen_lab9_boot.py
```

运行行为级仿真：

```bash
set +u; unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
vivado -mode batch -source scripts/sim_lab9.tcl
```

期望看到：

```text
Simulation succeeded: lab_9 DDR calibration and pattern test verified
LAB9_SIM_DONE
```

构建真实 MIG bitstream：

```bash
set +u; unset ZSH_VERSION
source /mnt/data1/Xilinx/2025.2/Vivado/settings64.sh
vivado -mode batch -source scripts/build_lab9.tcl
```

期望看到：

```text
LAB9_BITSTREAM=/.../build/lab9_top.bit
```

并且 routed timing summary 中：

```text
All user specified timing constraints are met.
```

下载到 Nexys4 DDR：

```bash
vivado -mode batch -source scripts/program_lab9.tcl
```

期望看到：

```text
LAB9_PROGRAMMED=xc7a100t_0 BITSTREAM=...
```

串口参数为 `115200 8N1`。硬件验收输出至少应包含持续出现的：

```text
DDR PASS
```

若从程序最开始捕获，也会看到：

```text
step_into_mips lab9 ddr
DDR CAL OK
DDR PASS
```

## 验收标准

- 行为级仿真通过 `LAB9_SIM_DONE`。
- true MIG bitstream 构建成功，timing met。
- JTAG program 成功，startup status HIGH。
- Nexys4 DDR 硬件 UART 输出 `DDR PASS`，LED 显示 `0x005a`。

## 限制和下一步

- DDR bridge 是单 outstanding 阻塞式事务，吞吐量不是目标；目标是教学上清晰地引入 wait-state 和真实 DDR。
- 当前 CPU 取指仍来自 boot ROM；DDR 作为数据内存接入。下一 lab 可把 loader/OS image 放入 DDR，并逐步支持从 DDR 运行更大的程序。
- MIG 生成产物不提交，只提交 `.prj` 输入、RTL adapter、Tcl 脚本和文档。
