#!/usr/bin/env python3
"""Generate the lab_7 C-runtime precursor boot ROM image.

Lab 7 extends the small teaching MIPS pipeline with the instructions needed for
function calls, 32-bit MMIO addresses, bit operations, and C-like UART routines.
This generator keeps the experiment reproducible without requiring a MIPS cross
compiler during ISA bring-up.
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
        "$sp": 29,
        "$ra": 31,
    }
)

GPIO_BASE = 0x10000000
UART_BASE = 0x10001000
UART_TXDATA = 0x0
UART_RXDATA = 0x4
UART_STATUS = 0x8

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
def sll(rd, rt, sh): emit(enc_r("sll", "$zero", rt, rd, sh), f"sll {rd},{rt},{sh}")
def srl(rd, rt, sh): emit(enc_r("srl", "$zero", rt, rd, sh), f"srl {rd},{rt},{sh}")
def jr(rs): emit(enc_r("jr", rs, "$zero", "$zero"), f"jr {rs}")
def nop(): emit(0, "nop")


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


def fail(code):
    addi("$a0", "$zero", ord(code))
    call("print_fail")
    jump("halt")
    nop()


label("reset")
load_addr("$s0", UART_BASE)  # UART base, proves lui/ori/high MMIO address
load_addr("$s1", GPIO_BASE)  # GPIO base
addi("$s2", "$zero", 1)     # LED/activity counter
sw("$s2", 0, "$s1")

call("run_isa_tests")
call("print_banner")
call("print_isa_pass")

label("main")
lw("$t0", UART_STATUS, "$s0")
andi("$t0", "$t0", 2)
beq("$t0", "$zero", "main")
nop()
lw("$a0", UART_RXDATA, "$s0")
addi("$s2", "$s2", 1)
sw("$s2", 0, "$s1")
call("putc")
jump("main")
nop()

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


emit_puts("print_banner", "step_into_mips lab7 c-runtime\r\n")
emit_puts("print_isa_pass", "ISA PASS\r\n> ")

label("print_fail")
rr("addu", "$s7", "$ra", "$zero")
for ch in "ISA FAIL ":
    addi("$t9", "$zero", ord(ch))
    # save fail code in t8 across putc call
    rr("addu", "$t8", "$a0", "$zero")
    rr("addu", "$a0", "$t9", "$zero")
    call("putc")
    rr("addu", "$a0", "$t8", "$zero")
call("putc")
addi("$a0", "$zero", ord('\r'))
call("putc")
addi("$a0", "$zero", ord('\n'))
call("putc")
rr("addu", "$ra", "$s7", "$zero")
ret()

label("run_isa_tests")
rr("addu", "$s6", "$ra", "$zero")
# lui/ori should construct UART_BASE exactly.
load_addr("$t0", UART_BASE)
bne("$t0", "$s0", "fail_l")
nop()
# andi/xori zero-extension and xor behavior.
addi("$t1", "$zero", -1)
andi("$t2", "$t1", 0x00ff)
addi("$t3", "$zero", 255)
bne("$t2", "$t3", "fail_a")
nop()
xori("$t2", "$t2", 0x00ff)
bne("$t2", "$zero", "fail_x")
nop()
# sll/srl use rt + shamt.
addi("$t1", "$zero", 1)
sll("$t2", "$t1", 4)
addi("$t3", "$zero", 16)
bne("$t2", "$t3", "fail_s")
nop()
srl("$t2", "$t2", 3)
addi("$t3", "$zero", 2)
bne("$t2", "$t3", "fail_r")
nop()
# addu/subu.
addi("$t1", "$zero", 7)
addi("$t2", "$zero", 3)
rr("addu", "$t3", "$t1", "$t2")
addi("$t4", "$zero", 10)
bne("$t3", "$t4", "fail_u")
nop()
rr("subu", "$t3", "$t3", "$t2")
bne("$t3", "$t1", "fail_d")
nop()
# jal/jr: helper returns 42 in v0.
call("return_42")
addi("$t0", "$zero", 42)
bne("$v0", "$t0", "fail_j")
nop()
rr("addu", "$ra", "$s6", "$zero")
ret()

for code, lbl in [("L", "fail_l"), ("A", "fail_a"), ("X", "fail_x"), ("S", "fail_s"),
                  ("R", "fail_r"), ("U", "fail_u"), ("D", "fail_d"), ("J", "fail_j")]:
    label(lbl)
    fail(code)

label("return_42")
addi("$v0", "$zero", 42)
ret()

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

if len(prog) > 1024:
    raise SystemExit(f"program too large for boot_rom: {len(prog)} words")

while len(prog) < 1024:
    prog.append(0)

repo = Path(__file__).resolve().parents[2]
mem_path = repo / "src" / "lab_7_c_runtime" / "lab_7_boot.mem"
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
