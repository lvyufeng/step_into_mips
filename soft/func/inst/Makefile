srcs = $(wildcard *.S)
objs = $(patsubst %.S, %.o, $(srcs))

$(TOPDIR)/libinst.a: $(objs)
	$(CROSS_COMPILE)$(AR) -cr  $@ $?

clean:
	rm -f *.o *.a *.s

#print:
#	@echo $(srcs)
#	@echo $(objs)

-include $(TOPDIR)/rules.make
