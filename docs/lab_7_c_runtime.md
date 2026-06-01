# Lab 7: 扩展 ISA 与 C Runtime

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

扩展当前教学 MIPS 指令集和内存接口，使 CPU 能运行受限 C 程序。

## 优先补充指令

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

## 内存接口升级

从单 bit 写使能：

```verilog
memwrite
```

升级为：

```verilog
d_we
d_wstrb[3:0]
d_addr[31:0]
d_wdata[31:0]
d_rdata[31:0]
```

## 验收标准

能运行简单 C-like UART echo 程序。
