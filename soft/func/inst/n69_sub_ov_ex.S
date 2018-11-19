#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n69_sub_ov_ex_test)
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
    TEST_SUB_OV_PRE(0x63d3fd1e, 0xd0378bea, 0x3f0637b6)
    la    s4, 1f
1:  sub v0, a0, a1
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##2
    li    s2, 0x03
    TEST_SUB_OV_PRE(0x6f8c1169, 0x9eddbba4, 0x8754eb0d)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  sub v0, a0, a1
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
    TEST_SUB_OV_PRE(0x734a367f, 0xe17354f8, 0xf4e01aa8)
    la    s4, 1f
    mthi  t0
    divu  zero, t0, s0
1:  sub v0, a0, a1
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##4
    li    s2, 0x03
    TEST_SUB_OV_PRE(0x21ccbee8, 0x9a01fac4, 0xdc373c00)
    la    s4, 1f
1:  sub v0, a0, a1
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##5
    li    s2, 0x03
    TEST_SUB_OV_PRE(0xb196dd00, 0x7dfd9ab0, 0xb226ec94)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  sub v0, a0, a1
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##6
    li    s2, 0x03
    TEST_SUB_OV_PRE(0xb53cd464, 0x421d020a, 0x1625bcc8)
    la    s4, 1f
1:  sub v0, a0, a1
    multu t0, s2
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##7
    li    s2, 0x03
    TEST_SUB_OV_PRE(0x70410c7a, 0x8ddc20c0, 0x9f767750)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  sub v0, a0, a1
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
END(n69_sub_ov_ex_test)
