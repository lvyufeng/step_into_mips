#include <stdlib.h>

char *
strcpy (char *dstp, const char *srcp)
{
	char *dp = dstp;

	if (!dstp)
		return (0);
	*dp = 0;
	if (!srcp)
		return (dstp);

	while ((*dp++ = *srcp++) != 0);
	return (dstp);
}

size_t
strlcpy(char *d, const char *s, size_t l)
{
	size_t len = l;

	if (d == NULL || l == 0)
		return 0;
	*d = 0;
	if (s == NULL)
		return 0;

	while (--len)
		if ((*d++ = *s++) == 0)
			break;
	if (len == 0)
		*d = 0;
	len = l - len;
	return len;
}
