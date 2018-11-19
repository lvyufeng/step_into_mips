#ifndef MYREGS_H
#define MYREGS_H
#define IRQF_SHARED		0x00000080
#define SA_SHIRQ		IRQF_SHARED
#define IRQF_TRIGGER_NONE	0x00000000
#define IRQF_TRIGGER_RISING 	0x00000001
#define IRQF_TRIGGER_FALLING 	0x00000002
#define IRQF_TRIGGER_HIGH	0x00000004
#define IRQF_TRIGGER_LOW	0x00000008
#define IRQF_TRIGGER_MASK 	(IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)
#define IRQF_TRIGGER_PROBE	0x00000010
struct sb2f_board_intc_regs
{
	volatile unsigned int int_isr;
	volatile unsigned int int_en;
	volatile unsigned int int_set;
	volatile unsigned int int_clr;
	volatile unsigned int int_pol;
	volatile unsigned int int_edge;
};
static struct sb2f_board_intc_regs volatile *sb2f_board_hw0_icregs = (struct sb2f_board_intc_regs volatile*)0xbfd01040;
struct irq_desc;
typedef void (*irq_flow_handler_t)(unsigned int irq,struct irq_desc *desc);
typedef int  (*irq_handler_t)(void *);
struct irq_chip{
		char *name;
		unsigned int (*startup)(unsigned int irq);
		unsigned int (*shutdown)(unsigned int irq);
		unsigned int (*enable)(unsigned int irq);
		unsigned int (*disable)(unsigned int irq);
		
		
		unsigned int (*ack)(unsigned int irq);
		unsigned int (*mask)(unsigned int irq);
		unsigned int (*mask_ack)(unsigned int irq);
		unsigned int (*unmask)(unsigned int irq);
		unsigned int (*eoi)(unsigned int irq);

		void (*end)(unsigned int irq);
		int (*set_type)(unsigned int irq,unsigned int flow_type);
		};
struct irqaction{
		irq_handler_t handler;
		unsigned long flags;
		const char* name;
		struct irqaction *next;
		int irq;
		void *dev_id;
		};

struct	irq_desc{
		irq_flow_handler_t handle_irq;
		struct irq_chip *chip;
		struct irqaction *action;
		};

static inline int fls(int word)
{
	
	__asm__(".set mips32");
	__asm__("clz %0, %1" : "=r" (word) : "r" (word));
	__asm__(".set mips0");
	return 32-word;
}
static int inline ffs(int word)
{
	if(!word)
		return 0;
	return fls(word & -word);
}
int request_irq(unsigned int irq, irq_handler_t handler, unsigned long irqflags,const char *devname, void *dev_id);
#define IRQ_RETVAL(x)	((x) != 0)
#endif
