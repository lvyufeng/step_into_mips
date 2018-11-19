#ifdef _ABIO32
#define LADDU "addu"
#else
#define LADDU "daddu"
#endif

static unsigned long GUESS_ADDR = ((int)0xbfc00000);
static unsigned long mask = 0xffff;
static unsigned long stride = 4;

int scan()
{
	void *p;
	for(p=0xffffffff90000000;p<0xffffffffa0000000;p=p+4)
	{
		if((((long)p)&0xffff)==0) printf("%x\n", p);
		*(volatile int *)p;
	}

}


int guess(unsigned long addr, unsigned long end)
{
	while(addr<end)
	{
		printf("g%x\n", addr);
		asm volatile(
				".set push;\n"
				".set noreorder;\n"
				".set mips64;\n"
				"1:lw %1,(%2);\n"
				"beqzl  %1,1f;\n"
				"nop;\n"
				"sync;\n"
				LADDU " %0, %5;\n"
				"and %1, %0, %4;\n"
				"beqz %1,2f;\n"
				"nop;\n"
				"b 1b;\n"
				"nop;\n"
				"1:lw %1,(%0);\n"
				"b 1b;\n"
				"nop;\n"
				"2:\n"
				".set pop;\n"
				:"=r"(addr):"r"(0),"r"(GUESS_ADDR),"0"(addr),"r"(mask), "r"(stride)
			    );
	}
}


int guess1(unsigned long addr, unsigned long end)
{
	while(addr<end)
	{
		printf("G%x\n", addr);
		asm volatile(
				".set push;\n"
				".set noreorder;\n"
				".set mips64;\n"
				"1:lw %1,(%2);\n"
				"beqzl  %1,1f;\n"
				"nop;\n"
				"sync;\n"
				LADDU " %0,%5;\n"
				"and %1, %0, %4;\n"
				"beqz %1,2f;\n"
				"nop;\n"
				"b 1b;\n"
				"nop;\n"
				"1:jr %0;\n"
				"nop;\n"
				"2:\n"
				".set pop;\n"
				:"=r"(addr):"r"(0),"r"(GUESS_ADDR),"0"(addr),"r"(mask),"r"(stride)
			    );
	}
}

int testguess(int argc, char **argv)
{
	long from, to, mode;
	from = 0xbf000000;
	to = 0xc0000000;
	mode = 3;
	

	while(*(volatile int *)GUESS_ADDR == 0)
        GUESS_ADDR += 4;
	printf("guess addr %x\n",GUESS_ADDR);
	printf("begin test\n");

//	scan();
        
	if(argc>1) from = strtoul(argv[1],0,0);
	if(argc>2) to = strtoul(argv[2],0,0);
        if(argc>3) mask = strtoul(argv[3],0,0);
        if(argc>4) stride = strtoul(argv[4],0,0);
	if(argc>5) mode = strtoul(argv[5],0,0);

	if(argc>2)
	{
	if(mode&1)
	guess1(from, to);
	if(mode&2)
	guess(from, to);
	}
	else
	{
	if(mode&1)
	guess1(0xffffffffbf000000, 0xffffffffc0000000);
	if(mode&2)
	guess(0xffffffffbf000000, 0xffffffffc0000000);
	if(mode&1)
	guess1(0xffffffff9f000000, 0xffffffffa0000000);
	if(mode&2)
	guess(0xffffffff9f000000, 0xffffffffa0000000);
	}
	return 0;
}

