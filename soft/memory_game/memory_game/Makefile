CC = mipsel-linux-gcc
LD = mipsel-linux-ld
OBJCOPY = mipsel-linux-objcopy
OBJDUMP = mipsel-linux-objdump
AR = mipsel-linux-ar

AFLAGS= -G 0 -fno-pic -pipe -mno-abicalls -EL -mips1
CFLAGS= -O2 -mno-abicalls -funroll-all-loops -falign-jumps=16 -falign-functions=16 -fgcse-sm -fgcse-las -finline-functions -finline-limit=1000 -msoft-float -EL -march=mips1 -mips1
CFLAGS+= -G8 -I ../include
CFLAGS+= -static

all:link
	echo "job done"
	
SRCS= memory_main.c
HEADERS=soc_io.h
.PHONY:compile link
compile: $(OPATH) $(SRCS) $(HEADERS)
		$(CC) $(CFLAGS) -c $(SRCS)
link:compile
	@echo "link performed along with compile"
.PHONY:clean
clean:
	rm -rf *.o
