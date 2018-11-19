int printf(const char *fmt,...)
{
int i;
char c;
void **arg;
void *ap;
int w;
__builtin_va_start(ap,fmt);
arg=ap;
for(i=0;fmt[i];i++)
{
	c=fmt[i];
	if(c=='%')
	{
		w=1;
again:
		switch(fmt[i+1])
		{
			case 's':
				putstring(*arg);
				arg++;
				i++;
				break;
			case 'c':
				putchar((long)*arg);
				arg++;
				i++;
				break;
			case 'u':
				printbase((long)*arg,w,10,0);
				arg++;
				i++;
				break;
			case 'd':
				printbase((long)*arg,w,10,1);
				arg++;
				i++;
				break;
            case 'l':
                printbase((long)*arg,w,10,0);
                arg++;
                i=i+2;
                break;
			case 'o':
				printbase((long)*arg,w,8,0);
				arg++;
				i++;
				break;
			case 'b':
				printbase((long)*arg,w,2,0);
				arg++;
				i++;
				break;
			case 'p':
			case 'x':
				printbase((long)*arg,w,16,0);
				arg++;
				i++;
				break;
			case '%':
				putchar('%');
				i++;
				break;
			case '0':
				i++;
			case '1' ... '9':
				for(w=0;fmt[i+1]>'0' && fmt[i+1]<='9';i++)
				 w=w*10+(fmt[i+1]-'0');
				goto again;
				 break;

			default:
				putchar('%');
				break;
		}

	}
	else{
		if(c=='\n') putchar('\r');
		putchar(c);
	}
}
	return 0;
}
