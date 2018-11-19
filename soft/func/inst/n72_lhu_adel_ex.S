#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n72_lhu_adel_ex_test)
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
    TEST_LHU_ADEL(0x0dc5e542, 0x800d0514, 0x0000b239, 0x0000b238, 0x80030514)
    la    s4, 1f
1:  lhu v0, -0x4dc7(a0)
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##2
    li    s2, 0x04
    TEST_LHU_ADEL(0xf7812ae2, 0x800d2fbc, 0x00009c35, 0x00009c34, 0x80032fbc)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  lhu   v0, -0x63cb(a0)
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
    TEST_LHU_ADEL(0x9ef65910, 0x800d7fa6, 0x0000537f, 0x0000537e, 0x9134bbd0)
    la    s4, 1f
    mthi  t0
    divu  zero, t0, s0
1:  lhu v0, 0x537f(a0)
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
    TEST_LHU_ADEL(0xa15a0146, 0x800d628c, 0x000056cf, 0x000056cc, 0xfe29b934)
    la    s4, 1f
1:  lhu v0, 0x56cf(a0)
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
    TEST_LHU_ADEL(0x566dadc2, 0x800d24b4, 0x0000d5c3, 0x0000d5c0, 0x800324b4)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  lhu v0, -0x2a3d(a0)
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
    TEST_LHU_ADEL(0x038f18a2, 0x800d6024, 0x00000765, 0x00000764, 0x52b9c98a)
    la    s4, 1f
1:  lhu v0, 0x0765(a0)
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
    TEST_LHU_ADEL(0xcd7ab654, 0x800d8294, 0x000079f5, 0x000079f4, 0x2b771238)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  lhu  v0, 0x79f5(a0)
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
END(n72_lhu_adel_ex_test)
