#include <asm/mipsregs.h>
#include <errno.h>
#include <irq.h>
#include <stdlib.h>

static int no_action(int cpl, void *dev_id)
{
	return 0;
}

static struct irqaction cascade_irqaction = {
	.handler	= no_action,
	.name		= "cascade",
};

unsigned int ack_sb2f_board_irq(unsigned int irq_nr)
{
	//printf("ack_sb2f_board_irq %d\n",irq_nr);
	(sb2f_board_hw0_icregs+(irq_nr>>5))->int_clr |= (1 << (irq_nr & 0x1f));
}

unsigned int disable_sb2f_board_irq(unsigned int irq_nr)
{
	//printf("disable_sb2f_board_irq %d\n",irq_nr);
	(sb2f_board_hw0_icregs+(irq_nr>>5))->int_en &= ~(1 << (irq_nr & 0x1f));
}
unsigned int enable_sb2f_board_irq(unsigned int irq_nr)
{
	//printf("enable_sb2f_board_irq %d\n",irq_nr);
	(sb2f_board_hw0_icregs+(irq_nr>>5))->int_en |= (1 << (irq_nr & 0x1f));
}
int sb2f_board_irq_set_type(unsigned int irq,unsigned int flow_type)
{
	unsigned int irq_nr = irq;
	int mode;	
	
}

struct irq_chip sb2f_board_irq_chip = {
		.name = "SB2F BOARD",
		.ack = ack_sb2f_board_irq,
		.mask = disable_sb2f_board_irq,
		.unmask = enable_sb2f_board_irq,
		.eoi = enable_sb2f_board_irq,
		.set_type = sb2f_board_irq_set_type
					};
struct irq_desc irq_desc[256];
int handle_IRQ_event(unsigned int irq,struct irqaction *action)
{
//	printf("I am in handle_IRQ_EVENT\n");
#ifdef MYOPROFILE
	local_irq_enable();
#endif
	do {
		action->handler(action->dev_id);
		action = action->next;
	}while (action);
#ifdef MYOPROFILE
	local_irq_disable();
#endif
//	printf("I am out handle_IRQ_EVENT\n");
}
void handle_level_irq(unsigned int irq,struct irq_desc *desc)
{
//	printf("i am in handle_level_irq\n");
	struct irqaction *action;
	desc->chip->mask(irq);/*可以清楚原因寄存器*/
	desc->chip->ack(irq);/*可以清除中断状态寄存器*/
	action = desc->action;
	handle_IRQ_event(irq,action);
	desc->chip->unmask(irq);
//	printf("i am out handle_level_irq\n");
}
void generic_handle_irq(unsigned int irq)
{
//	printf("i am in generic_handler_irq\n");
//	CP0_Cause();
	struct irq_desc *desc = irq_desc + irq;
	desc->handle_irq(irq,desc);
//	printf("i am out generic_handler_irq\n");
}
#define do_IRQ(irq) do{	generic_handle_irq(irq);}while(0)

void ls1gp_board_dma_irqdispatch();

void ls1b_board_hw_irqdispatch(int n)
{
	int irq;
	int intstatus;
	intstatus = (sb2f_board_hw0_icregs + n)->int_isr;
	irq = ffs(intstatus);
	if(!irq)
	{
		printf("Unknow interrpt intstatus %x\n",intstatus);
	}
	else if(n == 1 && irq == 11)
	{
		ls1gp_board_dma_irqdispatch();
	}
	else do_IRQ(n*32+irq-1);
}

void __set_irq_handler(unsigned int irq, irq_flow_handler_t handler, int is_chained, const char *name)
{
	struct irq_desc *desc;
	desc = irq_desc + irq;
	desc->handle_irq = handler;
	
}
void default_enable(unsigned int irq)
{
	struct irq_desc *desc = irq_desc + irq;
	desc->chip->unmask(irq);
}
void default_disable(unsigned int irq)
{
	
}
unsigned int default_startup(unsigned int irq)
{
	irq_desc[irq].chip->enable(irq);
	return 0;
}
void irq_chip_set_defaults(struct irq_chip *chip)
{
	if(!chip->enable)
		chip->enable = default_enable;
	if(!chip->disable)
		chip->disable = default_disable;
	if(!chip->startup)
		chip->startup = default_startup;
	if(!chip->shutdown)
		chip->shutdown = chip->disable;
}
int set_irq_chip(unsigned int irq,struct irq_chip *chip)
{
	struct irq_desc *desc;
	desc = irq_desc + irq;
	irq_chip_set_defaults(chip);
	desc->chip = chip;
	return 0;
}
void set_irq_chip_and_handler(unsigned int irq,struct irq_chip *chip,irq_flow_handler_t handle)
{
	set_irq_chip(irq,chip);
	__set_irq_handler(irq, handle, 0, NULL);
}


