#include <asm.h>
#include <regdef.h>
#include <inst_test.h>

LEAF(n20_jr_ds_test)
    .set noreorder
    addiu s0, s0 ,1
    li  s2, 0x00
###test inst
    TEST_JR_DS(lui,   t0,0x800d)
    TEST_JR_DS(addiu, t1, t0, 0x8123)
    TEST_JR_DS(sw,    t1, -0x7120(t0))
    TEST_JR_DS(lw,    t2, -0x7120(t0))
    TEST_JR_DS(addu,  t3, t1, t2)
    TEST_JR_DS(or,    t4, s1, s2)
    TEST_JR_DS(slt,   t5, s2, s3)
    TEST_JR_DS(slti,  t6, s2, 0x8011)
    TEST_JR_DS(sltiu, t7, s2, 0x8011)
    TEST_JR_DS(sltu,  t8, s2, s3)
    TEST_JR_DS(sll,   t1, s2, 0x11)
    TEST_JR_DS(add,   t2, t0, s0)
    TEST_JR_DS(addi,  t3, s0, 0x8002)
    TEST_JR_DS(sub,   t4, t0, s0)
    TEST_JR_DS(subu,  t5, t0, s0)
    TEST_JR_DS(and,   t6, t0, s0)
    TEST_JR_DS(andi,  t7, s0, 0x8ff2)
    TEST_JR_DS(nor,   t8, t0, s0)
    TEST_JR_DS(ori,   t1, s0, 0x8ff2)
    TEST_JR_DS(xor,   t2, t0, s0)
    TEST_JR_DS(xori,  t3, s0, 0x8ff2)
    TEST_JR_DS(sllv,  t4, t0, s0)
    TEST_JR_DS(sra,   t5, s0, 0x8)
    TEST_JR_DS(srav,  t6, t0, s0)
    TEST_JR_DS(srl,   t7, s0, 0x8)
    TEST_JR_DS(srlv,  t8, t0, s0)
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
END(n20_jr_ds_test)
