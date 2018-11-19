/*
 *  sprintf(buf,fmt,va_alist) send formatted string to buf
 */
int 
sprintf (char *buf, const char *fmt, ...)
{
    int             n;
    va_list ap;

    va_start(ap, fmt);
    n = vsprintf (buf, fmt, ap);
    va_end(ap);
    return (n);
}
int
snprintf (char *buf, size_t maxlen, const char *fmt, ...)
{
    int             n;
    va_list ap;

    va_start(ap, fmt);
    n = vsprintf (buf, fmt, ap);
    va_end(ap);
    return (n);
}
