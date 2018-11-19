// file name: inst_test.h
#include <cpu_cde.h>

#define TEST_LUI(in_a, ref_base) \
    lui   a0, ref_base; \
    lui   t0, in_a;  \
    addu  a0, a0, t1; \
    addu  t1, t1, t2; \
    bne   t0, a0, inst_error; \
    nop

/* 2 */
#define TEST_ADDU(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    addu v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 3 */
#define TEST_ADDIU(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    addiu v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 4 */
#define TEST_BEQ(in_a, in_b, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    lui v0, 0x0; \
    lui v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    LI (v0, back_flag); \
    beq t1, t0, 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    LI (t0, in_a); \
    LI (t1, in_b); \
    beq t0, t1, 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    LI (v1, front_flag); \
4000:; \
    LI (s5, b_flag_ref); \
    LI (s6, f_flag_ref); \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 5 */
#define TEST_BNE(in_a, in_b, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    lui v0, 0x0; \
    lui v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    LI (v0, back_flag); \
    bne t1, t0, 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    LI (t0, in_a); \
    LI (t1, in_b); \
    bne t0, t1, 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    LI (v1, front_flag); \
4000:; \
    LI (s5, b_flag_ref); \
    LI (s6, f_flag_ref); \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 6 */
#define TEST_LW(data, base_addr, offset, offset_align, ref) \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t1, offset_align(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -8; \
    sw a0, offset_align(a0); \
    sw a1, offset_align(a1); \
    lw v0, offset(t0); \
    lw a1, offset_align(a0); \
    lw a0, offset_align(a1); \
    lw a2, offset_align(a1); \
    bne v0, v1, inst_error; \
    nop

/* 7 */
#define TEST_OR(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    or v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 8 */
#define TEST_SLT(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    slt v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 9 */
#define TEST_SLTI(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    slti v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 10 */
#define TEST_SLTIU(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    sltiu v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 11 */
#define TEST_SLL(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    sll v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 12 */
#define TEST_SW(data, base_addr, offset, offset_align, ref) \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t1, offset(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -4; \
    sw a0, offset(a0); \
    sw a1, offset(a1); \
    lw v0, offset_align(t0); \
    lw a0, offset(a1); \
    lw a1, offset(a0); \
    lw a2, offset(a1); \
    bne v0, v1, inst_error; \
    nop

/* 13 */
#define TEST_J(back_flag, front_flag, b_flag_ref, f_flag_ref) \
    lui v0, 0x0;   \
    lui v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    LI (v0, back_flag); \
    j 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    j 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    LI (v1, front_flag); \
4000:; \
    LI (s5, b_flag_ref); \
    LI (s6, f_flag_ref); \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 14 */
#define TEST_JAL(back_flag, front_flag, b_flag_ref, f_flag_ref) \
    addu s7, zero, $31; \
    lui v0, 0x0; \
    lui v1, 0x0; \
    jal 2000f; \
    nop; \
1000:; \
    addu a1, ra, zero; \
    LI (v0, back_flag); \
1001:; \
    jal 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    addu a0, ra, zero; \
    jal 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    addu a2, ra, zero; \
    LI (v1, front_flag); \
4000:; \
    addu $31, zero, s7; \
    LI (s5, b_flag_ref); \
    LI (s6, f_flag_ref); \
    bne v0, s5, inst_error; \
    nop; \
    addiu a2, a2, 0x18; \
    bne v1, s6, inst_error; \
    nop; \
    bne a2, a1, inst_error; \
    nop

/* 15 */
#define TEST_JR(back_flag, front_flag, b_flag_ref, f_flag_ref) \
    lui v0, 0x0; \
    lui v1, 0x0; \
    la t0, 1000f; \
    la t1, 3000f; \
    b 2000f; \
    nop; \
1000:; \
    LI (v0, back_flag); \
    jr t1; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    jr t0; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    LI (v1, front_flag); \
