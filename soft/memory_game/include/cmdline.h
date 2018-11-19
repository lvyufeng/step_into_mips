#ifndef __CMDLINE_H__
#define __CMDLINE_H__
typedef struct cmd_struct {
	const char *cmdname;
	int (*func)(int, void *[]);
	int repeat;
	const char *usage;
	const char *expression;
} cmdline_t;

#define V_NUM	8	//the number of argv
#define V_LEN	15	//the length of argv
#define CMD_BUFF 64
#endif
