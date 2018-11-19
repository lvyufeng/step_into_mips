OUTPUT_ARCH(mips)
ENTRY(_start)
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  . = 0xbfc00000;
  .text      : 
  {
    _ftext = . ;
    *(.text)
    rodata_end = .;
  } =0
  _etext = .;
  PROVIDE (etext = .);
  .fini      : { *(.fini)    } =0
  .data    : AT(rodata_end)
  {
    *(.rodata*)
    *(.reginfo)
    *(.init)
    *(.stub)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    _fdata = . ;
    _stack = _fdata + MEMSIZE -32;
    *(.data)
    *(.data*) 
                __CTOR_LIST__ = .;
                LONG((__CTOR_END__ - __CTOR_LIST__) / 4 - 2)
               *(.ctors)
                LONG(0)
                __CTOR_END__ = .;
                __DTOR_LIST__ = .;
                LONG((__DTOR_END__ - __DTOR_LIST__) / 4 - 2)
               *(.dtors)
                LONG(0)
                __DTOR_END__ = .;
  _gp = ALIGN(16) + 0x7ff0;
    *(.got.plt) *(.got)
  /* We want the small data sections together, so single-instruction offsets
     can access them all, and initialized data all before uninitialized, so
     we can shorten the on-disk segment size.  */
  *(.sdata) 
   *(.lit8) 
   *(.lit4) 
}
  _edata  =  .;
  PROVIDE (edata = .);

  data_size = SIZEOF(.data);
  data_load_start = LOADADDR(.data);
  __bss_start = .;
  _fbss = .;
  .sbss      : { *(.sbss) *(.scommon) }
  .bss       :
  {
   *(.dynbss)
   *(.bss)
   *(COMMON)
  }
  . = ALIGN(8);
  _end = . ;
  PROVIDE (end = .);

   . = ALIGN(32);

  .bigdata : { *(.bigdata) }

   . = ALIGN(256);
  _heap = . ;
  /* These are needed for ELF backends which have not yet been
     converted to the new style linker.  */
  .stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  /* DWARF debug sections.
     Symbols in the .debug DWARF section are relative to the beginning of the
     section so we begin .debug at 0.  It's not clear yet what needs to happen
     for the others.   */
  .debug          0 : { *(.debug) }
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  .line           0 : { *(.line) }
  /* These must appear regardless of  .  */
  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
}
