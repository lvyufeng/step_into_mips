#include <stdlib.h>

#define ULONG_MAX 	4294967295UL
#define LONG_MAX 	2147483647L
#define LONG_MIN 	(-LONG_MAX-1)
#define isspace(c) (c==0x20)
#define isdigit(c)	  (((c) >= '0') && ((c) <= '9'))
#define isalpha(c)	( (((c) >= 'A') && ((c) <= 'Z')) || \
			  (((c) >= 'a') && ((c) <= 'z')) )
#define isupper(c)	(c>='A' && c<='Z')

unsigned long
strtoul(const char *nptr,char **endptr,int base)
{
    int c;
    unsigned long result = 0L;
    unsigned long limit;
    int negative = 0;
    int overflow = 0;
    int digit;

    while ((c = *nptr) && isspace(c)) /* skip leading white space */
      nptr++;

    if ((c = *nptr) == '+' || c == '-') { /* handle signs */
	negative = (c == '-');
	nptr++;
    }

    if (base == 0) {		/* determine base if unknown */
	base = 10;
	if (*nptr == '0') {
	    base = 8;
	    nptr++;
	    if ((c = *nptr) == 'x' || c == 'X') {
		base = 16;
		nptr++;
	    }
	}
    } else if (base == 16 && *nptr == '0') {	
	/* discard 0x/0X prefix if hex */
	nptr++;
	if ((c = *nptr == 'x') || c == 'X')
	  nptr++;
    }

    limit = ULONG_MAX / base;	/* ensure no overflow */

    nptr--;			/* convert the number */
    while ((c = *++nptr) != 0) {
	if (isdigit(c))
	  digit = c - '0';
	else if(isalpha(c))
	  digit = c - (isupper(c) ? 'A' : 'a') + 10;
	else
	  break;
	if (digit < 0 || digit >= base)
	  break;
	if (result > limit)
	  overflow = 1;
	if (!overflow) {
	    result = base * result;
	    if (digit > ULONG_MAX - result)
	      overflow = 1;
	    else	
	      result += digit;
	}
    }
    if (negative && !overflow)	/* BIZARRE, but ANSI says we should do this! */
      result = 0L - result;
    if (overflow) {
	//extern int errno;
	//errno = ERANGE;
	result = ULONG_MAX;
    }

    if (endptr != NULL)		/* point at tail */
      *endptr = (char *)nptr;
    return result;
}

