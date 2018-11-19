#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n71_lh_adel_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, 0x04
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
	mtc0  s7, c0_status
    nop
    lui   s7, 0x0004      #add ex, ref return value.
###test inst
 ##1
    TEST_LH_ADEL(0x0233e52c, 0x800d1348, 0x00009a19, 0x00009a18, 0x93252910)
    la    s4, 1f
1:  lh v0, -0x65e7(a0)
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##2
    li    s2, 0x04
    TEST_LH_ADEL(0x2ba90e90, 0x800d2ca8, 0x00002577, 0x00002574, 0x854aa680)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  lh v0, 0x2577(a0)
    sw    s4, 0(t0) 
    lw    t1, 4(t0)
    bne t1, s4, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
    li    s2, 0x04
    sw    s2, 0(t0)
 ##3
    li    s2, 0x04
    TEST_LH_ADEL(0x9554e8d4, 0x800d1570, 0x000085e3, 0x000085e0, 0x541f6c5c)
    la    s4, 1f
    mthi  t0
    divu  zero, t0, s0
1:  lh v0, -0x7a1d(a0)
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##4
    li    s2, 0x04
    TEST_LH_ADEL(0x8ef75a20, 0x800d69cc, 0x00008341, 0x00008340, 0x224cf16c)
    la    s4, 1f
1:  lh v0, -0x7cbf(a0)
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##5
    li    s2, 0x04
    TEST_LH_ADEL(0xcb7ef7d5, 0x800d0438, 0x0000db3b, 0x0000db38, 0x516f5fa2)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  lh v0, -0x24c5(a0)
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##6
    li    s2, 0x04
    TEST_LH_ADEL(0x5118e811, 0x800d2c20, 0x00001915, 0x00001914, 0x3537cc30)
    la    s4, 1f
1:  lh v0, 0x1915(a0)
    multu t0, s2
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##7
    li    s2, 0x04
    TEST_LH_ADEL(0xd80241b4, 0x800d3d5c, 0x000032e9, 0x000032e8, 0x63c6e7af)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  lh v0, 0x32e9(a0)
    mtc0 t0, c0_epc
    bne s2, s7, inst_error
    nop
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
END(n71_lh_adel_ex_test)
