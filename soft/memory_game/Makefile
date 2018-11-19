export LD_PRELOAD =

MEM_DEF= -DMEMSTART=0x80040000 -DMEMSIZE=0x10000

AFLAGS = -O2 -fno-pic -mno-abicalls -fno-builtin -mips1 -I include

export CROSS_COMPILE ?= mipsel-linux-
export MEM_DEF

OBJDIR = obj
GAME_TARGET = ./memory_game/memory_main.o

all:
	mkdir -p $(OBJDIR)
	make generate

libtinyc.a :
	make -C lib $@

generate: inst_data.bin convert
	./convert inst_data.bin $(OBJDIR)/

inst_data.bin: main.elf
	${CROSS_COMPILE}objcopy -O binary -j .text -j .data  $(OBJDIR)/$< $(OBJDIR)/$@ 

main.elf: start.o libtinyc.a bin.lds $(GAME_TARGET)
	${CROSS_COMPILE}ld -g -T bin.lds start.o $(GAME_TARGET) lib/libtinyc.a -o $(OBJDIR)/$@
	${CROSS_COMPILE}objdump -alD $(OBJDIR)/$@ > $(OBJDIR)/test.s

$(GAME_TARGET):
	make -C memory_game

bin.lds: bin.lds.S
	${CROSS_COMPILE}gcc -E -P -Umips -D_LOADER -U_MAIN $(MEM_DEF) $< -o $@

start.o: start.S
	${CROSS_COMPILE}gcc $(AFLAGS) -c $< -nostdinc -nostdlib

convert: convert.c
	gcc -o convert convert.c
clean:
	rm -f *.o *.bin *.elf *.a testbin *.s *.vlog *.coe *.data *.mif
	rm -rf obj
	make -C lib clean
	make -C memory_game clean
reset:
	make clean
	rm -f bin.lds convert

help:
	@echo "################################################################"
	@echo "### help for compiling memory game"
	@echo "################################################################"
	@echo "### options:"
	@echo "###     make      : get compiled result, which is saved in ./obj"
	@echo "###     make clean: remove *.o, *.a, and ./obj"
	@echo "###     make reset: "make clean" and remove convert, bin.lds"
	@echo "###     make help : show help information"
	@echo "###############################################################"

#-include rules.make
