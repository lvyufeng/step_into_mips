/*
 *  Format string by inserting blanks.
 */

void
str_fmt(char *p, int size, int fmt)
{
	int n, m, len;

	len = strlen (p);
	switch (fmt) {
	case FMT_RJUST:
		for (n = size - len; n > 0; n--)
			strichr (p, ' ');
		break;
	case FMT_LJUST:
		for (m = size - len; m > 0; m--)
			strcat (p, " ");
		break;
	case FMT_RJUST0:
		for (n = size - len; n > 0; n--)
			strichr (p, '0');
		break;
	case FMT_CENTER:
		m = (size - len) / 2;
		n = size - (len + m);
		for (; m > 0; m--)
			strcat (p, " ");
		for (; n > 0; n--)
			strichr (p, ' ');
		break;
	}
}
