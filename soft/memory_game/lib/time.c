#include <time.h>

unsigned long _get_count()
{
    unsigned long _contval;
    asm volatile(
        "lui $25, 0xbfb0\n\t"
        "lw %0,-0x2000($25)\n\t"
        :"=r"(_contval)
        :
        :"$25"
        );
    return  _contval;
}

unsigned long get_count()
{
    return  _get_count();
}

unsigned long clock_gettime(int sel,struct timespec *tmp)
{
    unsigned long n = 0;
    n = _get_count();
    tmp->tv_nsec = n*(NSEC_PER_USEC/CPU_COUNT_PER_US)%NSEC_PER_USEC;
    tmp->tv_usec = (n/CPU_COUNT_PER_US)%USEC_PER_MSEC;
    tmp->tv_msec = (n/CPU_COUNT_PER_US/USEC_PER_MSEC)%MSEC_PER_SEC;
    tmp->tv_sec  = n/CPU_COUNT_PER_US/NSEC_PER_SEC;
    printf("clock ns=%d,sec=%d\n",tmp->tv_nsec,tmp->tv_sec);
    return 0;
}

unsigned long get_clock()
{
    unsigned long n=0;
    n=_get_count();
    return n;
}

unsigned long get_ns(void)
{
    unsigned long n=0;
    n = _get_count();
    n=n*(NSEC_PER_USEC/CPU_COUNT_PER_US);
    return n;
}


unsigned long get_us(void)
{
    unsigned long n=0;
    n = _get_count();
    n=n/CPU_COUNT_PER_US;
    return n;
}
