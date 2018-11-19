#ifndef _ASM_PAGE_H
#define _ASM_PAGE_H
#include <const.h>

#ifdef CONFIG_PAGE_SIZE_16KB
#define PAGE_SHIFT	14
#endif

#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
#endif /* _ASM_PAGE_H */
