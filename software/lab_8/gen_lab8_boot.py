#!/usr/bin/env python3
"""Generate the lab_8 interrupt/timer boot ROM image.

The lab_8 program exercises the minimal CP0-like path added to the teaching MIPS
pipeline. Reset code initializes UART/GPIO/timer MMIO, enables interrupts via
mtc0 Status, then idles. The exception vector at 0x00000180 handles timer IRQs,
clears the timer pending bit, increments LEDs, prints "tick\r\n", and returns
with eret.
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
        "$sp": 29,
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

UART_TXDATA = 0x0
UART_STATUS = 0x8
TIMER_COUNTER = 0x0
TIMER_CONTROL = 0x8
TIMER_STATUS = 0xC
IRQ_ENABLE = 0x4
EXCEPTION_VECTOR = 0x180
BOOT_WORDS = 1024

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


def call(name):
    jal(name)
    nop()


def ret():
    jr("$ra")
    nop()


def cp0_gap():
    # This MVP has no CP0 hazard unit. Give mtc0 time to commit in M stage
    # before a following mfc0/interrupt-dependent instruction observes it.
    nop()
    nop()
    nop()


def fail(code):
    addi("$a0", "$zero", ord(code))
    call("print_fail")
    jump("halt")
    nop()


def emit_irq_putc(ch):
    addi("$k0", "$zero", ord(ch))
    wait_label = f"irq_putc_wait_{len(prog)}"
    label(wait_label)
    lw("$k1", UART_STATUS, "$s0")
    andi("$k1", "$k1", 1)
    beq("$k1", "$zero", wait_label)
    nop()
    sw("$k0", UART_TXDATA, "$s0")


def emit_irq_puts(text):
    for ch in text:
        emit_irq_putc(ch)


# ---------------------------------------------------------------------------
# Reset vector at 0x00000000
# ---------------------------------------------------------------------------
label("reset")
load_addr("$s0", UART_BASE)
load_addr("$s1", GPIO_BASE)
load_addr("$s2", TIMER_BASE)
load_addr("$s3", IRQ_BASE)
addi("$s4", "$zero", 0)   # LED/tick counter, intentionally kept across IRQs
sw("$s4", 0, "$s1")

# Prove that mtc0/mfc0 are wired before enabling timer interrupts.
addi("$t0", "$zero", 0)
mtc0("$t0", "Status")
cp0_gap()
mfc0("$t1", "Status")
bne("$t1", "$zero", "fail_c")
nop()

call("print_banner")
call("print_ready")

# Timer / interrupt-controller setup. The RTL parameter supplies the compare
# value: 50,000,000 cycles on hardware and a small value in simulation.
addi("$t0", "$zero", 1)
sw("$t0", TIMER_STATUS, "$s2")  # clear stale pending
sw("$t0", IRQ_ENABLE, "$s3")    # enable timer IRQ line
addi("$t0", "$zero", 7)         # enable | irq_enable | auto_reload
sw("$t0", TIMER_CONTROL, "$s2")
addi("$t0", "$zero", 1)         # CP0 Status.IE=1, EXL=0
mtc0("$t0", "Status")
cp0_gap()

label("idle")
jump("idle")
nop()

if len(prog) > EXCEPTION_VECTOR // 4:
    raise SystemExit(f"reset section too large for exception vector: {len(prog)} words")
# Keep the pre-vector padding safe. If an interrupt/eret experiment ever returns
# into the padding area, it will loop back to idle rather than falling into
# diagnostics or the exception vector.
while len(prog) < EXCEPTION_VECTOR // 4:
    if len(prog) + 2 <= EXCEPTION_VECTOR // 4:
        jump("idle")
        nop()
    else:
        nop()

# ---------------------------------------------------------------------------
# Exception vector at 0x00000180
# ---------------------------------------------------------------------------
label("exception_vector")
if pc() != EXCEPTION_VECTOR:
    raise SystemExit(f"exception vector misplaced at 0x{pc():08x}")

mfc0("$k0", "Cause")            # exercise mfc0 in the handler
lw("$k1", TIMER_STATUS, "$s2")
andi("$k1", "$k1", 1)
beq("$k1", "$zero", "exception_done")
nop()
addi("$s4", "$s4", 1)
sw("$s4", 0, "$s1")
addi("$k1", "$zero", 1)
sw("$k1", TIMER_STATUS, "$s2")  # clear timer pending before eret
emit_irq_puts("tick\r\n")

label("exception_done")
eret()
nop()

# ---------------------------------------------------------------------------
# Shared UART print routines. They are intentionally placed after the vector so
# reset code remains below 0x180.
# ---------------------------------------------------------------------------
label("putc")
lw("$t0", UART_STATUS, "$s0")
andi("$t0", "$t0", 1)
beq("$t0", "$zero", "putc")
nop()
sw("$a0", UART_TXDATA, "$s0")
ret()


def emit_puts(label_name, text):
    label(label_name)
    rr("addu", "$s7", "$ra", "$zero")
    for ch in text:
        addi("$a0", "$zero", ord(ch))
        call("putc")
    rr("addu", "$ra", "$s7", "$zero")
    ret()


emit_puts("print_banner", "step_into_mips lab8 interrupt\r\n")
emit_puts("print_ready", "IRQ READY\r\n")

label("print_fail")
rr("addu", "$s7", "$ra", "$zero")
for ch in "CP0 FAIL ":
    addi("$t9", "$zero", ord(ch))
    rr("addu", "$t8", "$a0", "$zero")
    rr("addu", "$a0", "$t9", "$zero")
    call("putc")
    rr("addu", "$a0", "$t8", "$zero")
call("putc")
addi("$a0", "$zero", ord("\r"))
call("putc")
addi("$a0", "$zero", ord("\n"))
call("putc")
rr("addu", "$ra", "$s7", "$zero")
ret()

label("fail_c")
fail("C")

label("halt")
jump("halt")
nop()

# Patch labels.
for idx, typ, target, rs, rt in fixups:
    target_pc = labels[target]
    here = idx * 4
    if typ in ("beq", "bne"):
        imm = (target_pc - (here + 4)) // 4
        prog[idx] = enc_i(typ, rs, rt, imm)
    elif typ in ("j", "jal"):
        prog[idx] = enc_j(typ, target_pc)
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
mem_path = repo / "src" / "lab_8_interrupt" / "lab_8_boot.mem"
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
