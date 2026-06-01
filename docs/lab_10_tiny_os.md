# Lab 10: Tiny OS / RTOS

详细总路线见 [`lab_5_to_lab_10_roadmap.md`](lab_5_to_lab_10_roadmap.md)。

## 目标

在前面实验提供的 UART、timer interrupt、异常/中断、C runtime 基础上，实现一个教学型 Tiny OS。

## 最小功能

```text
boot
UART console
timer tick
two tasks round-robin
syscall putchar/getchar
simple shell
```

## Shell 示例

```text
step-os> help
step-os> ps
step-os> mem
step-os> led 1
step-os> run demo
```

## Linux 定位

Linux 需要 MMU/TLB、完整 MIPS32 CP0、cache/uncached segment、复杂异常处理和完整 ABI。它不作为主线 lab 目标，而作为远期 appendix。主线目标是 TinyMIPS OS / StepOS。
