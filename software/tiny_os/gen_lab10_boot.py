#!/usr/bin/env python3
"""Generate the lab_10 StepOS boot ROM image.

StepOS is a tiny teaching RTOS baseline for the final lab.  The generated MIPS
program initializes UART/GPIO/timer/IRQ/DDR status, runs a small DDR test,
starts a two-task round-robin scheduler, and exposes a simple UART shell.
"""
from pathlib import Path

OP = {
    "addi": 0x08,
    "andi": 0x0C,
    "ori": 0x0D,
    "xori": 0x0E,
    "lui": 0x0F,
    "lw": 0x23,
    "sw": 0x2B,
    "beq": 0x04,
    "bne": 0x05,
    "j": 0x02,
    "jal": 0x03,
}

FUNCT = {
    "sll": 0x00,
    "srl": 0x02,
    "jr": 0x08,
    "add": 0x20,
    "addu": 0x21,
    "sub": 0x22,
    "subu": 0x23,
    "and": 0x24,
    "or": 0x25,
    "xor": 0x26,
    "slt": 0x2A,
}

REG = {f"${i}": i for i in range(32)}
REG.update(
    {
        "$zero": 0,
        "$at": 1,
        "$v0": 2,
        "$v1": 3,
        "$a0": 4,
        "$a1": 5,
        "$a2": 6,
        "$a3": 7,
        "$t0": 8,
        "$t1": 9,
        "$t2": 10,
        "$t3": 11,
        "$t4": 12,
        "$t5": 13,
        "$t6": 14,
        "$t7": 15,
        "$s0": 16,
        "$s1": 17,
        "$s2": 18,
        "$s3": 19,
        "$s4": 20,
        "$s5": 21,
        "$s6": 22,
        "$s7": 23,
        "$t8": 24,
        "$t9": 25,
        "$k0": 26,
        "$k1": 27,
        "$gp": 28,
        "$sp": 29,
        "$fp": 30,
        "$ra": 31,
    }
)

CP0 = {
    "Count": 9,
    "Compare": 11,
    "Status": 12,
    "Cause": 13,
    "EPC": 14,
}

GPIO_BASE = 0x10000000
UART_BASE = 0x10001000
TIMER_BASE = 0x10002000
IRQ_BASE = 0x10003000
DDR_STATUS_BASE = 0x10004000
DDR_BASE = 0x80000000
BRAM_BASE = 0x00010000

UART_TXDATA = 0x0
UART_RXDATA = 0x4
UART_STATUS = 0x8
TIMER_COUNTER = 0x0
TIMER_CONTROL = 0x8
TIMER_STATUS = 0xC
IRQ_ENABLE = 0x4

EXCEPTION_VECTOR = 0x180
BOOT_WORDS = 4096

TCB0 = BRAM_BASE + 0x000
TCB1 = BRAM_BASE + 0x100
GLOBALS = BRAM_BASE + 0x200
CURRENT_TASK = GLOBALS + 0x00
TICK_COUNT = GLOBALS + 0x04
DEMO_ENABLED = GLOBALS + 0x08
DEMO_COUNTER = GLOBALS + 0x0C

SHELL_STACK_TOP = BRAM_BASE + 0x0C00
DEMO_STACK_TOP = BRAM_BASE + 0x0F00

TCB_EPC = 0x00
TCB_RUNS = 0x04
TCB_STATE = 0x08
TCB_REG_BASE = 0x10

OS_PUTCHAR = 1
OS_GETCHAR = 2
OS_YIELD = 3
OS_LED = 4
OS_PS = 5
OS_MEM = 6

prog = []
labels = {}
fixups = []
listing = []


def enc_i(op, rs, rt, imm):
    return (OP[op] << 26) | (REG[rs] << 21) | (REG[rt] << 16) | (imm & 0xFFFF)


def enc_r(funct, rs, rt, rd, shamt=0):
    return (REG[rs] << 21) | (REG[rt] << 16) | (REG[rd] << 11) | ((shamt & 0x1F) << 6) | FUNCT[funct]


def enc_j(op, addr):
    return (OP[op] << 26) | ((addr >> 2) & 0x03FF_FFFF)


def enc_mfc0(rt, rd):
    rd_num = CP0.get(rd, rd) if isinstance(rd, str) else rd
    return (0x10 << 26) | (0x00 << 21) | (REG[rt] << 16) | ((rd_num & 0x1F) << 11)