4000:; \
    LI (s5, b_flag_ref); \
    LI (s6, f_flag_ref); \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 16 */
#define TEST_BEQ_DS(op, dest, ...) \
    addiu s5, zero, 0x1; \
    beq s5, zero, 1000f; \
    op  dest , ##__VA_ARGS__; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    beq s5, s5, 2000f; \
    op  s7 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

/* 17 */
#define TEST_BNE_DS(op, dest, ...) \
    addiu s5, zero, 0x1; \
    bne s5, s5, 1000f; \
    op  dest, ##__VA_ARGS__; \
    op  s6, ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bne s5, zero, 2000f; \
    op  s7, ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

/* 18 */
#define TEST_J_DS(op, dest, ...) \
    op  s6, ##__VA_ARGS__; \
    j 2000f; \
    op  dest, ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne dest, s6, inst_error; \
    nop

/* 19 */
#define TEST_JAL_DS(op, dest, ...) \
    addu s7, zero, $31; \
    op  s6, ##__VA_ARGS__; \
    jal 2000f; \
    op  dest, ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    addu $31, zero, s7; \
    bne dest, s6, inst_error; \
    nop

/* 20 */
#define TEST_JR_DS(op, dest, ...) \
    la  s5, 2000f; \
    op  s6, ##__VA_ARGS__; \
    jr  s5; \
    op  dest, ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne dest, s6, inst_error; \
    nop

/* 21 */
#define TEST_ADD(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    add v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 22 */
#define TEST_ADDI(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    addi v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 23 */
#define TEST_SUB(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    sub v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 24 */
#define TEST_SUBU(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    subu v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 25 */
#define TEST_SLTU(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    sltu v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 26 */
#define TEST_AND(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    and v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 27 */
#define TEST_ANDI(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    andi v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 28 */
#define TEST_NOR(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    nor v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 29 */
#define TEST_ORI(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    ori v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 30 */
#define TEST_XOR(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    xor v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 31 */
#define TEST_XORI(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    xori v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 32 */
#define TEST_SLLV(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    sllv v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 33 */
#define TEST_SRA(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    sra v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 34 */
#define TEST_SRAV(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    srav v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 35 */
#define TEST_SRL(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (v1, ref); \
    srl v0, t0, in_b; \
    bne v0, v1, inst_error; \
    nop

/* 36 */
#define TEST_SRLV(in_a, in_b, ref) \
    LI (t0, in_a); \
    LI (t1, in_b); \
    LI (v1, ref); \
    srlv v0, t0, t1; \
    bne v0, v1, inst_error; \
    nop

/* 37 */
#define TEST_BGEZ(in_a, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    li v0, 0x0; \
    li v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    li v0, back_flag; \
    bgez t0, 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    li t0, in_a; \
    bgez t0, 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    li v1, front_flag; \
4000:; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 38 */
#define TEST_BGTZ(in_a, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    li v0, 0x0; \
    li v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    li v0, back_flag; \
    bgtz t0, 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    li t0, in_a; \
    bgtz t0, 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    li v1, front_flag; \
4000:; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 39 */
#define TEST_BLEZ(in_a, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    li v0, 0x0; \
    li v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    li v0, back_flag; \
    blez t0, 3000f; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
2000:; \
    li t0, in_a; \
    blez t0, 1000b; \
    nop; \
    b 4000f; \
    nop; \
    nop; \
3000:; \
    li v1, front_flag; \
4000:; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 40 */
#define TEST_BLTZ(in_a, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    li v0, 0x0; \
    li v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    li v0, back_flag; \
    bltz t0, 3000f; \
    nop; \
    b 4000f; \
    nop; \
2000:; \
    li t0, in_a; \
    bltz t0, 1000b; \
    nop; \
    b 4000f; \
    nop; \
3000:; \
    li v1, front_flag; \
