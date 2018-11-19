#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n75_ft_adel_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, 0x06
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
	mtc0  s7, c0_status
    nop
    lui   s7, 0x0006      #add ex, ref return value.
###test inst
 ##1
    TEST_FT_ADEL(0xb27f9789)
    la    s5, 1f
    jr  s4
1:  nop
    bne s2, s7, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##2
    li    s2, 0x06
    TEST_FT_ADEL(0xa101bbed)
    mtc0  s4, c0_epc;
    la    s5, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
    .set mips32
1:  eret
    .set mips0
    sw    s4, 0(t0) 
    lw    t1, 4(t0)
    bne t1, s4, inst_error
    nop
    bne s2, s7, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
    li    s2, 0x06
    sw    s2, 0(t0)
 ##3
    li    s2, 0x06
    TEST_FT_ADEL(0x84790977)
    mtc0  s4, c0_epc;
    la    s5, 1f
    mthi  t0
    divu  zero, t0, s0
    .set mips32
1:  eret
    .set mips0
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##4
    li    s2, 0x06
    TEST_FT_ADEL(0x92b0a2c3)
    la    s5, 1f
    jr    s4
1:  nop
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##5
    li    s2, 0x06
    TEST_FT_ADEL(0xaf9edafa)
    mtc0  s4, c0_epc;
    la    s5, 1f
    mtlo  t0
    multu t0, s0
    .set mips32
1:  eret
    .set mips0
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##6
    li    s2, 0x06
    TEST_FT_ADEL(0xb088f329)
    la    s5, 1f
    jr    s4
1:  nop
    multu t0, s2
    bne s2, s7, inst_error
    nop
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##7
    li    s2, 0x06
    TEST_FT_ADEL(0x827f97ab)
    mtc0  s4, c0_epc;
    la    s5, 1f
    .set mips32
1:  eret
    .set mips0
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
END(n75_ft_adel_ex_test)
