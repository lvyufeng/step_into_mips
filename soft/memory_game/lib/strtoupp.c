void
strtoupper(char *p)
{
	if(!p)
		return;
	for (; *p; p++)
		*p = toupper (*p);
}
