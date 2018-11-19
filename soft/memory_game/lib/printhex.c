int printhex(long v,int w)
{
	int i;
	int c;
	for(i=4*(w-1);i>=0;i-=4)
	{
		c=(v>>i)&0xf;
		putchar((c<=9)?c+'0':c-0xa+'a');
	}
	return 0;
}