def enc_mtc0(rt, rd):
    rd_num = CP0.get(rd, rd) if isinstance(rd, str) else rd
    return (0x10 << 26) | (0x04 << 21) | (REG[rt] << 16) | ((rd_num & 0x1F) << 11)


def enc_eret():
    return (0x10 << 26) | (0x10 << 21) | 0x18


def pc():
    return len(prog) * 4


def label(name):
    labels[name] = pc()
    listing.append((None, None, f"{name}:"))


def emit(word, asm):
    listing.append((pc(), word, asm))
    prog.append(word)


def addi(rt, rs, imm): emit(enc_i("addi", rs, rt, imm), f"addi {rt},{rs},{imm}")
def andi(rt, rs, imm): emit(enc_i("andi", rs, rt, imm), f"andi {rt},{rs},0x{imm & 0xffff:04x}")
def ori(rt, rs, imm): emit(enc_i("ori", rs, rt, imm), f"ori {rt},{rs},0x{imm & 0xffff:04x}")
def xori(rt, rs, imm): emit(enc_i("xori", rs, rt, imm), f"xori {rt},{rs},0x{imm & 0xffff:04x}")
def lui(rt, imm): emit(enc_i("lui", "$zero", rt, imm), f"lui {rt},0x{imm & 0xffff:04x}")
def lw(rt, off, rs): emit(enc_i("lw", rs, rt, off), f"lw {rt},{off}({rs})")
def sw(rt, off, rs): emit(enc_i("sw", rs, rt, off), f"sw {rt},{off}({rs})")
def rr(funct, rd, rs, rt): emit(enc_r(funct, rs, rt, rd), f"{funct} {rd},{rs},{rt}")
def jr(rs): emit(enc_r("jr", rs, "$zero", "$zero"), f"jr {rs}")
def nop(): emit(0, "nop")
def mfc0(rt, rd): emit(enc_mfc0(rt, rd), f"mfc0 {rt},{rd}")
def mtc0(rt, rd): emit(enc_mtc0(rt, rd), f"mtc0 {rt},{rd}")
def eret(): emit(enc_eret(), "eret")


def branch(op, rs, rt, target):
    fixups.append((len(prog), op, target, rs, rt))
    emit(0, f"{op} {rs},{rt},{target}")


def beq(rs, rt, target): branch("beq", rs, rt, target)
def bne(rs, rt, target): branch("bne", rs, rt, target)


def jump(target):
    fixups.append((len(prog), "j", target, None, None))
    emit(0, f"j {target}")


def jal(target):
    fixups.append((len(prog), "jal", target, None, None))
    emit(0, f"jal {target}")


def load_addr(rt, addr):
    lui(rt, (addr >> 16) & 0xFFFF)
    if addr & 0xFFFF:
        ori(rt, rt, addr & 0xFFFF)


def load_imm(rt, value):
    lui(rt, (value >> 16) & 0xFFFF)
    ori(rt, rt, value & 0xFFFF)


def load_label(rt, target):
    fixups.append((len(prog), "lui_label_hi", target, None, rt))
    emit(0, f"lui {rt},%hi({target})")
    fixups.append((len(prog), "ori_label_lo", target, rt, rt))
    emit(0, f"ori {rt},{rt},%lo({target})")


def call(name):
    jal(name)
    nop()


def ret():
    jr("$ra")
    nop()


def enter():
    # Standard non-leaf prologue: push $ra so nested calls can clobber it.
    addi("$sp", "$sp", -4)
    sw("$ra", 0, "$sp")


def leave():
    # Matching epilogue: pop $ra and return.
    lw("$ra", 0, "$sp")
    addi("$sp", "$sp", 4)
    jr("$ra")
    nop()


def cp0_gap():
    # This core has no CP0 hazard unit.  Let mtc0 commit before eret/mfc0 use.
    nop()
    nop()
    nop()


def reg_off(reg_num):
    return TCB_REG_BASE + reg_num * 4


def emit_puts(label_name, text):
    label(label_name)
    enter()
    for ch in text:
        addi("$a0", "$zero", ord(ch))
        call("putc")
    leave()


# ---------------------------------------------------------------------------
# Reset vector and exception vector.
# ---------------------------------------------------------------------------
label("reset")
jump("boot_main")
nop()

if len(prog) > EXCEPTION_VECTOR // 4:
    raise SystemExit(f"reset section too large for exception vector: {len(prog)} words")
while len(prog) < EXCEPTION_VECTOR // 4:
    if len(prog) + 2 <= EXCEPTION_VECTOR // 4:
        jump("boot_main")
        nop()
    else:
        nop()

