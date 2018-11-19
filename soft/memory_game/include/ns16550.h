/*	$Id: ns16550.h,v 1.1.1.1 2006/09/14 01:59:08 root Exp $ */

/*
 * Copyright (c) 2000-2002 Opsycon AB  (www.opsycon.se)
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
 *	This product includes software developed by Opsycon AB.
 * 4. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 */

/*
 * NS16550 UART registers
 */
#ifndef __NS16550_H_
#define __NS16550_H_

#define NS16550_CHANA	PHYS_TO_K1(UART0_BASE)
#define NS16550_CHANB	PHYS_TO_K1(UART1_BASE)

#if (!defined(__LANGUAGE_ASSEMBLY) && !defined(_LOCORE))

#ifndef nsreg
#ifndef USE_SM502_UART0
#define nsreg(x)	unsigned char x
#else
#define	nsreg(x)	unsigned int  x
#endif
#endif

typedef struct {
    nsreg(data);	/* data register (R/W) */
    nsreg(ier);		/* interrupt enable (W) */
    nsreg(iir);		/* interrupt identification (R) */
#define	fifo	iir	/* 16550 fifo control (W) */
    nsreg(cfcr);	/* line control register (R/W) */
    nsreg(mcr);		/* modem control register (R/W) */
    nsreg(lsr);		/* line status register (R/W) */
    nsreg(msr);		/* modem status register (R/W) */
    nsreg(scr);		/* scratch register (R/W) */
} ns16550dev;

extern int ns16550 __P((int, struct DevEntry *, unsigned long, int));

#else

/*
 * Standard speeds, make these available for start.S et al.
 */
#define B0      0
#define B50     50
#define B75     75
#define B110    110
#define B134    134
#define B150    150
#define B200    200
#define B300    300
#define B600    600
#define B1200   1200
#define B1800   1800
#define B2400   2400
#define B4800   4800
#define B9600   9600
#define B19200  19200
#define B38400  38400
#define B7200   7200
#define B14400  14400
#define B28800  28800
#define B57600  57600
#define B76800  76800
#define B115200 115200
#define B230400 230400

#endif /* __LANGUAGE_ASSEMBLY */

#ifndef NSREG
#define NSREG(x)	x
#endif

#define	NS16550_DATA	0
#define	NS16550_IER	1
#define	NS16550_IIR	2
#define	NS16550_FIFO	2
#define	NS16550_CFCR	3
#define	NS16550_MCR	4
#define	NS16550_LSR	5
#define	NS16550_MSR	6	
#define	NS16550_SCR	7


/* interrupt enable register */
#define	IER_ERXRDY	0x1	/* int on rx ready */
#define	IER_ETXRDY	0x2	/* int on tx ready */
#define	IER_ERLS	0x4	/* int on line status change */
#define	IER_EMSC	0x8	/* int on modem status change */

/* interrupt identification register */
#define	IIR_IMASK	0xf	/* mask */
#define	IIR_RXTOUT	0xc	/* receive timeout */
#define	IIR_RLS		0x6	/* receive line status */
#define	IIR_RXRDY	0x4	/* receive ready */
#define	IIR_TXRDY	0x2	/* transmit ready */
#define	IIR_NOPEND	0x1	/* nothing */
#define	IIR_MLSC	0x0	/* modem status */
#define	IIR_FIFO_MASK	0xc0	/* set if FIFOs are enabled */

/* fifo control register */
#define	FIFO_ENABLE	0x01	/* enable fifo */
#define	FIFO_RCV_RST	0x02	/* reset receive fifo */
#define	FIFO_XMT_RST	0x04	/* reset transmit fifo */
#define	FIFO_DMA_MODE	0x08	/* enable dma mode */
#define	FIFO_TRIGGER_1	0x00	/* trigger at 1 char */
#define	FIFO_TRIGGER_4	0x40	/* trigger at 4 chars */
#define	FIFO_TRIGGER_8	0x80	/* trigger at 8 chars */
#define	FIFO_TRIGGER_14	0xc0	/* trigger at 14 chars */

/* character format control register */
#define	CFCR_DLAB	0x80	/* divisor latch */
#define	CFCR_SBREAK	0x40	/* send break */
#define	CFCR_PZERO	0x30	/* zero parity */
#define	CFCR_PONE	0x20	/* one parity */
#define	CFCR_PEVEN	0x10	/* even parity */
#define	CFCR_PODD	0x00	/* odd parity */
#define	CFCR_PENAB	0x08	/* parity enable */
#define	CFCR_STOPB	0x04	/* 2 stop bits */
#define	CFCR_8BITS	0x03	/* 8 data bits */
#define	CFCR_7BITS	0x02	/* 7 data bits */
#define	CFCR_6BITS	0x01	/* 6 data bits */
#define	CFCR_5BITS	0x00	/* 5 data bits */

/* modem control register */
#define	MCR_LOOPBACK	0x10	/* loopback */
#define	MCR_IENABLE	0x08	/* output 2 = int enable */
#define	MCR_DRS		0x04	/* output 1 = xxx */
#define	MCR_RTS		0x02	/* enable RTS */
#define	MCR_DTR		0x01	/* enable DTR */

/* line status register */
#define	LSR_RCV_FIFO	0x80	/* error in receive fifo */
#define	LSR_TSRE	0x40	/* transmitter empty */
#define	LSR_TXRDY	0x20	/* transmitter ready */
#define	LSR_BI		0x10	/* break detected */
#define	LSR_FE		0x08	/* framing error */
#define	LSR_PE		0x04	/* parity error */
#define	LSR_OE		0x02	/* overrun error */
#define	LSR_RXRDY	0x01	/* receiver ready */
#define	LSR_RCV_MASK	0x1f

/* modem status register */
#define	MSR_DCD		0x80	/* DCD active */
#define	MSR_RI		0x40	/* RI  active */
#define	MSR_DSR		0x20	/* DSR active */
#define	MSR_CTS		0x10	/* CTS active */
#define	MSR_DDCD	0x08    /* DCD changed */
#define	MSR_TERI	0x04    /* RI  changed */
#define	MSR_DDSR	0x02    /* DSR changed */
#define	MSR_DCTS	0x01    /* CTS changed */
#endif

