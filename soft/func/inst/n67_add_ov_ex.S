#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n67_add_ov_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, 0x03
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
	mtc0  s7, c0_status
    nop
    lui   s7, 0x0003      #add ex, ref return value.
###test inst
 ##1
    TEST_ADD_OV_PRE(0x90a5f39c, 0xd42179e0, 0x73b2cf92)
    la    s4, 1f
1:  add v0, a0, a1
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##2
    li    s2, 0x03
    TEST_ADD_OV_PRE(0x2a3ca166, 0x797f30b9, 0x1a376500)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  add v0, a0, a1
    sw    s4, 0(t0) 
    lw    t1, 4(t0)
    bne t1, s4, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    li    s2, 0x03
    sw    s2, 0(t0)
 ##3
    li    s2, 0x03
    la    s4, 1f
    mthi  t0
    TEST_ADD_OV_PRE(0x805413c0, 0xdea0e60a, 0x57b9e040)
    divu  zero, t0, s0
1:  add v0, a0, a1
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##4
    li    s2, 0x03
    TEST_ADD_OV_PRE(0x474db690, 0x4d4cbef8, 0x89a0a980)
    la    s4, 1f
1:  add v0, a0, a1
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##5
    li    s2, 0x03
    TEST_ADD_OV_PRE(0x6818e272, 0x6f6d2620, 0x0f29c5e0)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  add v0, a0, a1
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##6
    li    s2, 0x03
    TEST_ADD_OV_PRE(0xa7b7a764, 0xc2d61d9c, 0x9f1c5870)
    la    s4, 1f
1:  add v0, a0, a1
    multu t0, s2
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##7
    li    s2, 0x03
    TEST_ADD_OV_PRE(0x8a78cc40, 0xab7284da, 0x31e6699f)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  add v0, a0, a1
    mtc0 t0, c0_epc
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
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
END(n67_add_ov_ex_test)
