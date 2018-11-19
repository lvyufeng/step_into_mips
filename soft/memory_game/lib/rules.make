.S.o:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -c $< -nostdinc -nostdlib
.c.o:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -c $< -nostdinc -nostdlib
.S.o64:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -o $@ -c $< -nostdinc -nostdlib -mabi=64
.c.o64:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -o $@ -c $< -nostdinc -nostdlib -mabi=64
.S.s:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -S -fverbose-asm -o $@ $< -nostdinc -nostdlib
.c.s:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -S -fverbose-asm -o $@  $< -nostdinc -nostdlib
.S.s64:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -S -fverbose-asm -o $@ -c $< -nostdinc -nostdlib -mabi=64
.c.s64:
	${CROSS_COMPILE}gcc -O2 $(CFLAGS) -fno-pic -mno-abicalls -g -DGUEST -I ../include -I .  -S -fverbose-asm -o $@ -c $< -nostdinc -nostdlib -mabi=64
