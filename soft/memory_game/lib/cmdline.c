/*
 * cmdline.c
 *	Use command to do testing, use "help" to get more information.
 *
 *  Created on: 2013-1-10
 *      Author: liming
 */

#include <cmdline.h>


int do_exit();
int do_nothing();
int do_help(int argc, void *argv[]);
int do_d4(int argc, char **argv);
int testguess(int argc, char **argv);

const cmdline_t cmd[] = {
	   {"exit", do_exit, 0, "[exit]", "--logout"},
	   {"help", do_help, 1, "[help <command>]", "--cmd list"},
	   {"guess", testguess, 6,"","guess from to mask stide mode"},
	   {"d4", do_d4, 2,"","d4 addr [count]"},
	   {0, do_nothing, 0, "", ""}
};   //命令名按字母表的顺序


int do_d4(int argc, char **argv)
{
	unsigned int addr;
	int i, num;
	if(argc < 2)
	{
		printf("\nusage: d4 <addr> <num>");
		return 1;
	}
	addr = strtoul(argv[1],0,0);
	if(argc == 2) num = 1;
	else num = strtoul(argv[2],0,0);

	for(i=0; i<num; i++)
	{
		if((i%4) == 0)
			printf("\n0x%08x:\t", addr+i*4);
		printf(" %08x ", *(volatile unsigned int*)(addr+i*4));
	}

	return 0;
}

int do_exit()
{
	return 0;
}
int do_nothing()
{
	return 0;
}
int do_help(int argc, void *argv[])
{
	int i;
	char *s;
	if(argc<2)
	{
		printf("\ncommands:\n\n");
		for(i=0; cmd[i].cmdname; i++)
		{
			printf("\t%s\t%s\t%s\n", cmd[i].cmdname, cmd[i].usage, cmd[i].expression);
		}
	}
	else
	{
		s = (char *)argv[1];
		for(i=0; cmd[i].cmdname; i++)
		{
			if(strcmp(s, cmd[i].cmdname)==0)
			{
				printf("\n\t%s\t%s\t%s\n", cmd[i].cmdname, cmd[i].usage, cmd[i].expression);
				break;
			}
		}
		if(!(cmd[i].cmdname))
		{
			printf("\n\tERROR: undefine command!!!\n");
		}
	}

	return 0;
}

/*The format of cmd is "$xxx xx xx xx". */
int cmdloop(void)
{
	char c;
	char cmdbuffer[CMD_BUFF]={0};
	//int (*op)(int argc, char **argv);
	int (*op)(int argc, void *argv[]);
	int argc;
	char *argv[V_NUM]={0};
	char *cmdptr;
	short cp, i, j, k;
	int history = 11;  //指向help命令
	int history_num = 0;
	char hispara[V_NUM][V_LEN];
	char *history_para[V_NUM];

	while(1)
	{
		printf("\n$ ");
		cp = 0;  //current position

		while(1)   // internal loop
		{
			c = getchar();
			if((c>0x1f)&&(c<0x7f))  //no ctrl_char
			{
				cmdbuffer[cp++] = c;
				putchar(c);
			}
			else if((c == 0x8 || c == 0x7f) && cp) //backspace
			{
				cp--;
				cmdbuffer[cp] = '\0';
				putchar(0x8);
				putchar(0x20);  //This is an interesting way.
				putchar(0x8);
			}
			else if((c==0xa) || (c==0xd))
			{
				break;
			}
		}

		if(cp == 0)
		{
 		 if(!argv[0])
		  continue;
		}
		else
		{
			char *p0;
			char c0, c;
			for(i=0, argc=0, p0=cmdbuffer, c0=0; i<cp; i++)
			{
				if((c = cmdbuffer[i]) == 0x20)  //space
				{
					cmdbuffer[i] = 0;
				}
				else if(c0==0x20)
				{
					argv[argc++] = p0;
					p0 = cmdbuffer+i;
				}

				c0 = c;
			}

                        if(c0!=0x20) argv[argc++] = p0;
			cmdbuffer[i] = 0;
		 }

			if(strcmp(argv[0], cmd[0].cmdname)==0) break;  //exit
			else
			{
				for(k=1; cmd[k].cmdname; k++)
				{
					if(strcmp(argv[0], cmd[k].cmdname)==0)
					{
						op = cmd[k].func;
						op(argc, argv);
						if(cmd[k].repeat)
						{
							history = k;  //current cmd
							history_num = argc;
						}
						else argv[0] = 0;
						break;
					}
				}
				if(!(cmd[k].cmdname))
				{
					printf("\n\tERROR: undefine command!!!\n");
				}
			}
	}
	return 0;
}	
