#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n18_j_ds_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x00
###test inst
    TEST_J_DS(lui,   t0,0x800d)
    TEST_J_DS(addiu, t1, t0, 0x8123)
    TEST_J_DS(sw,    t1, 0x7120(t0))
    TEST_J_DS(lw,    t2, 0x7120(t0))
    TEST_J_DS(addu,  t3, t1, t2)
    TEST_J_DS(or,    t9, s1, s2)
    TEST_J_DS(slt,   t8, s2, s3)
    TEST_J_DS(slti,  t7, s2, 0x8011)
    TEST_J_DS(sltiu, t7, s2, 0x8011)
    TEST_J_DS(sltu,  t8, s2, s3)
    TEST_J_DS(sll,   t1, s2, 0x11)
    TEST_J_DS(add,   t2, t0, s0)
    TEST_J_DS(addi,  t3, s0, 0x8002)
    TEST_J_DS(sub,   t4, t0, s0)
    TEST_J_DS(subu,  t5, t0, s0)
    TEST_J_DS(and,   t6, t0, s0)
    TEST_J_DS(andi,  t7, s0, 0x8ff2)
    TEST_J_DS(nor,   t8, t0, s0)
    TEST_J_DS(ori,   t1, s0, 0x8ff2)
    TEST_J_DS(xor,   t2, t0, s0)
    TEST_J_DS(xori,  t3, s0, 0x8ff2)
    TEST_J_DS(sllv,  t4, t0, s0)
    TEST_J_DS(sra,   t5, s0, 0x8)
    TEST_J_DS(srav,  t6, t0, s0)
    TEST_J_DS(srl,   t7, s0, 0x8)
    TEST_J_DS(srlv,  t8, t0, s0)
###detect exception
    bne s2, zero, inst_error
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
END(n18_j_ds_test)