4000:; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 41 */
#define TEST_BLTZAL(in_a, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    addu s7, zero, $31; \
    li v0, 0x0; \
    li v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    addu a0, ra, zero; \
    li v0, back_flag; \
    bltzal t0, 3000f; \
    nop; \
1001:; \
    b 4000f; \
    nop; \
2000:; \
    li t0, in_a; \
    bltzal t0, 1000b; \
    nop; \
2001:; \
    addu a0, ra, zero; \
    la   a1, 1001b; \
    b 4000f; \
    nop; \
3000:; \
    addu a1, ra, zero; \
    li v1, front_flag; \
4000:; \
    addu $31, zero, s7; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop; \
    la s5, 1001b; \
    la s6, 2001b; \
    bne a0, s6, inst_error; \
    nop; \
    bne a1, s5, inst_error; \
    nop

/* 42 */
#define TEST_BGEZAL(in_a, back_flag, front_flag, b_flag_ref, f_flag_ref) \
    addu s7, zero, $31; \
    li v0, 0x0; \
    li v1, 0x0; \
    b 2000f; \
    nop; \
1000:; \
    addu a0, ra, zero; \
    li v0, back_flag; \
    bgezal t0, 3000f; \
    nop; \
1001:; \
    b 4000f; \
    nop; \
2000:; \
    li t0, in_a; \
    bgezal t0, 1000b; \
    nop; \
2001:; \
    addu a0, ra, zero; \
    la   a1, 1001b; \
    b 4000f; \
    nop; \
3000:; \
    addu a1, ra, zero; \
    li v1, front_flag; \
4000:; \
    addu $31, zero, s7; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop; \
    la s5, 1001b; \
    la s6, 2001b; \
    bne a0, s6, inst_error; \
    nop; \
    bne a1, s5, inst_error; \
    nop

/* 43 */
#define TEST_JALR(back_flag, front_flag, b_flag_ref, f_flag_ref) \
    addu s7, zero, $31; \
    li v0, 0x0; \
    li v1, 0x0; \
    la t0, 1000f; \
    la t1, 3000f; \
    b 2000f; \
    nop; \
1000:; \
    addu a0, ra, zero; \
    li v0, back_flag; \
    jalr t1; \
    nop; \
1001:; \
    b 4000f; \
    nop; \
2000:; \
    jalr t0; \
    nop; \
2001:; \
    b 4000f; \
    nop; \
3000:; \
    addu a1, ra, zero; \
    li v1, front_flag; \
4000:; \
    addu $31, zero, s7; \
    li s5, b_flag_ref; \
    li s6, f_flag_ref; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop; \
    la s5, 1001b; \
    la s6, 2001b; \
    bne a0, s6, inst_error; \
    nop; \
    bne a1, s5, inst_error; \
    nop

/* 44 */
#define TEST_DIV(in_a, in_b, ref_lo, ref_hi) \
    li t0, in_a; \
    li t1, in_b; \
    div zero, t0, t1; \
    mflo s5; \
    mfhi s6; \
    li v0, ref_lo; \
    li v1, ref_hi; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 45 */
#define TEST_DIVU(in_a, in_b, ref_lo, ref_hi) \
    li t0, in_a; \
    li t1, in_b; \
    divu zero, t0, t1; \
    mflo s5; \
    mfhi s6; \
    li v0, ref_lo; \
    li v1, ref_hi; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 46 */
#define TEST_MULT(in_a, in_b, ref_lo, ref_hi) \
    li t0, in_a; \
    li t1, in_b; \
    mult t0, t1; \
    mflo s5; \
    mfhi s6; \
    li v0, ref_lo; \
    li v1, ref_hi; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 47 */
#define TEST_MULTU(in_a, in_b, ref_lo, ref_hi) \
    li t0, in_a; \
    li t1, in_b; \
    multu t0, t1; \
    mflo s5; \
    mfhi s6; \
    li v0, ref_lo; \
    li v1, ref_hi; \
    bne v0, s5, inst_error; \
    nop; \
    bne v1, s6, inst_error; \
    nop