label("exception_vector")
if pc() != EXCEPTION_VECTOR:
    raise SystemExit(f"exception vector misplaced at 0x{pc():08x}")

# Save temporary kernel registers without relying on a dedicated interrupt stack.
sw("$k0", -4, "$sp")
sw("$k1", -8, "$sp")

# Only timer IRQs exist in this lab.  Unknown exceptions just return.
load_addr("$k0", TIMER_BASE)
lw("$k1", TIMER_STATUS, "$k0")
andi("$k1", "$k1", 1)
beq("$k1", "$zero", "exception_done")
nop()
addi("$k1", "$zero", 1)
sw("$k1", TIMER_STATUS, "$k0")

# Global tick++.
load_addr("$k0", TICK_COUNT)
lw("$k1", 0, "$k0")
addi("$k1", "$k1", 1)
sw("$k1", 0, "$k0")

# Select current TCB base.
load_addr("$k0", CURRENT_TASK)
lw("$k1", 0, "$k0")
beq("$k1", "$zero", "save_tcb0")
nop()
load_addr("$k0", TCB1)
jump("save_tcb_ready")
nop()
label("save_tcb0")
load_addr("$k0", TCB0)
label("save_tcb_ready")

mfc0("$k1", "EPC")
sw("$k1", TCB_EPC, "$k0")
for reg in list(range(1, 26)) + [28, 29, 30, 31]:
    sw(f"${reg}", reg_off(reg), "$k0")
lw("$k1", -4, "$sp")
sw("$k1", reg_off(26), "$k0")
lw("$k1", -8, "$sp")
sw("$k1", reg_off(27), "$k0")

# current_task ^= 1.
load_addr("$k0", CURRENT_TASK)
lw("$k1", 0, "$k0")
xori("$k1", "$k1", 1)
sw("$k1", 0, "$k0")
beq("$k1", "$zero", "restore_tcb0")
nop()
load_addr("$k0", TCB1)
jump("restore_tcb_ready")
nop()
label("restore_tcb0")
load_addr("$k0", TCB0)
label("restore_tcb_ready")

# next->runs++ and EPC = next->epc.
lw("$k1", TCB_RUNS, "$k0")
addi("$k1", "$k1", 1)
sw("$k1", TCB_RUNS, "$k0")
lw("$k1", TCB_EPC, "$k0")
mtc0("$k1", "EPC")
cp0_gap()

# Restore all GPRs.  Restore k1/k0 last because k0 is the TCB base.
for reg in list(range(1, 26)) + [28, 29, 30, 31]:
    lw(f"${reg}", reg_off(reg), "$k0")
lw("$k1", reg_off(27), "$k0")
lw("$k0", reg_off(26), "$k0")
eret()
nop()

label("exception_done")
lw("$k0", -4, "$sp")
lw("$k1", -8, "$sp")
eret()
nop()

# ---------------------------------------------------------------------------
# Kernel routines.
# ---------------------------------------------------------------------------
label("putc")
lw("$t0", UART_STATUS, "$s0")
andi("$t0", "$t0", 1)
beq("$t0", "$zero", "putc")
nop()
sw("$a0", UART_TXDATA, "$s0")
ret()

label("getc_block")
lw("$v0", UART_STATUS, "$s0")
andi("$v0", "$v0", 2)
beq("$v0", "$zero", "getc_block")
nop()
lw("$v0", UART_RXDATA, "$s0")
andi("$v0", "$v0", 0xFF)
ret()

label("drain_line")
enter()
label("drain_loop")
call("getc_block")
addi("$t0", "$zero", 13)
beq("$v0", "$t0", "drain_done")
nop()
addi("$t0", "$zero", 10)
bne("$v0", "$t0", "drain_loop")
nop()
label("drain_done")
leave()

label("mem_test")
enter()
lw("$t0", 0, "$s4")
andi("$t0", "$t0", 1)
bne("$t0", "$zero", "mem_calibrated")
nop()
call("print_ddr_wait")
leave()
label("mem_calibrated")
call("print_ddr_cal_ok")
load_imm("$t0", 0x13572468)
sw("$t0", 0x20, "$s5")
lw("$t1", 0x20, "$s5")
bne("$t0", "$t1", "fail_d")
nop()
load_imm("$t0", 0x2468ACE0)
sw("$t0", 0x24, "$s5")
lw("$t1", 0x24, "$s5")
bne("$t0", "$t1", "fail_d")
nop()
call("print_ddr_test_ok")
leave()

