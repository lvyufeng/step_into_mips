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

## 第一版 monitor 命令

```text
h              help
r addr         read word
w addr data    write word
g addr         jump
```

## 验收标准

上板后，PC 串口终端看到：

```text
step_into_mips boot monitor
> 
```