/* 48 */
#define TEST_MFHI(in_a, ref) \
    li t0, in_a; \
    mthi t0; \
    mfhi v0; \
    li s5, ref; \
    bne v0, s5, inst_error; \
    nop

/* 49 */
#define TEST_MFLO(in_a, ref) \
    li t0, in_a; \
    mtlo t0; \
    mflo v0; \
    li s5, ref; \
    bne v0, s5, inst_error; \
    nop

/* 50 */
#define TEST_MTHI(in_a, ref) \
    li t0, in_a; \
    mthi t0; \
    mfhi v0; \
    li s5, ref; \
    bne v0, s5, inst_error; \
    nop

/* 51 */
#define TEST_MTLO(in_a, ref) \
    li t0, in_a; \
    mtlo t0; \
    mflo v0; \
    li s5, ref; \
    bne v0, s5, inst_error; \
    nop

/* 52 */
#define TEST_BGEZ_DS(op, dest, ...) \
    li a0, 0x80000000; \
    bgez a0, 1000f; \
    op  dest , ##__VA_ARGS__; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bgez zero, 2000f; \
    op  s7 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

#define TEST_BGEZ_DS_MD(...) \
    li a0, 0x80000000; \
    li v0, 0; \
    li v1, 0; \
    bgez a0, 1000f; \
   ##__VA_ARGS__; \
    mflo v0; \
    mtlo a0; \
    ##__VA_ARGS__; \
    mflo s6; \
    bne v0, s6, inst_error; \
    nop; \
    mtlo a0; \
    bgez zero, 2000f; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

/* 53 */
#define TEST_BGTZ_DS(op, dest, ...) \
    li a0, 0x80000000; \
    li a1, 0x7fffffff; \
    bgtz a0, 1000f; \
    op  dest, ##__VA_ARGS__; \
    op  s6, ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bgtz a1, 2000f; \
    op  s7, ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

#define TEST_BGTZ_DS_MD(...) \
    li a0, 0x80000000; \
    li a1, 0x7fffffff; \
    li v0, 0; \
    li v1, 0; \
    bgtz a0, 1000f; \
    ##__VA_ARGS__; \
    mflo v0; \
    mtlo a0; \
    ##__VA_ARGS__; \
    mflo s6; \
    bne v0, s6, inst_error; \
    nop; \
    mtlo a0; \
    bgtz a1, 2000f; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

/* 54 */
#define TEST_BLEZ_DS(op, dest, ...) \
    li a0, 0x7fffffff; \
    blez a0, 1000f; \
    op  dest , ##__VA_ARGS__; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    blez zero, 2000f; \
    op  s7 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

#define TEST_BLEZ_DS_MD(...) \
    li a0, 0x7fffffff; \
    li v0, 0; \
    li v1, 0; \
    blez a0, 1000f; \
    ##__VA_ARGS__; \
    mflo v0; \
    mtlo a0; \
    ##__VA_ARGS__; \
    mflo s6; \
    bne v0, s6, inst_error; \
    nop; \
    mtlo a0; \
    blez zero, 2000f; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

/* 55 */
#define TEST_BLTZ_DS(op, dest, ...) \
    li a0, 0x80000000; \
    li a1, 0x7fffffff; \
    bltz a1, 1000f; \
    op  dest , ##__VA_ARGS__; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bltz a0, 2000f; \
    op  s7 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    bne s7, s6, inst_error; \
    nop

#define TEST_BLTZ_DS_MD(...) \
    li a0, 0x80000000; \
    li a1, 0x7fffffff; \
    li v0, 0; \
    li v1, 0; \
    bltz a1, 1000f; \
    ##__VA_ARGS__; \
    mflo v0; \
    mtlo a0; \
    ##__VA_ARGS__; \
    mflo s6; \
    bne v0, s6, inst_error; \
    nop; \
    mtlo a0; \
    bltz a0, 2000f; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

