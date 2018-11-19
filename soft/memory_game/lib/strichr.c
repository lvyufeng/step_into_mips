#include <stdlib.h>

char *
strichr(char *p, int c)
{
	char *t;

	if (p != NULL) {
		for(t = p; *t; t++);
		for (; t >= p; t--) {
			*(t + 1) = *t;
		}
		*p = c;
	}
	return (p);
}