label("os_call")
addi("$t0", "$zero", OS_PUTCHAR)
beq("$v0", "$t0", "os_call_putchar")
nop()
addi("$t0", "$zero", OS_GETCHAR)
beq("$v0", "$t0", "os_call_getchar")
nop()
addi("$t0", "$zero", OS_YIELD)
beq("$v0", "$t0", "os_call_yield")
nop()
addi("$t0", "$zero", OS_LED)
beq("$v0", "$t0", "os_call_led")
nop()
addi("$t0", "$zero", OS_PS)
beq("$v0", "$t0", "os_call_ps")
nop()
addi("$t0", "$zero", OS_MEM)
beq("$v0", "$t0", "os_call_mem")
nop()
ret()

label("os_call_putchar")
enter()
call("putc")
leave()

label("os_call_getchar")
enter()
call("getc_block")
leave()

label("os_call_yield")
ret()

label("os_call_led")
sw("$a0", 0, "$s1")
ret()

label("os_call_ps")
enter()
call("print_ps")
leave()

label("os_call_mem")
enter()
call("mem_test")
leave()

# ---------------------------------------------------------------------------
# Shell and demo tasks.
# ---------------------------------------------------------------------------
label("shell_task")
call("print_prompt")
call("getc_block")
addi("$t0", "$zero", 13)
beq("$v0", "$t0", "shell_task")
nop()
addi("$t0", "$zero", 10)
beq("$v0", "$t0", "shell_task")
nop()
addi("$t0", "$zero", ord("h"))
beq("$v0", "$t0", "cmd_help")
nop()
addi("$t0", "$zero", ord("p"))
beq("$v0", "$t0", "cmd_ps")
nop()
addi("$t0", "$zero", ord("m"))
beq("$v0", "$t0", "cmd_mem")
nop()
addi("$t0", "$zero", ord("l"))
beq("$v0", "$t0", "cmd_led")
nop()
addi("$t0", "$zero", ord("r"))
beq("$v0", "$t0", "cmd_run")
nop()
jump("cmd_unknown")
nop()

label("cmd_help")
call("drain_line")
call("print_help")
jump("shell_task")
nop()

label("cmd_ps")
call("drain_line")
addi("$v0", "$zero", OS_PS)
call("os_call")
jump("shell_task")
nop()

label("cmd_mem")
call("drain_line")
addi("$v0", "$zero", OS_MEM)
call("os_call")
jump("shell_task")
nop()

label("cmd_led")
call("drain_line")
addi("$v0", "$zero", OS_LED)
addi("$a0", "$zero", 1)
call("os_call")
call("print_ok")
jump("shell_task")
nop()

label("cmd_run")
call("drain_line")
load_addr("$t0", DEMO_ENABLED)
addi("$t1", "$zero", 1)
sw("$t1", 0, "$t0")
call("print_demo_started")
jump("shell_task")
nop()

label("cmd_unknown")
call("drain_line")
call("print_unknown")
jump("shell_task")
nop()

label("demo_task")
load_addr("$t0", DEMO_ENABLED)
lw("$t1", 0, "$t0")
beq("$t1", "$zero", "demo_idle")
nop()
load_addr("$t0", DEMO_COUNTER)
lw("$t1", 0, "$t0")
addi("$t1", "$t1", 1)
sw("$t1", 0, "$t0")
label("demo_idle")
addi("$v0", "$zero", OS_YIELD)
call("os_call")
jump("demo_task")
nop()

# ---------------------------------------------------------------------------
# Boot main runs after the exception vector and routines.
# ---------------------------------------------------------------------------
label("boot_main")
load_addr("$s0", UART_BASE)
load_addr("$s1", GPIO_BASE)
load_addr("$s2", TIMER_BASE)
load_addr("$s3", IRQ_BASE)
load_addr("$s4", DDR_STATUS_BASE)
load_addr("$s5", DDR_BASE)
load_addr("$sp", SHELL_STACK_TOP)
addi("$t0", "$zero", 0)
mtc0("$t0", "Status")
cp0_gap()
sw("$zero", 0, "$s1")
call("print_banner")

label("wait_ddr_cal")
lw("$t0", 0, "$s4")
andi("$t0", "$t0", 1)
bne("$t0", "$zero", "boot_ddr_ready")
nop()
jump("wait_ddr_cal")
nop()
label("boot_ddr_ready")
call("mem_test")

