# Lab 9: DDR2 外部内存

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

接入 Nexys4 DDR 板上 DDR2，让系统拥有远大于 BRAM 的内存空间。

## 地址空间

```text
0x0000_0000 - 0x0000_3fff    boot ROM
0x0001_0000 - 0x0001_ffff    BRAM RAM
0x1000_0000 - 0x1000_ffff    MMIO
0x8000_0000 - 0x87ff_ffff    DDR2, 128 MiB
```

## 设计建议

不要让 MIPS core 直接面对 MIG；应通过 `ddr_bridge` 隔离 DDR 控制器细节。

## 验收标准

Boot ROM 启动后检测 DDR calibration done，写入/读回 pattern，并通过串口打印 pass/fail。