/*setup dma irq */

struct ls1gp_cop_global_regs
{
	volatile unsigned int control;
	volatile unsigned int rd_inten;
	volatile unsigned int wr_inten;
	volatile unsigned int rd_intisr;		/* offset 0x10*/
	volatile unsigned int wr_intisr;
	unsigned int unused[11];
} ; 

#define LS1GP_BOARD_DMA_IRQ_BASE 168
#define LS1GP_BOARD_DMA_IRQ_COUNT 16

static struct ls1gp_cop_global_regs *ls1gp_cop_global_regs = (void *)0xbc000000;
void ls1gp_board_dma_irqdispatch()
{
	int intstatus;
	int irq;
	intstatus = (ls1gp_cop_global_regs->wr_intisr & 0xff) << 8  |  (ls1gp_cop_global_regs->rd_intisr & 0xff);
	irq=ffs(intstatus);
	if(!irq){
		printf("Unknow dma interrupt status %x \n" , intstatus);
		return; 
	}
	else do_IRQ(LS1GP_BOARD_DMA_IRQ_BASE + irq - 1);
}

void disable_ls1gp_dma_irq(unsigned int irq)
{
	int irq_nr;
	if(irq < LS1GP_BOARD_DMA_IRQ_BASE + 8)
	{
	irq_nr =irq - LS1GP_BOARD_DMA_IRQ_BASE;
	ls1gp_cop_global_regs->rd_inten &= ~(1<<irq_nr);
	}
	else
	{
	irq_nr =irq - LS1GP_BOARD_DMA_IRQ_BASE - 8;
	ls1gp_cop_global_regs->wr_inten &= ~(1<<irq_nr);
	}
}

void enable_ls1gp_dma_irq(unsigned int irq)
{
	int irq_nr;

	if(irq < LS1GP_BOARD_DMA_IRQ_BASE + 8)
	{
	irq_nr =irq - LS1GP_BOARD_DMA_IRQ_BASE;
	printf("rd irq_nr %d\n",irq_nr);
	ls1gp_cop_global_regs->rd_inten |= (1<<irq_nr);
	}
	else
	{
	irq_nr =irq - LS1GP_BOARD_DMA_IRQ_BASE - 8;
	ls1gp_cop_global_regs->wr_inten |= (1<<irq_nr);
	}
}

static void ack_ls1gp_dma_irq(unsigned int irq)
{
	int irq_nr;

	if(irq < LS1GP_BOARD_DMA_IRQ_BASE + 8)
	{
	irq_nr =irq - LS1GP_BOARD_DMA_IRQ_BASE;
	ls1gp_cop_global_regs->rd_intisr = (1<<irq_nr);
	}
	else
	{
	irq_nr =irq - LS1GP_BOARD_DMA_IRQ_BASE - 8;
	ls1gp_cop_global_regs->wr_intisr = (1<<irq_nr);
	}
}

static void end_ls1gp_dma_irq(unsigned int irq)
{
		enable_ls1gp_dma_irq(irq);
}


static struct irq_chip ls1gp_dma_irq_chip = {
	.name = "LS1GP BOARD",
	.ack = ack_ls1gp_dma_irq,
	.mask = disable_ls1gp_dma_irq,
	.unmask = enable_ls1gp_dma_irq,
	.eoi = enable_ls1gp_dma_irq,
	.end = end_ls1gp_dma_irq,
};


void ls1gp_dma_irq_init()
{
	int irq;
	for (irq = LS1GP_BOARD_DMA_IRQ_BASE; irq < LS1GP_BOARD_DMA_IRQ_BASE + LS1GP_BOARD_DMA_IRQ_COUNT; irq++) {
		set_irq_chip_and_handler(irq, &ls1gp_dma_irq_chip, handle_level_irq);
	}

}

void sb2f_board_irq_init()
{
	int i;
	for(i = 0;i <= 159;i++)
	{
		set_irq_chip_and_handler(i,&sb2f_board_irq_chip,handle_level_irq);
	}

}

