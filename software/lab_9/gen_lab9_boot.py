#!/usr/bin/env python3
"""Generate the lab_9 DDR boot ROM image.

The program waits for the DDR calibration status bit, writes and reads back a
few words in the 0x80000000 DDR window, and reports the result over UART.
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

GPIO_BASE = 0x10000000
UART_BASE = 0x10001000
DDR_STATUS_BASE = 0x10004000
DDR_BASE = 0x80000000

UART_TXDATA = 0x0
UART_STATUS = 0x8
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


def call(name):
    jal(name)
    nop()


def ret():
    jr("$ra")
    nop()


def check_word(offset, value, code):
    load_imm("$t0", value)
    sw("$t0", offset, "$s3")
    lw("$t1", offset, "$s3")
    bne("$t0", "$t1", f"fail_{code}")
    nop()


label("reset")
load_addr("$s0", UART_BASE)
load_addr("$s1", GPIO_BASE)
load_addr("$s2", DDR_STATUS_BASE)
load_addr("$s3", DDR_BASE)
addi("$s4", "$zero", 0)
sw("$s4", 0, "$s1")

call("print_banner")

label("wait_ddr_cal")
lw("$t0", 0, "$s2")
andi("$t0", "$t0", 1)
bne("$t0", "$zero", "ddr_cal_ready")
nop()
addi("$s5", "$s5", 1)
andi("$t2", "$s5", 0x3FFF)
bne("$t2", "$zero", "wait_ddr_cal")
nop()
call("print_wait")
jump("wait_ddr_cal")
nop()

label("ddr_cal_ready")
call("print_cal_ok")

check_word(0x0000, 0x12345678, "0")
check_word(0x0004, 0xA5A5C3C3, "1")
check_word(0x0010, 0x00000000, "2")
check_word(0x003C, 0xFFFFFFFF, "3")
check_word(0x0100, 0x55AA00FF, "4")

addi("$s4", "$zero", 0x5A)
sw("$s4", 0, "$s1")
label("pass_loop")
call("print_pass")
jump("pass_loop")
nop()

label("halt")
jump("halt")
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


emit_puts("print_banner", "step_into_mips lab9 ddr\r\n")
emit_puts("print_wait", "DDR WAIT\r\n")
emit_puts("print_cal_ok", "DDR CAL OK\r\n")
emit_puts("print_pass", "DDR PASS\r\n")

label("print_fail")
rr("addu", "$s7", "$ra", "$zero")
for ch in "DDR FAIL ":
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

for code in "01234":
    label(f"fail_{code}")
    addi("$s4", "$zero", 0xF0 + int(code))
    sw("$s4", 0, "$s1")
    addi("$a0", "$zero", ord(code))
    call("print_fail")
    label(f"fail_{code}_loop")
    addi("$a0", "$zero", ord(code))
    call("print_fail")
    jump(f"fail_{code}_loop")
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
mem_path = repo / "src" / "lab_9_ddr" / "lab_9_boot.mem"
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
