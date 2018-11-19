#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n80_bgez_ds_ex_test)
    .set noreorder
    addiu s0, s0, 1
    li    t0, 0x800d0000
##clear cause.TI, status.EXL
    mtc0  zero, c0_compare
    lui   s7,0x0040
	mtc0  s7, c0_status
    nop
###test inst
 ##1: syscall
    li    s2, 0x01
    lui   s7, 0x0001      #ex, ref return value.
    sw    s2, 0(t0)
    la    s4, 1f
1:  bgez  zero, inst_error
    syscall
    bne s2, s7, inst_error
    nop
    li    s2, 0x01
    la    s4, 2f
2:  bgez  t0, inst_error
    syscall
    bne s2, s7, inst_error
    nop
 ##2: break
    li    s2, 0x02
    lui   s7, 0x0002      #ex, ref return value.
    sw    s2, 0(t0)
    la    s4, 1f
1:  bgez  zero, inst_error
    break
    bne s2, s7, inst_error
    nop
    li    s2, 0x02
    la    s4, 2f
2:  bgez  t0,  inst_error
    break
    bne s2, s7, inst_error
    nop
 ##3: ov
    li    s2, 0x03
    lui   s7, 0x0003      #ex, ref return value.
    sw    s2, 0(t0)
    la    s4, 1f
    li    a0, 0xba034f60
    li    a1, 0xb615fd67
1:  bgez  zero, inst_error
    add   s7, a0, a1
    bne s2, s7, inst_error
    nop
    li    s2, 0x03
    la    s4, 2f
2:  bgez  t0, inst_error
    add   s7, a0, a1
    sw    s7, 0(t0)
    bne s2, s7, inst_error
    nop
    li    s2, 0x03
    sw    s2, 0(t0)
    la    s4, 1f
    li    a0,0x7fffc19e
1:  bgez  zero, inst_error
    addi  s7, a0, 0x6512
    bne s2, s7, inst_error
    nop
    li    s2, 0x03
    la    s4, 2f
2:  bgez  t0, inst_error
    addi  s7, a0, 0x6512
    bne s2, s7, inst_error
    nop
    li    s2, 0x03
    la    s4, 1f
    li    a0, 0xa85e7d00
    li    a1, 0x6b7e8e36
1:  bgez  zero, inst_error
    sub   s7, a0, a1
    bne s2, s7, inst_error
    nop
    li    s2, 0x03
    la    s4, 2f
2:  bgez  t0, inst_error
    sub   s7, a0, a1
    bne s2, s7, inst_error
    nop
 ##4: load adel
    li    s2, 0x04
    lui   s7, 0x0004      #ex, ref return value.
    sw    s2, 0(t0)
    la    s4, 1f
1:  bgez  zero, inst_error
    lw    s7, 2(t0)
    bne s2, s7, inst_error
    nop
    li    s2, 0x04
    la    s4, 2f
2:  bgez  t0, inst_error
    lw    s7, 2(t0)
    bne s2, s7, inst_error
    nop
    li    s2, 0x04
    la    s4, 1f
1:  bgez  zero, inst_error
    lh    s7, 1(t0)
    divu zero, s7, s2
    bne s2, s7, inst_error
    nop
    li    s2, 0x04
    la    s4, 2f
2:  bgez  t0, inst_error
    lh    s7, 1(t0)
    bne s2, s7, inst_error
    nop
    la    s4, 1f
1:  bgez  zero, inst_error
    lhu   s7, 3(t0)
    bne s2, s7, inst_error
    nop
    li    s2, 0x04
    la    s4, 2f
2:  bgez  t0, inst_error
    lhu   s7, 3(t0)
    bne s2, s7, inst_error
    nop
 ##5: store ades
    li    s2, 0x05
    lui   s7, 0x0005      #ex, ref return value.
    sw    s2, 0(t0)
    la    s4, 1f
1:  bgez  zero, inst_error
    sw    s7, 2(t0)
    bne s2, s7, inst_error
    nop
    li    s2, 0x05
    la    s4, 2f
2:  bgez  t0, inst_error
    sw    s7, 2(t0)
    bne s2, s7, inst_error
    nop
    li    s2, 0x05
    la    s4, 1f
1:  bgez  zero, inst_error
    sh    s7, 1(t0)
    bne s2, s7, inst_error
    nop
    li    s2, 0x05
    la    s4, 2f
2:  bgez  t0, inst_error
    sh    s7, 1(t0)
    bne s2, s7, inst_error
    nop
 ##6: fetch adel:no
 ##7: reserved instruction
    li    s2, 0x07
    lui   s7, 0x0007      #ex, ref return value.
    sw    s2, 0(t0)
    la    s4, 1f
1:  bgez  zero, inst_error
    .word 0x9e3c56aa
    mult  s7, s2
    bne s2, s7, inst_error
    nop
    li    s2, 0x07
    la    s4, 2f
    mult  s7, s2
2:  bgez  t0, inst_error
    .word 0xec1ba960
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
END(n80_bgez_ds_ex_test)
