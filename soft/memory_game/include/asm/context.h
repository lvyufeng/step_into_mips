/**************************************************************************
*                                                                         *
*   PROJECT     : MIPS port for uC/OS-II                                  *
*                                                                         *
*   MODULE      : CONTEXT.h                                               *
*                                                                         *
*   AUTHOR      : Michael Anburaj                                         *
*                 URL  : http://geocities.com/michaelanburaj/             *
*                 EMAIL: michaelanburaj@hotmail.com                       *
*                                                                         *
*   PROCESSOR   : MIPS 4Kc (32 bit RISC) - ATLAS board                    *
*                                                                         *
*   TOOL-CHAIN  : SDE & Cygnus                                            *
*                                                                         *
*   DESCRIPTION :                                                         *
*   Context switch macros.                                                *
*                                                                         *
**************************************************************************/


#ifndef __CONTEXT_H__
#define __CONTEXT_H__


/* ********************************************************************* */
/* Module configuration */


/* ********************************************************************* */
/* Interface macro & data definition */

#ifdef __ASSEMBLER__


// push context: at, v0-v1,a0-a3,t0-t9,s0-s7,gp,fp,ra, & pc
#define STORE_REG_RET(Retaddr) \
    .set noat; \
    .set noreorder; \
        subu sp,120; \
        sw ra,0(sp); \
        sw fp,4(sp); \
        sw gp,8(sp); \
        sw t9,12(sp); \
        sw t8,16(sp); \
        sw s7,20(sp); \
        sw s6,24(sp); \
        sw s5,28(sp); \
        sw s4,32(sp); \
        sw s3,36(sp); \
        sw s2,40(sp); \
        sw s1,44(sp); \
        sw s0,48(sp); \
        sw t7,52(sp); \
        sw t6,56(sp); \
        sw t5,60(sp); \
        sw t4,64(sp); \
        sw t3,68(sp); \
        sw t2,72(sp); \
        sw t1,76(sp); \
        sw t0,80(sp); \
        sw a3,84(sp); \
        sw a2,88(sp); \
        sw a1,92(sp); \
        sw a0,96(sp); \
        sw v1,100(sp); \
        sw v0,104(sp); \
        sw AT,108(sp); \
        mfc0 t0,c0_status; \
        sw t0,112(sp); \
        sw Retaddr,116(sp); \
    .set at

// pop context (normal execution): at, v0-v1,a0-a3,t0-t9,s0-s7,gp,fp,ra, & pc
#define RESTORE_REG_RET() \
    .set noat; \
    .set noreorder; \
        lw ra,0(sp); \
        lw fp,4(sp); \
        lw gp,8(sp); \
        lw t9,12(sp); \
        lw t8,16(sp); \
        lw s7,20(sp); \
        lw s6,24(sp); \
        lw s5,28(sp); \
        lw s4,32(sp); \
        lw s3,36(sp); \
        lw s2,40(sp); \
        lw s1,44(sp); \
        lw s0,48(sp); \
        lw t7,52(sp); \
        lw t6,56(sp); \
        lw t5,60(sp); \
        lw t4,64(sp); \
        lw t3,68(sp); \
        lw t2,72(sp); \
        lw t1,76(sp); \
        lw t0,80(sp); \
        lw a3,84(sp); \
        lw a2,88(sp); \
        lw a1,92(sp); \
        lw a0,96(sp); \
        lw v1,100(sp); \
        lw v0,104(sp); \
        lw AT,108(sp); \
        lw k0,112(sp); \
        mtc0 k0,c0_status; \
        lw k0,116(sp); \
        addu sp,120; \
        jr k0; \
        nop; \
    .set at

// pop context: at, v0-v1,a0-a3,t0-t9,s0-s7,gp,fp,ra, & pc
#define RESTORE_REG_ERET() \
    .set noat; \
    .set noreorder; \
        lw ra,0(sp); \
        lw fp,4(sp); \
        lw gp,8(sp); \
        lw t9,12(sp); \
        lw t8,16(sp); \
        lw s7,20(sp); \
        lw s6,24(sp); \
        lw s5,28(sp); \
        lw s4,32(sp); \
        lw s3,36(sp); \
        lw s2,40(sp); \
        lw s1,44(sp); \
        lw s0,48(sp); \
        lw t7,52(sp); \
        lw t6,56(sp); \
        lw t5,60(sp); \
        lw t4,64(sp); \
        lw t3,68(sp); \
        lw t2,72(sp); \
        lw t1,76(sp); \
        lw t0,80(sp); \
        lw a3,84(sp); \
        lw a2,88(sp); \
        lw a1,92(sp); \
        lw a0,96(sp); \
        lw v1,100(sp); \
        lw v0,104(sp); \
        lw AT,108(sp); \
        lw k0,112(sp); \
        mtc0 k0,c0_status; \
        lw k0,116(sp); \
        mtc0 k0,c0_epc; \
        addu sp,120; \
        eret; \
        nop; \
    .set at

#else
struct pt_regs {
	int ra;
	int fp;
	int gp;
	int t9;
	int t8;
	int s7;
	int s6;
	int s5;
	int s4;
	int s3;
	int s2;
	int s1;
	int s0;
	int t7;
	int t6;
	int t5;
	int t4;
	int t3;
	int t2;
	int t1;
	int t0;
	int a3;
	int a2;
	int a1;
	int a0;
	int v1;
	int v0;
	int AT;
	int status;
	int epc;
};
#endif /* _ASSEMBLER_ */


/* ********************************************************************* */
/* Interface function definition */


/* ********************************************************************* */

#ifdef __cplusplus
}
#endif

#endif /*__CONTEXT_H__*/