# Clear TCB/global BRAM area.
load_addr("$t0", TCB0)
addi("$t1", "$zero", 192)
label("zero_os_state")
sw("$zero", 0, "$t0")
addi("$t0", "$t0", 4)
addi("$t1", "$t1", -1)
bne("$t1", "$zero", "zero_os_state")
nop()

# Initialize task metadata.  Task 0 starts as the running shell; task 1 is the
# demo task restored for the first time by the timer interrupt.
load_addr("$t0", TCB0)
addi("$t1", "$zero", 1)
sw("$t1", TCB_STATE, "$t0")
load_addr("$t0", TCB1)
sw("$t1", TCB_STATE, "$t0")
load_label("$t1", "demo_task")
sw("$t1", TCB_EPC, "$t0")
load_addr("$t1", DEMO_STACK_TOP)
sw("$t1", reg_off(29), "$t0")
load_addr("$t0", CURRENT_TASK)
sw("$zero", 0, "$t0")

# Timer / interrupt-controller setup.
sw("$zero", TIMER_COUNTER, "$s2")
addi("$t0", "$zero", 1)
sw("$t0", TIMER_STATUS, "$s2")
sw("$t0", IRQ_ENABLE, "$s3")
addi("$t0", "$zero", 7)
sw("$t0", TIMER_CONTROL, "$s2")
call("print_os_init_ok")
call("print_sched_ready")
addi("$t0", "$zero", 0x5A)
sw("$t0", 0, "$s1")
addi("$t0", "$zero", 1)
mtc0("$t0", "Status")
cp0_gap()
jump("shell_task")
nop()

label("fail_d")
addi("$t0", "$zero", 0xF0)
sw("$t0", 0, "$s1")
call("print_fail_d")
label("halt")
jump("halt")
nop()

# ---------------------------------------------------------------------------
# Static string routines.
# ---------------------------------------------------------------------------
emit_puts("print_banner", "step_into_mips lab10 tiny os\r\n")
emit_puts("print_ddr_wait", "DDR WAIT\r\n")
emit_puts("print_ddr_cal_ok", "DDR CAL OK\r\n")
emit_puts("print_ddr_test_ok", "DDR TEST OK\r\n")
emit_puts("print_os_init_ok", "OS INIT OK\r\n")
emit_puts("print_sched_ready", "SCHED READY\r\n")
emit_puts("print_prompt", "step-os> ")
emit_puts("print_help", "help ps mem led run\r\n")
emit_puts("print_ps", "task0 shell\r\ntask1 demo\r\n")
emit_puts("print_ok", "OK\r\n")
emit_puts("print_demo_started", "demo started\r\n")
emit_puts("print_unknown", "?\r\n")
emit_puts("print_fail_d", "OS FAIL D\r\n")

# Patch labels.
for idx, typ, target, rs, rt in fixups:
    target_pc = labels[target]
    here = idx * 4
    if typ in ("beq", "bne"):
        imm = (target_pc - (here + 4)) // 4
        prog[idx] = enc_i(typ, rs, rt, imm)
    elif typ in ("j", "jal"):
        prog[idx] = enc_j(typ, target_pc)
    elif typ == "lui_label_hi":
        prog[idx] = enc_i("lui", "$zero", rt, (target_pc >> 16) & 0xFFFF)
    elif typ == "ori_label_lo":
        prog[idx] = enc_i("ori", rs, rt, target_pc & 0xFFFF)
    else:
        raise ValueError(typ)

fixed_listing = []
for addr, word, asm in listing:
    if addr is None:
        fixed_listing.append((addr, word, asm))
    else:
        fixed_listing.append((addr, prog[addr // 4], asm))
listing = fixed_listing

if len(prog) > BOOT_WORDS:
    raise SystemExit(f"program too large for boot_rom: {len(prog)} words")

while len(prog) < BOOT_WORDS:
    prog.append(0)

repo = Path(__file__).resolve().parents[2]
mem_path = repo / "src" / "lab_10_tiny_os" / "lab_10_boot.mem"
lst_path = Path(__file__).with_suffix(".lst")

mem_path.write_text("\n".join(f"{word:08x}" for word in prog) + "\n")

lst_lines = []
for addr, word, asm in listing:
    if addr is None:
        lst_lines.append(f"             {asm}")
    else:
        lst_lines.append(f"{addr:08x}: {word:08x}  {asm}")
lst_path.write_text("\n".join(lst_lines) + "\n")
print(f"wrote {mem_path} ({len(prog)} words)")
print(f"wrote {lst_path}")
print(f"StepOS image uses {len([w for w in prog if w != 0])} non-zero words before padding")
