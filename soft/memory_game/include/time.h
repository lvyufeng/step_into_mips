#ifndef _TIME_H_H
#define _TIME_H_H
typedef unsigned long _clock_t;
typedef unsigned long clock_t;
#define MSEC_PER_SEC 1000L
#define USEC_PER_MSEC 1000L
#define NSEC_PER_USEC 1000L
#define NSEC_PER_MSEC 1000000L
#define USEC_PER_SEC 1000000L
#define NSEC_PER_SEC 1000000000L
#define FSEC_PER_SEC 1000000000000000LL

struct tms{
	_clock_t tms_utime;
	_clock_t tms_stime;
	_clock_t tms_cutime;
	_clock_t tms_cstime;
};

struct tm{
	int tm_sec;
	int tm_min;
	int tm_hour;
	int tm_mday;
	int tm_mon;
	int tm_year;
	int tm_wday;
	int tm_yday;
};

struct timespec{
	_clock_t tv_sec;
	_clock_t tv_nsec;
	_clock_t tv_usec;
	_clock_t tv_msec;
};

struct timeval{
	_clock_t tv_sec;
	_clock_t tv_nsec;
	_clock_t tv_usec;
	_clock_t tv_msec;
};

unsigned long get_count();
#endif