/* 56 */
#define TEST_BLTZAL_DS(op, dest, ...) \
    addu s7, zero, $31; \
    li a0, 0x80000000; \
    li a1, 0x7fffffff; \
    bltzal a1, 1000f; \
    op  dest , ##__VA_ARGS__; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bltzal a0, 2000f; \
    op  s5 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    addu $31, zero, s7; \
    bne s5, s6, inst_error; \
    nop

#define TEST_BLTZAL_DS_MD(...) \
    addu s7, zero, $31; \
    li a0, 0x80000000; \
    li a1, 0x7fffffff; \
    li v0, 0; \
    li v1, 0; \
    bltzal a1, 1000f; \
    ##__VA_ARGS__; \
    mflo v0; \
    mtlo a0; \
    ##__VA_ARGS__; \
    mflo s6; \
    bne v0, s6, inst_error; \
    nop; \
    mtlo a0; \
    bltzal a0, 2000f; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    addu $31, zero, s7; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

/* 57 */
#define TEST_BGEZAL_DS(op, dest, ...) \
    addu s7, zero, $31; \
    li a0, 0x80000000; \
    bgezal a0, 1000f; \
    op  dest , ##__VA_ARGS__; \
    op  s6 , ##__VA_ARGS__; \
    bne dest, s6, inst_error; \
    nop; \
    bgezal zero, 2000f; \
    op  s5 , ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    addu $31, zero, s7; \
    bne s5, s6, inst_error; \
    nop

#define TEST_BGEZAL_DS_MD(...) \
    addu s7, zero, $31; \
    li a0, 0x80000000; \
    li v0, 0; \
    li v1, 0; \
    bgezal a0, 1000f; \
    ##__VA_ARGS__; \
    mflo v0; \
    mtlo a0; \
    ##__VA_ARGS__; \
    mflo s6; \
    bne v0, s6, inst_error; \
    nop; \
    mtlo a0; \
    bgezal zero, 2000f; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    addu $31, zero, s7; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

/* 58 */
#define TEST_JALR_DS(op, dest, ...) \
    addu s7, zero, $31; \
    la  a0, 2000f; \
    op  s6, ##__VA_ARGS__; \
    jalr a0; \
    op  dest, ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    addu $31, zero, s7; \
    bne dest, s6, inst_error; \
    nop

#define TEST_JALR_DS_MD(...) \
    addu s7, zero, $31; \
    la  a0, 2000f; \
    li v0, 0; \
    li v1, 0; \
    ## ##__VA_ARGS__; \
    mflo s6; \
    mtlo a0; \
    jalr a0; \
    ##__VA_ARGS__; \
1000: ; \
    b   inst_error; \
    nop;            \
2000: ; \
    addu $31, zero, s7; \
    mflo v1; \
    bne v1, s6, inst_error; \
    nop

/* 59 */
#define TEST_LB(data, base_addr, offset, offset_align, ref) \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t1, offset_align(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -8; \
    sw a0, offset_align(a0); \
    sw a1, offset_align(a1); \
    lb v0, offset(t0); \
    lw a1, offset_align(a0); \
    lw a0, offset_align(a1); \
    lw a2, offset_align(a1); \
    bne v0, v1, inst_error; \
    nop

/* 60 */
#define TEST_LBU(data, base_addr, offset, offset_align, ref) \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t1, offset_align(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -8; \
    sw a0, offset_align(a0); \
    sw a1, offset_align(a1); \
    lbu v0, offset(t0); \
    lw a1, offset_align(a0); \
    lw a0, offset_align(a1); \
    lw a2, offset_align(a1); \
    bne v0, v1, inst_error; \
    nop

/* 61 */
#define TEST_LH(data, base_addr, offset, offset_align, ref) \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t1, offset_align(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -8; \
    sw a0, offset_align(a0); \
    sw a1, offset_align(a1); \
    lh v0, offset(t0); \
    lw a1, offset_align(a0); \
    lw a0, offset_align(a1); \
    lw a2, offset_align(a1); \
    bne v0, v1, inst_error; \
    nop

