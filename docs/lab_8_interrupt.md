# Lab 8: 中断、异常和 Timer

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

加入 timer interrupt、异常入口、CP0-like 控制寄存器和 `eret`，为小型 OS 做准备。

## 最小 CP0 集合

```text
Status
Cause
EPC
Count
Compare
```

## 地址空间

```text
0x1000_2000 - 0x1000_20ff    timer
0x1000_3000 - 0x1000_30ff    interrupt controller
```

## 异常入口

```text
reset vector:     0x0000_0000
exception vector: 0x0000_0180
```

## 验收标准

Timer 每秒触发一次中断，LED 递增，串口打印 tick。
