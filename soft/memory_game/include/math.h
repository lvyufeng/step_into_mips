/* $Id: math.h,v 1.1.1.1 2006/09/14 01:59:06 root Exp $ */
#ifndef _MATH_
#define _MATH_

#ifdef FLOAT
float sin(float x);
float cos(float x);
float tan(float x);
float atan(float x);
float exp(float x);
float log(float x);
float pow(float x);
float sqrt(float x);
#else


double acos(double x);
double acosh(double x);
double asin(double x);
double atan(double x);
double atan2(double y, double x);
double atanh(double x);
double ceil(double x);
double cos(double x);
double cosh(double x);
double exp(double x);
double fabs(double x);
double floor(double x);
double fmod(double x, double y);
double frexp(double x, int *i);
double ldexp(double x, int i);
double log(double x);
double log10(double x);
double modf(double x, double *i);
double pow(double x,double y);
double sin(double x);
double sinh(double x);
double sqrt(double x);
double tan(double x);
double tanh(double x);

#endif


float acosf(float x);
float asinf(float x);
float atan2f(float y, float x);
float atanf(float x);
float ceilf(float x);
float cosf(float x);
float coshf(float x);
float expf(float x);
float fabsf(float x);
float floorf(float x);
float fmodf(float x, float y);
float frexpf(float x, int *i);
float ldexpf(float x, int i);
float log10f(float x);
float logf(float x);
float modff(float x, float *i);
float powf(float x);
float sinf(float x);
float sinhf(float x);
float sqrtf(float x);
float tanf(float x);
float tanhf(float x);

static inline void tgt_fpuenable()
{
#if __mips < 3 || __mips == 32
asm(\
"mfc0 $2,$12;\n" \
"li   $3,0x30000000 #ST0_CU1;\n" \
"or   $2,$3;\n" \
"mtc0 $2,$12;\n" \
"li $2,0x00000000 #FPU_DEFAULT;\n" \
"ctc1 $2,$31;\n" \
:::"$2","$3"
	);
#else
asm(\
"mfc0 $2,$12;\n" \
"li   $3,0x34000000 #ST0_CU1;\n" \
"or   $2,$3;\n" \
"mtc0 $2,$12;\n" \
"li $2,0x00000000 #FPU_DEFAULT;\n" \
"ctc1 $2,$31;\n" \
:::"$2","$3"
	);
#endif
}
#endif /* _MATH_ */

