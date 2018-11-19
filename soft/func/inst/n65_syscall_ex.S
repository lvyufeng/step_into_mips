#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n65_syscall_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
    li    s2, 0x01
    sw    s2, 0(t0)
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
	mtc0  s7, c0_status
    nop
    lui   s7, 0x0001      #syscall ex, ref return value.
###test inst
 ##1
    la    s4, syscall_pc1
syscall_pc1:
    syscall
    bne s2, s7, inst_error
    nop
 ##2
    li    s2, 0x01
    la    s4, syscall_pc2
    sw    t0, 4(t0)
    sw    s4, 4(t0) 
syscall_pc2:
    syscall
    sw    s4, 0(t0) 
    lw    t1, 4(t0)
    bne t1, s4, inst_error
    nop
    bne s2, s7, inst_error
    nop
    li    s2, 0x01
    sw    s2, 0(t0)
 ##3
    li    s2, 0x01
    la    s4, syscall_pc3
    mthi  t0
    divu  zero, t0, s0
syscall_pc3:
    syscall
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
 ##4
    li    s2, 0x01
    la    s4, syscall_pc4
syscall_pc4:
    syscall
    divu  zero, s0, t0
    bne s2, s7, inst_error
    nop
 ##5
    li    s2, 0x01
    la    s4, syscall_pc5
    mtlo  t0
    multu t0, s0
syscall_pc5:
    syscall
    mfhi  t1
    beq   t1, t0, inst_error
    nop
    bne s2, s7, inst_error
    nop
 ##6
    li    s2, 0x01
    la    s4, syscall_pc6
syscall_pc6:
    syscall
    multu t0, s2
    bne s2, s7, inst_error
    nop
 ##7
    li    s2, 0x01
    la    s4, syscall_pc7
    mtc0  s2, c0_epc
syscall_pc7:
    syscall
    mtc0 t0, c0_epc
    bne s2, s7, inst_error
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
END(n65_syscall_ex_test)
