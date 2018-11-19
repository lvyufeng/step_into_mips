void *memcpy(void *s1, const void *s2, size_t n)
{
	const char *f = s2;
	char *t = s1;

	if (f < t) {
		f += n;
		t += n;
		while (n-- > 0)
			*--t = *--f;
	} else
		while (n-- > 0)
			*t++ = *f++;
	return s1;
}
