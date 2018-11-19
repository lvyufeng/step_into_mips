int 
newprintf (const char *fmt, ...)
{
    int             len;
    va_list	    ap;
    char buf[1024];

    va_start(ap, fmt);
    len = vsprintf (buf, fmt, ap);
    va_end(ap);
    putstring(buf);
    return (len);
}
