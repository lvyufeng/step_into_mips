#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n68_addi_ov_ex_test)
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
    TEST_ADDI_OV_PRE(0x7ffff84b, 0x00002c26, 0xdeb06fd0)
    la    s4, 1f
1:  addi v0, a0, 0x2c26
    bne s2, s7, inst_error
    nop
 ##2
    li    s2, 0x03
TEST_ADDI_OV_PRE(0x7ffff480, 0x000054b0, 0x6c5392aa)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  addi v0, a0, 0x54b0
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
    TEST_ADDI_OV_PRE(0x7fff9b21, 0x000071db, 0x60a71e30)
    la    s4, 1f
    mthi  t0
    divu  zero, t0, s0
1:  addi v0, a0, 0x71db
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##4
    li    s2, 0x03
    TEST_ADDI_OV_PRE(0x80003a57, 0x0000be07, 0xe6075700)
    la    s4, 1f
1:  addi v0, a0, -0x41f9
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##5
    li    s2, 0x03
    TEST_ADDI_OV_PRE(0x80002c93, 0x0000845d, 0x8f7ee6c0)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  addi v0, a0, -0x7ba3
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##6
    li    s2, 0x03
    TEST_ADDI_OV_PRE(0x80004016, 0x000081f4, 0xbd3ea700)
    la    s4, 1f
1:  addi v0, a0, -0x7e0c
    multu t0, s2
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
 ##7
    li    s2, 0x03
    TEST_ADDI_OV_PRE(0x80003510, 0x0000baa6, 0x06152570)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  addi v0, a0, -0x455a
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
END(n68_addi_ov_ex_test)
