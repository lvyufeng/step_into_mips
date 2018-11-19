/*      $OpenBSD: asm.h,v 1.2 1998/03/16 09:03:02 pefo Exp $	*/

/*
 * Copyright (c) 1992, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Ralph Campbell.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 *	Copyright (C) 1989 Digital Equipment Corporation.
 *	Permission to use, copy, modify, and distribute this software and
 *	its documentation for any purpose and without fee is hereby granted,
 *	provided that the above copyright notice appears in all copies.
 *	Digital Equipment Corporation makes no representations about the
 *	suitability of this software for any purpose.  It is provided "as is"
 *	without express or implied warranty.
 */

#ifndef _MIPS_ASM_H
#define _MIPS_ASM_H

#include <regdef.h>

#ifndef ABICALLS
#define	ABICALLS	.abicalls
#endif

#if defined(ABICALLS) && !defined(_KERNEL)
	ABICALLS
#endif

#define RCSID(x)

/*
 * Define how to access unaligned data word 
 */
#if defined(__MIPSEL__)
#define LWLO    lwl
#define LWHI    lwr
#define	SWLO	swl
#define	SWHI	swr
#else
#if defined(__MIPSEB__)
#define LWLO    lwr
#define LWHI    lwl
#define	SWLO	swr
#define	SWHI	swl
#else
#error "__MIPSEL__ or __MIPSEB__ must be defined"
#endif
#endif

/*
 * Code for setting gp reg if abicalls are used.
 */
#if defined(ABICALLS) && !defined(_KERNEL)
#define	ABISETUP		\
	.set	noreorder;	\
	.cpload	t9;		\
	.set	reorder;
#else
#define	ABISETUP
#endif

/*
 * Define -pg profile entry code.
 */
#if defined(GPROF) || defined(PROF)
#define	MCOUNT			\
	subu 	sp, sp, 32;	\
	.cprestore 16;		\
	sw	ra, 28(sp);	\
	sw	gp, 24(sp);	\
	.set	noat;		\
	.set	noreorder;	\
	move	AT, ra;		\
	jal	_mcount;	\
	subu	sp, sp, 8;	\
	lw	ra, 28(sp);	\
	addu	sp, sp, 32;	\
	.set reorder;		\
	.set	at;
#else
#define	MCOUNT
#endif

/*
 * LEAF(x)
 *
 *	Declare a leaf routine.
 */
#define LEAF(x)			\
	.align	3;		\
	.globl x;		\
	.ent x, 0;		\
x: ;				\
	.frame sp, 0, ra;	\
	ABISETUP		\
	MCOUNT

#define	ALEAF(x)		\
	.globl	x;		\
x:

/*
 * NLEAF(x)
 *
 *	Declare a non-profiled leaf routine.
 */
#define NLEAF(x)		\
	.align	3;		\
	.globl x;		\
	.ent x, 0;		\
x: ;				\
	.frame sp, 0, ra;	\
	ABISETUP

/*
 * NON_LEAF(x)
 *
 *	Declare a non-leaf routine (a routine that makes other C calls).
 */
#define NON_LEAF(x, fsize, retpc) \
	.align	3;		\
	.globl x;		\
	.ent x, 0;		\
x: ;				\
	.frame sp, fsize, retpc; \
	ABISETUP		\
	MCOUNT

/*
 * NNON_LEAF(x)
 *
 *	Declare a non-profiled non-leaf routine
 *	(a routine that makes other C calls).
 */
#define NNON_LEAF(x, fsize, retpc) \
	.align	3;		\
	.globl x;		\
	.ent x, 0;		\
x: ;				\
	.frame sp, fsize, retpc	\
	ABISETUP

/*
 * END(x)
 *
 *	Mark end of a procedure.
 */
#define END(x) \
	.end x

/*
 * Macros to panic and printf from assembly language.
 */
#define PANIC(msg) \
	la	a0, 9f; \
	jal	panic; \
	MSG(msg)

#define	PRINTF(msg) \
	la	a0, 9f; \
	jal	printf; \
	MSG(msg)

#define	MSG(msg) \
	.rdata; \
9:	.asciiz	msg; \
	.text

#define ASMSTR(str) \
	.asciiz str; \
	.align	3

#if (_MIPS_SZPTR == 32)
#define PTR_ADD		add
#define PTR_ADDU	addu
#define PTR_ADDI	addi
#define PTR_ADDIU	addiu
#define PTR_SUB		sub
#define PTR_SUBU	subu
#define PTR_L		lw
#define PTR_S		sw
#define PTR_LA		la
#define PTR_LI		li
#define PTR_SLL		sll
#define PTR_SLLV	sllv
#define PTR_SRL		srl
#define PTR_SRLV	srlv
#define PTR_SRA		sra
#define PTR_SRAV	srav

#define PTR_SCALESHIFT	2

#define PTR		.word
#define PTRSIZE		4
#define PTRLOG		2
#endif

#if (_MIPS_SZPTR == 64)
#define PTR_ADD		dadd
#define PTR_ADDU	daddu
#define PTR_ADDI	daddi
#define PTR_ADDIU	daddiu
#define PTR_SUB		dsub
#define PTR_SUBU	dsubu
#define PTR_L		ld
#define PTR_S		sd
#define PTR_LA		dla
#define PTR_LI		dli
#define PTR_SLL		dsll
#define PTR_SLLV	dsllv
#define PTR_SRL		dsrl
#define PTR_SRLV	dsrlv
#define PTR_SRA		dsra
#define PTR_SRAV	dsrav

#define PTR_SCALESHIFT	3

#define PTR		.dword
#define PTRSIZE		8
#define PTRLOG		3
#endif

#endif /* !_MIPS_ASM_H */
