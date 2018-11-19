#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n74_sh_ades_ex_test)
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
    TEST_SH_ADES(0x47cdf6da, 0x800d602a, -0x73cb, -0x73ce, 0x8003602a)
    la    s4, 1f
1:  sh a1, -0x73cb(a0)
    bne s2, s7, inst_error
    nop
    lw v0, -0x73ce(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##2
    li    s2, 0x05
    TEST_SH_ADES(0x6e9ce24e, 0x800d2c08, 0x0000098b, 0x00000988, 0x6e9ce24e)
    la    s4, 1f
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
1:  sh a1, 0x098b(a0)
    sw    s4, 0(t0) 
    lw    t1, 4(t0)
    bne t1, s4, inst_error
    nop
    bne s2, s7, inst_error
    nop
    lw v0, 0x0988(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
    li    s2, 0x05
    sw    s2, 0(t0)
 ##3
    li    s2, 0x05
    TEST_SH_ADES(0xbb1afce8, 0x800d1356, 0x00001dd3, 0x00001dd2, 0x419f9f3b)
    la    s4, 1f
    mthi  t0
    divu  zero, t0, s0
1:  sh a1, 0x1dd3(a0)
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    lw v0, 0x1dd2(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##4
    li    s2, 0x05
    TEST_SH_ADES(0x190a65ca, 0x800d372c, -0x790f, -0x7910, 0x80033729)
    la    s4, 1f
1:  sh a1, -0x790f(a0)
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
    lw v0, -0x7910(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##5
    li    s2, 0x05
    TEST_SH_ADES(0x9fcc4ca0, 0x800d1ff0, -0x499d, -0x49a0, 0x80031ff3)
    la    s4, 1f
    mtlo  t0
    multu t0, s0
1:  sh a1, -0x499d(a0)
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
    lw v0, -0x49a0(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##6
    li    s2, 0x05
    TEST_SH_ADES(0xbd6f420a, 0x800d351b, 0x000064f2, 0x000064f1, 0x73b35a2b)
    la    s4, 1f
1:  sh a1, 0x64f2(a0)
    multu t0, s2
    bne s2, s7, inst_error
    nop
    lw v0, 0x64f1(a0)
    bne v0, v1, inst_error
    nop
    mfc0 s6, c0_badvaddr
    bne  a3, s6, inst_error
    nop
 ##7
    li    s2, 0x05
    TEST_SH_ADES(0x00e95990, 0x800d63d7, 0x00007fc6, 0x00007fc5, 0xa5210b0a)
    la    s4, 1f
    mtc0  s2, c0_epc
1:  sh a1, 0x7fc6(a0)
    mtc0 t0, c0_epc
    bne s2, s7, inst_error
    nop
    lw v0, 0x7fc5(a0)
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
END(n74_sh_ades_ex_test)
