#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n73_sw_ades_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, 0x05
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
	mtc0  s7, c0_status
    nop
    lui   s7, 0x0005      #add ex, ref return value.
###test inst
 ##1
    TEST_SW_ADES(0xb189c470, 0x800d7bd1, 0x00007974, 0x00007973, 0xb189c470)
    la    s4, 1f
1:  sw a1, 0x7974(a0)
    bne s2, s7, inst_error
    nop
    lw v0, 0x7973(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##2
    li    s2, 0x05
    TEST_SW_ADES(0xc052b3f0, 0x800d23d4, 0x000064a2, 0x000064a0, 0xc052b3f0)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  sw a1, 0x64a2(a0)
    sw    s4, 0(t0) 
    lw    t1, 4(t0)
    bne t1, s4, inst_error
    nop
    bne s2, s7, inst_error
    nop
    lw v0, 0x64a0(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
    li    s2, 0x05
    sw    s2, 0(t0)
 ##3
    li    s2, 0x05
    TEST_SW_ADES(0x994c0280, 0x800d8850, 0x0000418b, 0x00004188, 0xa10febaf)
    la    s4, 1f
    mthi  t0
    divu  zero, t0, s0
1:  sw a1, 0x418b(a0)
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    lw v0, 0x4188(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##4
    li    s2, 0x05
    TEST_SW_ADES(0xeb54b87c, 0x800da256, 0x000000c3, 0x000000c2, 0xeb54b87c)
    la    s4, 1f
1:  sw a1, 0x00c3(a0)
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
    lw v0, 0x00c2(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##5
    li    s2, 0x05
    TEST_SW_ADES(0xebdc8860, 0x800d206c, -0x333e, -0x3340, 0x80032066)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  sw a1, -0x333e(a0)
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    lw v0, -0x3340(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##6
    li    s2, 0x05
    TEST_SW_ADES(0x0c41f5e8, 0x800d82d8, -0x7777, -0x7778, 0x634858c8)
    la    s4, 1f
1:  sw a1, -0x7777(a0)
    multu t0, s2
    bne s2, s7, inst_error
    nop
    lw v0, -0x7778(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##7
    li    s2, 0x05
    TEST_SW_ADES(0xcb09da60, 0x800d1750, -0x64d9, -0x64dc, 0x80031751)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  sw a1, -0x64d9(a0)
    mtc0 t0, c0_epc
    bne s2, s7, inst_error
    nop
    lw v0, -0x64dc(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
###score ++
    addiu s3, s3, 1
###output (s0<<24)|s3
inst_error:  
    sll t1, s0, 24
    or t0, t1, s3 
    sw t0, 0(s1)
    jr ra
    nop
END(n73_sw_ades_ex_test)
