char *
strncpy(char *dst, const char *src, size_t n)
{
	char *d;

	if (!dst || !src)
		return (dst);
	d = dst;
	for (; *src && n; d++, src++, n--)
		*d = *src;
	while (n--)
		*d++ = '\0';
	return (dst);
}