/* 62 */
#define TEST_LHU(data, base_addr, offset, offset_align, ref) \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t1, offset_align(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -8; \
    sw a0, offset_align(a0); \
    sw a1, offset_align(a1); \
    lhu v0, offset(t0); \
    lw a1, offset_align(a0); \
    lw a0, offset_align(a1); \
    lw a2, offset_align(a1); \
    bne v0, v1, inst_error; \
    nop

/* 63 */
#define TEST_SB(init_data, data, base_addr, offset, offset_align, ref) \
    LI (t2, init_data); \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t2, offset_align(t0); \
    sb t1, offset(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -4; \
    sw a0, offset_align(a0); \
    sw a1, offset_align(a1); \
    lw v0, offset_align(t0); \
    lw a0, offset_align(a1); \
    lw a1, offset_align(a0); \
    lw a2, offset_align(a1); \
    bne v0, v1, inst_error; \
    nop

/* 64 */
#define TEST_SH(init_data, data, base_addr, offset, offset_align, ref) \
    LI (t2, init_data); \
    LI (t1, data); \
    LI (t0, base_addr); \
    LI (v1, ref); \
    sw t2, offset_align(t0); \
    sh t1, offset(t0); \
    addiu a0, t0, 4; \
    addiu a1, t0, -4; \
    sw a0, offset_align(a0); \
    sw a1, offset_align(a1); \
    lw v0, offset_align(t0); \
    lw a0, offset_align(a1); \
    lw a1, offset_align(a0); \
    lw a2, offset_align(a1); \
    bne v0, v1, inst_error; \
    nop
/*65*/
/*66*/
/*67*/
#define TEST_ADD_OV_PRE(in_a, in_b, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, in_a; \
    li  a1, in_b

/*68*/
#define TEST_ADDI_OV_PRE(in_a, in_b, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, in_b;\
    li  a0, in_a

/*69*/
#define TEST_SUB_OV_PRE(in_a, in_b, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, in_a; \
    li  a1, in_b

/*70*/
#define TEST_LW_ADEL(data, base_addr, offset, offset_align, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, base_addr; \
    li  a1, data; \
    addiu a3, a0, offset; \
    sw  a1, offset_align(a0)

/*71*/
#define TEST_LH_ADEL(data, base_addr, offset, offset_align, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, base_addr; \
    li  a1, data; \
    addiu a3, a0, offset; \
    sw  a1, offset_align(a0)

/*72*/
#define TEST_LHU_ADEL(data, base_addr, offset, offset_align, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, base_addr; \
    li  a1, data; \
    addiu a3, a0, offset; \
    sw  a1, offset_align(a0)

/*73*/
#define TEST_SW_ADES(data, base_addr, offset, offset_align, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, base_addr; \
    li  a1, data; \
    addiu a3, a0, offset; \
    sw  v0, offset_align(a0)

/*74*/
#define TEST_SH_ADES(data, base_addr, offset, offset_align, ref) \
    li  v0, ref; \
    li  v1, ref; \
    li  a0, base_addr; \
    li  a1, data; \
    addiu a3, a0, offset; \
    sw  v0, offset_align(a0)

/*75*/
#define TEST_FT_ADEL(addr) \
    li  s4, addr; \
    li  a3, addr;

/*76*/
#define TEST_RI_EX(inst) \
    .word inst

/*77*/
#define TEST_SOFT_INT_EX(cause_init) \
    li   a3, 0x0040ff01; \
    li   v0, 0xffffffff; \
    li   v1, cause_init; \
    mtc0 zero, c0_count; \
    mtc0 v0, c0_compare; \
	mtc0 a3, c0_status; \
    nop; \
    mtc0 v1, c0_cause; \
    1: b 1b; \
    nop
