# Lab 7 C Runtime RTL

`lab_7` 在 `lab_6_uart_boot` 基础上扩展教学 MIPS 五级流水 CPU：

- 第一批 ISA：`lui/ori/andi/xori/bne/jal/jr/addu/subu/sll/srl`；
- 控制流 flush（`flushD`）与 `jal/jr` hazard 处理；
- 数据总线写接口升级为 `d_we/d_wstrb[3:0]/d_addr/d_wdata/d_rdata`，BRAM RAM 支持 byte lane 写。

详见 [`docs/lab_7_c_runtime.md`](../../docs/lab_7_c_runtime.md)。

引导程序由 `software/lab_7/gen_lab7_boot.py` 生成，写入本目录的 `lab_7_boot.mem`。
