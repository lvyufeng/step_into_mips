# Lab 8 Interrupt RTL

`lab_8` 在 `lab_7_c_runtime` 基础上为教学 MIPS 五级流水 CPU 加入中断/异常前置能力：

- 最小 CP0-like 寄存器（`Count/Compare/Status/Cause/EPC`）与 `mfc0/mtc0/eret`；
- timer 外设 `timer_mmio.v`（`0x1000_2000`）与中断控制器 `irq_controller.v`（`0x1000_3000`）；
- 固定异常入口 `0x0000_0180`；中断进入时保存 EPC、置 `Status.EXL`、flush 流水线，`eret` 时恢复 PC、清 EXL。

保留 `lab_7` 全部 ISA、控制流 flush 与 byte-strobe 数据总线。

详见 [`docs/lab_8_interrupt.md`](../../docs/lab_8_interrupt.md)。

引导程序由 `software/lab_8/gen_lab8_boot.py` 生成，写入本目录的 `lab_8_boot.mem`。
