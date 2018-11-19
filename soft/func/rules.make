.S.o:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I include -I .  -c $< -nostdinc -nostdlib
.c.o:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I include -I .  -c $< -nostdinc -nostdlib
.S.s:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I include -I .  -S -fverbose-asm -o $@ $< -nostdinc -nostdlib
.c.s:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I include -I .  -S -fverbose-asm -o $@  $< -nostdinc -nostdlib