int setup_irq(unsigned int irq, struct irqaction *newaction)
{
	struct irq_desc *desc = irq_desc + irq;
	struct irqaction *old, **p;
	int shared = 0;
	p = &desc->action;
	old = *p;
	if(old)
	{
		do
		{
			p = &old->next;
			old= *p;
		}while(old);
		shared = 1;
	}
	*p = newaction;
	if(!shared)	
	{
		irq_chip_set_defaults(desc->chip);
		if(newaction->flags & IRQF_TRIGGER_MASK)
			if(desc->chip && desc->chip->set_type)
				desc->chip->set_type(irq,newaction->flags & IRQF_TRIGGER_MASK);
		if(desc->chip->startup)
			desc->chip->startup(irq);
		else
			desc->chip->enable(irq);
	}
	
	return 0;
	
	
}

int request_irq(unsigned int irq, irq_handler_t handler, unsigned long irqflags,const char *devname, void *dev_id)
{
	struct irqaction *action;
	int retval;
	if(!handler)
		return -EINVAL;
	action = malloc(sizeof(struct irqaction));
	if(!action)
		return -ENOMEM;
	action->handler = handler;
	action->flags = irqflags;
	action->next = NULL;
	action->name = devname;
	action->dev_id = dev_id;
	action->irq = irq;
	setup_irq(irq,action);
}

///////interrupt
#define INT_PCI_INTA (1<<6)
#define INT_PCI_INTB (1<<7)
#define INT_PCI_INTC (1<<8)
#define INT_PCI_INTD (1<<9)
#define ST0_IM  0x0000ff00
#define CAUSEF_IP7      ( 1 << 15)
#define CAUSEF_IP6      ( 1 << 14)
#define CAUSEF_IP5      ( 1 << 13)
#define CAUSEF_IP4      ( 1 << 12)                                                                                                                     
#define CAUSEF_IP3      ( 1 << 11)
#define CAUSEF_IP2      ( 1 << 10)
extern struct sb2f_board_intc_regs volatile *sb2f_board_hw0_icregs;
void plat_irq_dispatch(struct pt_regs *regs)
{
        unsigned int cause = read_c0_cause() & ST0_IM;
        unsigned int status = read_c0_status() & ST0_IM;
        unsigned int pending = cause & status;
        if(pending & CAUSEF_IP7)
        {
#ifdef MYOPROFILE
	unsigned long epc;
	extern char _ftext[];
	extern int irqdepth;
	/*only sample in irq*/
#if 1
		if(irqdepth>1)
#endif
		{
		epc = read_c0_epc();
		if(epc>=0x80000000) (*(unsigned int *)(epc-(unsigned long)_ftext+0x84000000))++;
		}
		write_c0_compare(read_c0_count()+MYOPROFILE_TICK);
#else
	static int cnt=0;
		printf("cnt %d\n",cnt++);
		write_c0_compare(read_c0_count()+100000000/100);
#endif
        }
        else if(pending & CAUSEF_IP2)
        {
                ls1b_board_hw_irqdispatch(0);
        }
        else if(pending & CAUSEF_IP3)
        {
                ls1b_board_hw_irqdispatch(1);
        }
        else if(pending & CAUSEF_IP4)
        {
                ls1b_board_hw_irqdispatch(2);
        }
        else if(pending & CAUSEF_IP5)
        {
                ls1b_board_hw_irqdispatch(3);
        }
        else if(pending & CAUSEF_IP6)
        {
                ls1b_board_hw_irqdispatch(4);
        }
        else
        {
                printf("spurious interrupt\n");
        }

}

void init_IRQ()
{
        int i;
#ifdef MYOPROFILE
	memset((void *)0x84000000, 0, 0x200000);
#endif

        for(i = 0;i < 5;i++)
        {
	/* active level setting */
	/* uart, keyboard, and mouse are active high */
	(sb2f_board_hw0_icregs+i)->int_pol = -1; /*active high*/

	/* make all interrupts level triggered */ 
	(sb2f_board_hw0_icregs+i)->int_edge = 0x00000000;
	
	/* mask all interrupts */
	(sb2f_board_hw0_icregs+i)->int_clr = 0xffffffff;

        }

        sb2f_board_irq_init();
	ls1gp_dma_irq_init();

	setup_irq(32+10, &cascade_irqaction);

	clear_c0_status(ST0_IM);
#ifdef MYOPROFILE
	write_c0_compare(MYOPROFILE_TICK);
	write_c0_count(0);
	set_c0_status(0xff01);
#else
	set_c0_status(0x7f01);
#endif
}
