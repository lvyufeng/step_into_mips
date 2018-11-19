static char * _getbase __P((char *, int *));
#ifdef HAVE_QUAD
static int _atob __P((unsigned long long *, char *p, int));
#else
static int _atob __P((unsigned long  *, char *, int));
#endif

static char *
_getbase(char *p, int *basep)
{
	if (p[0] == '0') {
		switch (p[1]) {
		case 'x':
			*basep = 16;
			break;
		case 't': case 'n':
			*basep = 10;
			break;
		case 'o':
			*basep = 8;
			break;
		default:
			*basep = 10;
			return (p);
		}
		return (p + 2);
	}
	*basep = 10;
	return (p);
}


/*
 *  _atob(vp,p,base)
 */
static int
#ifdef HAVE_QUAD
_atob (u_quad_t *vp, char *p, int base)
{
	u_quad_t value, v1, v2;
#else
_atob (unsigned long *vp, char *p, int base)
{
	u_long value, v1, v2;
#endif
	char *q, tmp[20];
	int digit;

	if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X')) {
		base = 16;
		p += 2;
	}

	if (base == 16 && (q = strchr (p, '.')) != 0) {
		if (q - p > sizeof(tmp) - 1)
			return (0);

		strncpy (tmp, p, q - p);
		tmp[q - p] = '\0';
		if (!_atob (&v1, tmp, 16))
			return (0);

		q++;
		if (strchr (q, '.'))
			return (0);

		if (!_atob (&v2, q, 16))
			return (0);
		*vp = (v1 << 16) + v2;
		return (1);
	}

	value = *vp = 0;
	for (; *p; p++) {
		if (*p >= '0' && *p <= '9')
			digit = *p - '0';
		else if (*p >= 'a' && *p <= 'f')
			digit = *p - 'a' + 10;
		else if (*p >= 'A' && *p <= 'F')
			digit = *p - 'A' + 10;
		else
			return (0);

		if (digit >= base)
			return (0);
		value *= base;
		value += digit;
	}
	*vp = value;
	return (1);
}

/*
 *  atob(vp,p,base) 
 *      converts p to binary result in vp, rtn 1 on success
 */
int
atob(uint32_t *vp, char *p, int base)
{
#ifdef HAVE_QUAD
	u_quad_t v;
#else
	u_long  v;
#endif

	if (base == 0)
		p = _getbase (p, &base);
	if (_atob (&v, p, base)) {
		*vp = v;
		return (1);
	}
	return (0);
}


#ifdef HAVE_QUAD
/*
 *  llatob(vp,p,base) 
 *      converts p to binary result in vp, rtn 1 on success
 */
int
llatob(u_quad_t *vp, char *p, int base)
{
	if (base == 0)
		p = _getbase (p, &base);
	return _atob(vp, p, base);
}
#endif


/*
 *  char *btoa(dst,value,base) 
 *      converts value to ascii, result in dst
 */
char *
btoa(char *dst, u_int value, int base)
{
	char buf[34], digit;
	int i, j, rem, neg;

	if (value == 0) {
		dst[0] = '0';
		dst[1] = 0;
		return (dst);
	}

	neg = 0;
	if (base == -10) {
		base = 10;
		if (value & (1L << 31)) {
			value = (~value) + 1;
			neg = 1;
		}
	}

	for (i = 0; value != 0; i++) {
		rem = value % base;
		value /= base;
		if (rem >= 0 && rem <= 9)
			digit = rem + '0';
		else if (rem >= 10 && rem <= 36)
			digit = (rem - 10) + 'a';
		buf[i] = digit;
	}

	buf[i] = 0;
	if (neg)
		strcat (buf, "-");

	/* reverse the string */
	for (i = 0, j = strlen (buf) - 1; j >= 0; i++, j--)
		dst[i] = buf[j];
	dst[i] = 0;
	return (dst);
}

#ifdef HAVE_QUAD
/*
 *  char *btoa(dst,value,base) 
 *      converts value to ascii, result in dst
 */
char *
llbtoa(char *dst, u_quad_t value, int base)
{
	char buf[66], digit;
	int i, j, rem, neg;

	if (value == 0) {
		dst[0] = '0';
		dst[1] = 0;
		return (dst);
	}

	neg = 0;
	if (base == -10) {
		base = 10;
		if (value & (1LL << 63)) {
			value = (~value) + 1;
			neg = 1;
		}
	}

	for (i = 0; value != 0; i++) {
		rem = value % base;
		value /= base;
		if (rem >= 0 && rem <= 9)
			digit = rem + '0';
		else if (rem >= 10 && rem <= 36)
			digit = (rem - 10) + 'a';
		buf[i] = digit;
	}

	buf[i] = 0;
	if (neg)
		strcat (buf, "-");

	/* reverse the string */
	for (i = 0, j = strlen (buf) - 1; j >= 0; i++, j--)
		dst[i] = buf[j];
	dst[i] = 0;
	return (dst);
}
#endif

