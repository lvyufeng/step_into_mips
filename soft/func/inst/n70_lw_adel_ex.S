#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n70_lw_adel_ex_test)
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
    TEST_LW_ADEL(0xb27f9788, 0x800d759c, 0x00008845, 0x00008844, 0x3958f252)
    la    s4, 1f
1:  lw v0, -0x77bb(a0)
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##2
    li    s2, 0x04
    TEST_LW_ADEL(0x3101bbec, 0x800d7748, 0x00000ea2, 0x00000ea0, 0xc0442bd0)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  lw v0, 0x0ea2(a0)
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
    TEST_LW_ADEL(0x94a1ade4, 0x800d59dc, 0x00007cee, 0x00007cec, 0x68929b5c)
    la    s4, 1f
    mthi  t0
    divu  zero, t0, s0
1:  lw v0, 0x7cee(a0)
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
    TEST_LW_ADEL(0xe2b0a2c0, 0x800d7748, 0x00004973, 0x00004970, 0x7423d85f)
    la    s4, 1f
1:  lw v0, 0x4973(a0)
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
    TEST_LW_ADEL(0x0f9edafa, 0x800d5bac, 0x0000003e, 0x0000003c, 0xdd064458)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  lw v0, 0x003e(a0)
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
    TEST_LW_ADEL(0x5077f320, 0x800d0704, 0x0000e53f, 0x0000e53c, 0x15148b6c)
    la    s4, 1f
1:  lw v0, -0x1ac1(a0)
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
    TEST_LW_ADEL(0xb27f9788, 0x800d759c, 0x00008845, 0x00008844, 0x3958f252)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  lw v0, -0x77bb(a0)
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
END(n70_lw_adel_ex_test)
