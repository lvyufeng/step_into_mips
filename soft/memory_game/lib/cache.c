#include <asm/r4kcache.h>
int dcache_size = 0x4000;
int icache_size = 0x4000;
#define cpu_dcache_line_size() 32

void dma_cache_wback_inv(unsigned long addr, unsigned long size)
{
	/*
	 * Either no secondary cache or the available caches don't have the
	 * subset property so we have to flush the primary caches
	 * explicitly
	 */
	if (size >= dcache_size) {
		blast_dcache32();
	} else {
		blast_dcache_range(addr, addr + size);
	}
}


void dma_cache_inv(unsigned long addr, unsigned long size)
{

	if (size >= dcache_size) {
		blast_dcache32();
	} else {
		unsigned long lsize = cpu_dcache_line_size();
		unsigned long almask = ~(lsize - 1);

		cache_op(Hit_Writeback_Inv_D, addr & almask);
		cache_op(Hit_Writeback_Inv_D, (addr + size - 1)  & almask);
		blast_inv_dcache_range(addr, addr + size);
	}
}


void flush_icache_range(unsigned long start, unsigned long end)
{
	if (end - start >= dcache_size) {
		blast_dcache32();
	} else {
		protected_blast_dcache_range(start, end);
	}

	if (end - start > icache_size)
		blast_icache32();
	else
		protected_blast_icache_range(start, end);
}
