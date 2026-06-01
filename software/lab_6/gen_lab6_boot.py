#!/usr/bin/env python3
"""Generate the lab_6 UART boot ROM image.

The 2017 teaching core intentionally supports only a small MIPS subset
(add/sub/and/or/slt/lw/sw/beq/addi/j).  This script keeps the first UART
monitor image reproducible without requiring a full MIPS cross toolchain.
"""
from pathlib import Path

OP = {
    "addi": 0x08,
    "lw": 0x23,
    "sw": 0x2B,
    "beq": 0x04,
    "j": 0x02,
}

FUNCT = {
    "add": 0x20,
    "sub": 0x22,
    "and": 0x24,
    "or": 0x25,
    "slt": 0x2A,
}

REG = {f"${i}": i for i in range(32)}
REG.update(
    {
        "$zero": 0,
        "$v0": 2,
        "$a0": 4,
        "$a1": 5,
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
        "$ra": 31,
    }
)

UART_ALIAS = 0x1000
UART_TXDATA = UART_ALIAS + 0x0
UART_RXDATA = UART_ALIAS + 0x4
UART_STATUS = UART_ALIAS + 0x8
GPIO_ALIAS = 0x0000

prog = []
labels = {}
fixups = []
listing = []


def enc_i(op, rs, rt, imm):
    return (OP[op] << 26) | (REG[rs] << 21) | (REG[rt] << 16) | (imm & 0xFFFF)


def enc_r(funct, rs, rt, rd, shamt=0):
    return (REG[rs] << 21) | (REG[rt] << 16) | (REG[rd] << 11) | (shamt << 6) | FUNCT[funct]


def enc_j(addr):
    return (OP["j"] << 26) | ((addr >> 2) & 0x03FF_FFFF)


def pc():
    return len(prog) * 4


def label(name):
    labels[name] = pc()
    listing.append((None, None, f"{name}:"))


def emit(word, asm):
    listing.append((pc(), word, asm))
    prog.append(word)


def addi(rt, rs, imm):
    emit(enc_i("addi", rs, rt, imm), f"addi {rt},{rs},{imm}")


def lw(rt, off, rs):
    emit(enc_i("lw", rs, rt, off), f"lw {rt},{off}({rs})")


def sw(rt, off, rs):
    emit(enc_i("sw", rs, rt, off), f"sw {rt},{off}({rs})")


def rr(funct, rd, rs, rt):
    emit(enc_r(funct, rs, rt, rd), f"{funct} {rd},{rs},{rt}")


def beq(rs, rt, target):
    fixups.append((len(prog), "beq", target, rs, rt))
    emit(0, f"beq {rs},{rt},{target}")


def jump(target):
    fixups.append((len(prog), "j", target, None, None))
    emit(0, f"j {target}")


def nop():
    emit(0, "nop")


def wait_tx_ready(prefix):
    label(f"{prefix}_tx_wait")
    lw("$t3", UART_STATUS, "$zero")
    rr("and", "$t5", "$t3", "$t7")
    beq("$t5", "$zero", f"{prefix}_tx_wait")
    nop()


def send_char(ch, idx):
    wait_tx_ready(f"send_{idx:02d}")
    addi("$t2", "$zero", ord(ch))
    sw("$t2", UART_TXDATA, "$zero")


label("reset")
# Constants used by the tiny monitor loop.
addi("$t7", "$zero", 1)  # tx_ready mask
addi("$t4", "$zero", 2)  # rx_valid mask
addi("$t0", "$zero", 1)  # LED/activity counter
sw("$t0", GPIO_ALIAS, "$zero")

banner = "step_into_mips boot monitor\r\n> "
for idx, ch in enumerate(banner):
    send_char(ch, idx)

label("main")
lw("$t3", UART_STATUS, "$zero")
rr("and", "$t5", "$t3", "$t4")
beq("$t5", "$zero", "main")
nop()

# Echo one received byte, update LEDs as a simple visible activity indicator,
# and then return to polling.  Full h/r/w/g command parsing is kept for the
# next software iteration once lab_7 adds byte/shift/jump-register support.
lw("$t6", UART_RXDATA, "$zero")
addi("$t0", "$t0", 1)
sw("$t0", GPIO_ALIAS, "$zero")
wait_tx_ready("echo")
sw("$t6", UART_TXDATA, "$zero")
jump("main")
nop()

# Patch labels.
for idx, typ, target, rs, rt in fixups:
    target_pc = labels[target]
    here = idx * 4
    if typ == "beq":
        imm = (target_pc - (here + 4)) // 4
        prog[idx] = enc_i("beq", rs, rt, imm)
    elif typ == "j":
        prog[idx] = enc_j(target_pc)
    else:
        raise ValueError(typ)

# Update listing words after fixups.
fixed_listing = []
word_iter = iter(prog)
for addr, word, asm in listing:
    if addr is None:
        fixed_listing.append((addr, word, asm))
    else:
        fixed_listing.append((addr, prog[addr // 4], asm))
listing = fixed_listing

if len(prog) > 256:
    raise SystemExit(f"program too large for boot_rom: {len(prog)} words")

while len(prog) < 256:
    prog.append(0)

repo = Path(__file__).resolve().parents[2]
mem_path = repo / "src" / "lab_6_uart_boot" / "lab_6_boot.mem"
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
