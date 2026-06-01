# Lab 5: SoC 总线与统一地址空间

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

把 `lab_4` 的五级流水 MIPS CPU 从“直接连接 inst_mem/data_mem”升级为一个最小 SoC：

```text
MIPS CPU + simple bus + boot ROM + BRAM RAM + GPIO/MMIO
```

## 第一版地址空间

```text
0x0000_0000 - 0x0000_3fff    boot ROM, 16 KiB
0x0001_0000 - 0x0001_ffff    BRAM RAM, 64 KiB
0x1000_0000 - 0x1000_00ff    GPIO / LED
0x1000_0100 - 0x1000_01ff    debug registers
```

## 验收标准

- 仿真：CPU 从 boot ROM 取指，并向 GPIO 地址写入可检测值。
- 上板：Nexys4 DDR LED 由 MIPS 程序控制闪烁或递增。
