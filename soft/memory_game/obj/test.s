
obj/main.elf:     file format elf32-tradlittlemips
obj/main.elf


Disassembly of section .text:

bfc00000 <_ftext>:
_ftext():
bfc00000:	3c1bbfb0 	lui	k1,0xbfb0
bfc00004:	af608ffc 	sw	zero,-28676(k1)
bfc00008:	af608ffc 	sw	zero,-28676(k1)
bfc0000c:	af60fff8 	sw	zero,-8(k1)
bfc00010:	af608ffc 	sw	zero,-28676(k1)
bfc00014:	af608ffc 	sw	zero,-28676(k1)
bfc00018:	8f608ffc 	lw	zero,-28676(k1)
bfc0001c:	8f7bfff8 	lw	k1,-8(k1)
bfc00020:	3c1bbfb0 	lui	k1,0xbfb0
bfc00024:	af608ffc 	sw	zero,-28676(k1)
bfc00028:	af608ffc 	sw	zero,-28676(k1)
bfc0002c:	af60fffc 	sw	zero,-4(k1)
bfc00030:	af608ffc 	sw	zero,-28676(k1)
bfc00034:	af608ffc 	sw	zero,-28676(k1)
bfc00038:	8f608ffc 	lw	zero,-28676(k1)
bfc0003c:	8f7bfffc 	lw	k1,-4(k1)
bfc00040:	3c0a0040 	lui	t2,0x40
bfc00044:	408a6000 	mtc0	t2,c0_sr
bfc00048:	00000000 	nop
bfc0004c:	40806800 	mtc0	zero,c0_cause
bfc00050:	3c1dbfc1 	lui	sp,0xbfc1
bfc00054:	27bd2198 	addiu	sp,sp,8600
bfc00058:	3c1cbfc1 	lui	gp,0xbfc1
bfc0005c:	279ca1c0 	addiu	gp,gp,-24128
bfc00060:	3c09bfc0 	lui	t1,0xbfc0
bfc00064:	25291110 	addiu	t1,t1,4368
bfc00068:	3c0a2000 	lui	t2,0x2000
bfc0006c:	012ac823 	subu	t9,t1,t2
bfc00070:	03200008 	jr	t9
bfc00074:	00000000 	nop
	...
bfc00380:	1000ffff 	b	bfc00380 <_ftext+0x380>
bfc00384:	00000000 	nop
	...

bfc00390 <getUserPress>:
getUserPress():
bfc00390:	3c02bfaf 	lui	v0,0xbfaf
bfc00394:	27bdfff8 	addiu	sp,sp,-8
bfc00398:	3444f024 	ori	a0,v0,0xf024
bfc0039c:	8c870000 	lw	a3,0(a0)
bfc003a0:	00000000 	nop
bfc003a4:	30e6f000 	andi	a2,a3,0xf000
bfc003a8:	00062b02 	srl	a1,a2,0xc
bfc003ac:	afa50000 	sw	a1,0(sp)
bfc003b0:	8fa30000 	lw	v1,0(sp)
bfc003b4:	00000000 	nop
bfc003b8:	14600040 	bnez	v1,bfc004bc <getUserPress+0x12c>
bfc003bc:	00000000 	nop
bfc003c0:	8c860000 	lw	a2,0(a0)
bfc003c4:	00000000 	nop
bfc003c8:	30c5f000 	andi	a1,a2,0xf000
bfc003cc:	00051b02 	srl	v1,a1,0xc
bfc003d0:	afa30000 	sw	v1,0(sp)
bfc003d4:	8fa20000 	lw	v0,0(sp)
bfc003d8:	00000000 	nop
bfc003dc:	14400037 	bnez	v0,bfc004bc <getUserPress+0x12c>
bfc003e0:	00000000 	nop
bfc003e4:	8c8a0000 	lw	t2,0(a0)
bfc003e8:	00000000 	nop
bfc003ec:	3149f000 	andi	t1,t2,0xf000
bfc003f0:	00094302 	srl	t0,t1,0xc
bfc003f4:	afa80000 	sw	t0,0(sp)
bfc003f8:	8fa70000 	lw	a3,0(sp)
bfc003fc:	00000000 	nop
bfc00400:	14e0002e 	bnez	a3,bfc004bc <getUserPress+0x12c>
bfc00404:	00000000 	nop
bfc00408:	8c8e0000 	lw	t6,0(a0)
bfc0040c:	00000000 	nop
bfc00410:	31cdf000 	andi	t5,t6,0xf000
bfc00414:	000d6302 	srl	t4,t5,0xc
bfc00418:	afac0000 	sw	t4,0(sp)
bfc0041c:	8fab0000 	lw	t3,0(sp)
bfc00420:	00000000 	nop
bfc00424:	15600025 	bnez	t3,bfc004bc <getUserPress+0x12c>
bfc00428:	00000000 	nop
bfc0042c:	8c820000 	lw	v0,0(a0)
bfc00430:	00000000 	nop
bfc00434:	3059f000 	andi	t9,v0,0xf000
bfc00438:	0019c302 	srl	t8,t9,0xc
bfc0043c:	afb80000 	sw	t8,0(sp)
bfc00440:	8faf0000 	lw	t7,0(sp)
bfc00444:	00000000 	nop
bfc00448:	15e0001c 	bnez	t7,bfc004bc <getUserPress+0x12c>
bfc0044c:	00000000 	nop
bfc00450:	8c870000 	lw	a3,0(a0)
bfc00454:	00000000 	nop
bfc00458:	30e6f000 	andi	a2,a3,0xf000
bfc0045c:	00062b02 	srl	a1,a2,0xc
bfc00460:	afa50000 	sw	a1,0(sp)
bfc00464:	8fa30000 	lw	v1,0(sp)
bfc00468:	00000000 	nop
bfc0046c:	14600013 	bnez	v1,bfc004bc <getUserPress+0x12c>
bfc00470:	00000000 	nop
bfc00474:	8c8b0000 	lw	t3,0(a0)
bfc00478:	00000000 	nop
bfc0047c:	316af000 	andi	t2,t3,0xf000
bfc00480:	000a4b02 	srl	t1,t2,0xc
bfc00484:	afa90000 	sw	t1,0(sp)
bfc00488:	8fa80000 	lw	t0,0(sp)
bfc0048c:	00000000 	nop
bfc00490:	1500000a 	bnez	t0,bfc004bc <getUserPress+0x12c>
bfc00494:	00000000 	nop
bfc00498:	8c8f0000 	lw	t7,0(a0)
bfc0049c:	00000000 	nop
bfc004a0:	31eef000 	andi	t6,t7,0xf000
bfc004a4:	000e6b02 	srl	t5,t6,0xc
bfc004a8:	afad0000 	sw	t5,0(sp)
bfc004ac:	8fac0000 	lw	t4,0(sp)
bfc004b0:	00000000 	nop
bfc004b4:	1180ffb9 	beqz	t4,bfc0039c <getUserPress+0xc>
bfc004b8:	00000000 	nop
bfc004bc:	8fac0000 	lw	t4,0(sp)
bfc004c0:	27bd0008 	addiu	sp,sp,8
bfc004c4:	31990001 	andi	t9,t4,0x1
bfc004c8:	000cc0c3 	sra	t8,t4,0x3
bfc004cc:	001970c0 	sll	t6,t9,0x3
bfc004d0:	330f0001 	andi	t7,t8,0x1
bfc004d4:	000c6842 	srl	t5,t4,0x1
bfc004d8:	01cf5025 	or	t2,t6,t7
bfc004dc:	31ab0002 	andi	t3,t5,0x2
bfc004e0:	000c4840 	sll	t1,t4,0x1
bfc004e4:	014b4025 	or	t0,t2,t3
bfc004e8:	31240004 	andi	a0,t1,0x4
bfc004ec:	03e00008 	jr	ra
bfc004f0:	01041025 	or	v0,t0,a0
	...

bfc00500 <getUserRelease>:
getUserRelease():
bfc00500:	3c02bfaf 	lui	v0,0xbfaf
bfc00504:	27bdfff8 	addiu	sp,sp,-8
bfc00508:	3444f024 	ori	a0,v0,0xf024
bfc0050c:	8c870000 	lw	a3,0(a0)
bfc00510:	00000000 	nop
bfc00514:	30e6f000 	andi	a2,a3,0xf000
bfc00518:	00062b02 	srl	a1,a2,0xc
bfc0051c:	afa50000 	sw	a1,0(sp)
bfc00520:	8fa30000 	lw	v1,0(sp)
bfc00524:	00000000 	nop
bfc00528:	10600040 	beqz	v1,bfc0062c <getUserRelease+0x12c>
bfc0052c:	00000000 	nop
bfc00530:	8c8b0000 	lw	t3,0(a0)
bfc00534:	00000000 	nop
bfc00538:	316af000 	andi	t2,t3,0xf000
bfc0053c:	000a4b02 	srl	t1,t2,0xc
bfc00540:	afa90000 	sw	t1,0(sp)
bfc00544:	8fa80000 	lw	t0,0(sp)
bfc00548:	00000000 	nop
bfc0054c:	11000037 	beqz	t0,bfc0062c <getUserRelease+0x12c>
bfc00550:	00000000 	nop
bfc00554:	8c8f0000 	lw	t7,0(a0)
bfc00558:	00000000 	nop
bfc0055c:	31eef000 	andi	t6,t7,0xf000
bfc00560:	000e6b02 	srl	t5,t6,0xc
bfc00564:	afad0000 	sw	t5,0(sp)
bfc00568:	8fac0000 	lw	t4,0(sp)
bfc0056c:	00000000 	nop
bfc00570:	1180002e 	beqz	t4,bfc0062c <getUserRelease+0x12c>
bfc00574:	00000000 	nop
bfc00578:	8c830000 	lw	v1,0(a0)
bfc0057c:	00000000 	nop
bfc00580:	3062f000 	andi	v0,v1,0xf000
bfc00584:	0002cb02 	srl	t9,v0,0xc
bfc00588:	afb90000 	sw	t9,0(sp)
bfc0058c:	8fb80000 	lw	t8,0(sp)
bfc00590:	00000000 	nop
bfc00594:	13000025 	beqz	t8,bfc0062c <getUserRelease+0x12c>
bfc00598:	00000000 	nop
bfc0059c:	8c880000 	lw	t0,0(a0)
bfc005a0:	00000000 	nop
bfc005a4:	3107f000 	andi	a3,t0,0xf000
bfc005a8:	00073302 	srl	a2,a3,0xc
bfc005ac:	afa60000 	sw	a2,0(sp)
bfc005b0:	8fa50000 	lw	a1,0(sp)
bfc005b4:	00000000 	nop
bfc005b8:	10a0001c 	beqz	a1,bfc0062c <getUserRelease+0x12c>
bfc005bc:	00000000 	nop
bfc005c0:	8c8c0000 	lw	t4,0(a0)
bfc005c4:	00000000 	nop
bfc005c8:	318bf000 	andi	t3,t4,0xf000
bfc005cc:	000b5302 	srl	t2,t3,0xc
bfc005d0:	afaa0000 	sw	t2,0(sp)
bfc005d4:	8fa90000 	lw	t1,0(sp)
bfc005d8:	00000000 	nop
bfc005dc:	11200013 	beqz	t1,bfc0062c <getUserRelease+0x12c>
bfc005e0:	00000000 	nop
bfc005e4:	8c980000 	lw	t8,0(a0)
bfc005e8:	00000000 	nop
bfc005ec:	330ff000 	andi	t7,t8,0xf000
bfc005f0:	000f7302 	srl	t6,t7,0xc
bfc005f4:	afae0000 	sw	t6,0(sp)
bfc005f8:	8fad0000 	lw	t5,0(sp)
bfc005fc:	00000000 	nop
bfc00600:	11a0000a 	beqz	t5,bfc0062c <getUserRelease+0x12c>
bfc00604:	00000000 	nop
bfc00608:	8c850000 	lw	a1,0(a0)
bfc0060c:	00000000 	nop
bfc00610:	30a3f000 	andi	v1,a1,0xf000
bfc00614:	00031302 	srl	v0,v1,0xc
bfc00618:	afa20000 	sw	v0,0(sp)
bfc0061c:	8fb90000 	lw	t9,0(sp)
bfc00620:	00000000 	nop
bfc00624:	1720ffb9 	bnez	t9,bfc0050c <getUserRelease+0xc>
bfc00628:	00000000 	nop
bfc0062c:	03e00008 	jr	ra
bfc00630:	27bd0008 	addiu	sp,sp,8
	...

bfc00640 <my_rand>:
my_rand():
bfc00640:	8f868010 	lw	a2,-32752(gp)
bfc00644:	3c0741c6 	lui	a3,0x41c6
bfc00648:	34e54e6d 	ori	a1,a3,0x4e6d
bfc0064c:	00c50018 	mult	a2,a1
bfc00650:	00002012 	mflo	a0
bfc00654:	24833039 	addiu	v1,a0,12345
bfc00658:	00031402 	srl	v0,v1,0x10
bfc0065c:	af838010 	sw	v1,-32752(gp)
bfc00660:	03e00008 	jr	ra
bfc00664:	30427fff 	andi	v0,v0,0x7fff
	...

bfc00670 <my_srand>:
my_srand():
bfc00670:	03e00008 	jr	ra
bfc00674:	af848010 	sw	a0,-32752(gp)
	...

bfc00680 <delay>:
delay():
bfc00680:	00043880 	sll	a3,a0,0x2
bfc00684:	000431c0 	sll	a2,a0,0x7
bfc00688:	00c72823 	subu	a1,a2,a3
bfc0068c:	00a41821 	addu	v1,a1,a0
bfc00690:	3c04bfaf 	lui	a0,0xbfaf
bfc00694:	27bdffe8 	addiu	sp,sp,-24
bfc00698:	3482e000 	ori	v0,a0,0xe000
bfc0069c:	afb00010 	sw	s0,16(sp)
bfc006a0:	afbf0014 	sw	ra,20(sp)
bfc006a4:	ac400000 	sw	zero,0(v0)
bfc006a8:	000380c0 	sll	s0,v1,0x3
bfc006ac:	0ff006bb 	jal	bfc01aec <get_us>
bfc006b0:	00000000 	nop
bfc006b4:	0050402a 	slt	t0,v0,s0
bfc006b8:	11000024 	beqz	t0,bfc0074c <delay+0xcc>
bfc006bc:	00000000 	nop
bfc006c0:	0ff006bb 	jal	bfc01aec <get_us>
bfc006c4:	00000000 	nop
bfc006c8:	0050482a 	slt	t1,v0,s0
bfc006cc:	1120001f 	beqz	t1,bfc0074c <delay+0xcc>
bfc006d0:	00000000 	nop
bfc006d4:	0ff006bb 	jal	bfc01aec <get_us>
bfc006d8:	00000000 	nop
bfc006dc:	0050502a 	slt	t2,v0,s0
bfc006e0:	1140001a 	beqz	t2,bfc0074c <delay+0xcc>
bfc006e4:	00000000 	nop
bfc006e8:	0ff006bb 	jal	bfc01aec <get_us>
bfc006ec:	00000000 	nop
bfc006f0:	0050582a 	slt	t3,v0,s0
bfc006f4:	11600015 	beqz	t3,bfc0074c <delay+0xcc>
bfc006f8:	00000000 	nop
bfc006fc:	0ff006bb 	jal	bfc01aec <get_us>
bfc00700:	00000000 	nop
bfc00704:	0050602a 	slt	t4,v0,s0
bfc00708:	11800010 	beqz	t4,bfc0074c <delay+0xcc>
bfc0070c:	00000000 	nop
bfc00710:	0ff006bb 	jal	bfc01aec <get_us>
bfc00714:	00000000 	nop
bfc00718:	0050682a 	slt	t5,v0,s0
bfc0071c:	11a0000b 	beqz	t5,bfc0074c <delay+0xcc>
bfc00720:	00000000 	nop
bfc00724:	0ff006bb 	jal	bfc01aec <get_us>
bfc00728:	00000000 	nop
bfc0072c:	0050702a 	slt	t6,v0,s0
bfc00730:	11c00006 	beqz	t6,bfc0074c <delay+0xcc>
bfc00734:	00000000 	nop
bfc00738:	0ff006bb 	jal	bfc01aec <get_us>
bfc0073c:	00000000 	nop
bfc00740:	0050782a 	slt	t7,v0,s0
bfc00744:	15e0ffd9 	bnez	t7,bfc006ac <delay+0x2c>
bfc00748:	00000000 	nop
bfc0074c:	8fbf0014 	lw	ra,20(sp)
bfc00750:	8fb00010 	lw	s0,16(sp)
bfc00754:	03e00008 	jr	ra
bfc00758:	27bd0018 	addiu	sp,sp,24
bfc0075c:	00000000 	nop

bfc00760 <generateRandomPattern>:
generateRandomPattern():
bfc00760:	27bdfff8 	addiu	sp,sp,-8
bfc00764:	afa00000 	sw	zero,0(sp)
bfc00768:	8fa30000 	lw	v1,0(sp)
bfc0076c:	00000000 	nop
bfc00770:	28620008 	slti	v0,v1,8
bfc00774:	10400031 	beqz	v0,bfc0083c <generateRandomPattern+0xdc>
bfc00778:	00804821 	move	t1,a0
bfc0077c:	3c0441c6 	lui	a0,0x41c6
bfc00780:	8f868010 	lw	a2,-32752(gp)
bfc00784:	34884e6d 	ori	t0,a0,0x4e6d
bfc00788:	0bf001f9 	j	bfc007e4 <generateRandomPattern+0x84>
bfc0078c:	24070001 	li	a3,1
bfc00790:	00c80018 	mult	a2,t0
bfc00794:	00005812 	mflo	t3
bfc00798:	25663039 	addiu	a2,t3,12345
bfc0079c:	00065402 	srl	t2,a2,0x10
bfc007a0:	31440003 	andi	a0,t2,0x3
bfc007a4:	afa40004 	sw	a0,4(sp)
bfc007a8:	8fa30004 	lw	v1,4(sp)
bfc007ac:	00000000 	nop
bfc007b0:	00671004 	sllv	v0,a3,v1
bfc007b4:	afa20004 	sw	v0,4(sp)
bfc007b8:	8fb90000 	lw	t9,0(sp)
bfc007bc:	8fa50004 	lw	a1,4(sp)
bfc007c0:	8fb80000 	lw	t8,0(sp)
bfc007c4:	00197080 	sll	t6,t9,0x2
bfc007c8:	270f0001 	addiu	t7,t8,1
bfc007cc:	afaf0000 	sw	t7,0(sp)
bfc007d0:	8fad0000 	lw	t5,0(sp)
bfc007d4:	012e6021 	addu	t4,t1,t6
bfc007d8:	29ab0008 	slti	t3,t5,8
bfc007dc:	11600016 	beqz	t3,bfc00838 <generateRandomPattern+0xd8>
bfc007e0:	ad850000 	sw	a1,0(t4)
bfc007e4:	00c80018 	mult	a2,t0
bfc007e8:	00005012 	mflo	t2
bfc007ec:	25463039 	addiu	a2,t2,12345
bfc007f0:	00062402 	srl	a0,a2,0x10
bfc007f4:	30830003 	andi	v1,a0,0x3
bfc007f8:	afa30004 	sw	v1,4(sp)
bfc007fc:	8fa20004 	lw	v0,4(sp)
bfc00800:	00000000 	nop
bfc00804:	0047c804 	sllv	t9,a3,v0
bfc00808:	afb90004 	sw	t9,4(sp)
bfc0080c:	8fb80000 	lw	t8,0(sp)
bfc00810:	8fa50004 	lw	a1,4(sp)
bfc00814:	8faf0000 	lw	t7,0(sp)
bfc00818:	00186880 	sll	t5,t8,0x2
bfc0081c:	25ee0001 	addiu	t6,t7,1
bfc00820:	afae0000 	sw	t6,0(sp)
bfc00824:	8fac0000 	lw	t4,0(sp)
bfc00828:	012d5821 	addu	t3,t1,t5
bfc0082c:	298a0008 	slti	t2,t4,8
bfc00830:	1540ffd7 	bnez	t2,bfc00790 <generateRandomPattern+0x30>
bfc00834:	ad650000 	sw	a1,0(t3)
bfc00838:	af868010 	sw	a2,-32752(gp)
bfc0083c:	03e00008 	jr	ra
bfc00840:	27bd0008 	addiu	sp,sp,8
	...

bfc00850 <displayScore>:
displayScore():
bfc00850:	3c07bfaf 	lui	a3,0xbfaf
bfc00854:	27bdffd8 	addiu	sp,sp,-40
bfc00858:	34e3e000 	ori	v1,a3,0xe000
bfc0085c:	34e6f000 	ori	a2,a3,0xf000
bfc00860:	3c020007 	lui	v0,0x7
bfc00864:	afa00014 	sw	zero,20(sp)
bfc00868:	afb20020 	sw	s2,32(sp)
bfc0086c:	afb1001c 	sw	s1,28(sp)
bfc00870:	afb00018 	sw	s0,24(sp)
bfc00874:	acc00000 	sw	zero,0(a2)
bfc00878:	afbf0024 	sw	ra,36(sp)
bfc0087c:	ac600000 	sw	zero,0(v1)
bfc00880:	00809021 	move	s2,a0
bfc00884:	00a08821 	move	s1,a1
bfc00888:	3450a120 	ori	s0,v0,0xa120
bfc0088c:	0ff006bb 	jal	bfc01aec <get_us>
bfc00890:	00000000 	nop
bfc00894:	0050202a 	slt	a0,v0,s0
bfc00898:	10800024 	beqz	a0,bfc0092c <displayScore+0xdc>
bfc0089c:	3c0bbfaf 	lui	t3,0xbfaf
bfc008a0:	0ff006bb 	jal	bfc01aec <get_us>
bfc008a4:	00000000 	nop
bfc008a8:	0050c02a 	slt	t8,v0,s0
bfc008ac:	1300001f 	beqz	t8,bfc0092c <displayScore+0xdc>
bfc008b0:	3c0bbfaf 	lui	t3,0xbfaf
bfc008b4:	0ff006bb 	jal	bfc01aec <get_us>
bfc008b8:	00000000 	nop
bfc008bc:	0050c82a 	slt	t9,v0,s0
bfc008c0:	1320001a 	beqz	t9,bfc0092c <displayScore+0xdc>
bfc008c4:	3c0bbfaf 	lui	t3,0xbfaf
bfc008c8:	0ff006bb 	jal	bfc01aec <get_us>
bfc008cc:	00000000 	nop
bfc008d0:	0050102a 	slt	v0,v0,s0
bfc008d4:	10400015 	beqz	v0,bfc0092c <displayScore+0xdc>
bfc008d8:	3c0bbfaf 	lui	t3,0xbfaf
bfc008dc:	0ff006bb 	jal	bfc01aec <get_us>
bfc008e0:	00000000 	nop
bfc008e4:	0050182a 	slt	v1,v0,s0
bfc008e8:	10600010 	beqz	v1,bfc0092c <displayScore+0xdc>
bfc008ec:	3c0bbfaf 	lui	t3,0xbfaf
bfc008f0:	0ff006bb 	jal	bfc01aec <get_us>
bfc008f4:	00000000 	nop
bfc008f8:	0050302a 	slt	a2,v0,s0
bfc008fc:	10c0000b 	beqz	a2,bfc0092c <displayScore+0xdc>
bfc00900:	3c0bbfaf 	lui	t3,0xbfaf
bfc00904:	0ff006bb 	jal	bfc01aec <get_us>
bfc00908:	00000000 	nop
bfc0090c:	0050382a 	slt	a3,v0,s0
bfc00910:	10e00006 	beqz	a3,bfc0092c <displayScore+0xdc>
bfc00914:	3c0bbfaf 	lui	t3,0xbfaf
bfc00918:	0ff006bb 	jal	bfc01aec <get_us>
bfc0091c:	00000000 	nop
bfc00920:	0050202a 	slt	a0,v0,s0
bfc00924:	1480ffd9 	bnez	a0,bfc0088c <displayScore+0x3c>
bfc00928:	3c0bbfaf 	lui	t3,0xbfaf
bfc0092c:	3409ffff 	li	t1,0xffff
bfc00930:	356af000 	ori	t2,t3,0xf000
bfc00934:	ad490000 	sw	t1,0(t2)
bfc00938:	afa00010 	sw	zero,16(sp)
bfc0093c:	8fa80010 	lw	t0,16(sp)
bfc00940:	00000000 	nop
bfc00944:	29050008 	slti	a1,t0,8
bfc00948:	14a0000e 	bnez	a1,bfc00984 <displayScore+0x134>
bfc0094c:	3c06bfaf 	lui	a2,0xbfaf
bfc00950:	0bf0027a 	j	bfc009e8 <displayScore+0x198>
bfc00954:	34caf010 	ori	t2,a2,0xf010
	...
bfc00960:	8fa50010 	lw	a1,16(sp)
bfc00964:	00000000 	nop
bfc00968:	24a40001 	addiu	a0,a1,1
bfc0096c:	afa40010 	sw	a0,16(sp)
bfc00970:	8fa70010 	lw	a3,16(sp)
bfc00974:	00000000 	nop
bfc00978:	28e60008 	slti	a2,a3,8
bfc0097c:	10c00019 	beqz	a2,bfc009e4 <displayScore+0x194>
bfc00980:	3c06bfaf 	lui	a2,0xbfaf
bfc00984:	8fbf0010 	lw	ra,16(sp)
bfc00988:	8fb90010 	lw	t9,16(sp)
bfc0098c:	001fc080 	sll	t8,ra,0x2
bfc00990:	00198080 	sll	s0,t9,0x2
bfc00994:	02587821 	addu	t7,s2,t8
bfc00998:	02307021 	addu	t6,s1,s0
bfc0099c:	8ded0000 	lw	t5,0(t7)
bfc009a0:	8dcc0000 	lw	t4,0(t6)
bfc009a4:	00000000 	nop
bfc009a8:	15acffed 	bne	t5,t4,bfc00960 <displayScore+0x110>
bfc009ac:	00000000 	nop
bfc009b0:	8fa30014 	lw	v1,20(sp)
bfc009b4:	00000000 	nop
bfc009b8:	24620001 	addiu	v0,v1,1
bfc009bc:	afa20014 	sw	v0,20(sp)
bfc009c0:	8fa50010 	lw	a1,16(sp)
bfc009c4:	00000000 	nop
bfc009c8:	24a40001 	addiu	a0,a1,1
bfc009cc:	afa40010 	sw	a0,16(sp)
bfc009d0:	8fa70010 	lw	a3,16(sp)
bfc009d4:	00000000 	nop
bfc009d8:	28e60008 	slti	a2,a3,8
bfc009dc:	14c0ffe9 	bnez	a2,bfc00984 <displayScore+0x134>
bfc009e0:	3c06bfaf 	lui	a2,0xbfaf
bfc009e4:	34caf010 	ori	t2,a2,0xf010
bfc009e8:	8d4c0000 	lw	t4,0(t2)
bfc009ec:	8fab0014 	lw	t3,20(sp)
bfc009f0:	34c8f004 	ori	t0,a2,0xf004
bfc009f4:	016c4825 	or	t1,t3,t4
bfc009f8:	24070001 	li	a3,1
bfc009fc:	ad490000 	sw	t1,0(t2)
bfc00a00:	ad070000 	sw	a3,0(t0)
bfc00a04:	8fb20014 	lw	s2,20(sp)
bfc00a08:	24110008 	li	s1,8
bfc00a0c:	1251000c 	beq	s2,s1,bfc00a40 <displayScore+0x1f0>
bfc00a10:	34cff008 	ori	t7,a2,0xf008
bfc00a14:	8fbf0024 	lw	ra,36(sp)
bfc00a18:	240e0002 	li	t6,2
bfc00a1c:	8fb20020 	lw	s2,32(sp)
bfc00a20:	8fb1001c 	lw	s1,28(sp)
bfc00a24:	8fb00018 	lw	s0,24(sp)
bfc00a28:	adee0000 	sw	t6,0(t7)
bfc00a2c:	03e00008 	jr	ra
bfc00a30:	27bd0028 	addiu	sp,sp,40
	...
bfc00a40:	8fbf0024 	lw	ra,36(sp)
bfc00a44:	34cdf008 	ori	t5,a2,0xf008
bfc00a48:	8fb20020 	lw	s2,32(sp)
bfc00a4c:	8fb1001c 	lw	s1,28(sp)
bfc00a50:	8fb00018 	lw	s0,24(sp)
bfc00a54:	ada70000 	sw	a3,0(t5)
bfc00a58:	03e00008 	jr	ra
bfc00a5c:	27bd0028 	addiu	sp,sp,40

bfc00a60 <detectKeyPresses>:
detectKeyPresses():
bfc00a60:	27bdffb8 	addiu	sp,sp,-72
bfc00a64:	afa00018 	sw	zero,24(sp)
bfc00a68:	afa00014 	sw	zero,20(sp)
bfc00a6c:	8fa30014 	lw	v1,20(sp)
bfc00a70:	afb2002c 	sw	s2,44(sp)
bfc00a74:	28620008 	slti	v0,v1,8
bfc00a78:	afbf0044 	sw	ra,68(sp)
bfc00a7c:	afb70040 	sw	s7,64(sp)
bfc00a80:	afb6003c 	sw	s6,60(sp)
bfc00a84:	afb50038 	sw	s5,56(sp)
bfc00a88:	afb40034 	sw	s4,52(sp)
bfc00a8c:	afb30030 	sw	s3,48(sp)
bfc00a90:	afb10028 	sw	s1,40(sp)
bfc00a94:	afb00024 	sw	s0,36(sp)
bfc00a98:	104000ac 	beqz	v0,bfc00d4c <detectKeyPresses+0x2ec>
bfc00a9c:	00809021 	move	s2,a0
bfc00aa0:	3c04bfaf 	lui	a0,0xbfaf
bfc00aa4:	3493f000 	ori	s3,a0,0xf000
bfc00aa8:	3c050006 	lui	a1,0x6
bfc00aac:	34b11a80 	ori	s1,a1,0x1a80
bfc00ab0:	3497f010 	ori	s7,a0,0xf010
bfc00ab4:	3490f024 	ori	s0,a0,0xf024
bfc00ab8:	3494e000 	ori	s4,a0,0xe000
bfc00abc:	0260a821 	move	s5,s3
bfc00ac0:	3416ffff 	li	s6,0xffff
bfc00ac4:	8e090000 	lw	t1,0(s0)
bfc00ac8:	00000000 	nop
bfc00acc:	3128f000 	andi	t0,t1,0xf000
bfc00ad0:	00083b02 	srl	a3,t0,0xc
bfc00ad4:	afa7001c 	sw	a3,28(sp)
bfc00ad8:	8fa6001c 	lw	a2,28(sp)
bfc00adc:	00000000 	nop
bfc00ae0:	10c0fff8 	beqz	a2,bfc00ac4 <detectKeyPresses+0x64>
bfc00ae4:	00000000 	nop
bfc00ae8:	8fa6001c 	lw	a2,28(sp)
bfc00aec:	00000000 	nop
bfc00af0:	30ca0001 	andi	t2,a2,0x1
bfc00af4:	000648c3 	sra	t1,a2,0x3
bfc00af8:	000a38c0 	sll	a3,t2,0x3
bfc00afc:	31280001 	andi	t0,t1,0x1
bfc00b00:	00062842 	srl	a1,a2,0x1
bfc00b04:	00e81025 	or	v0,a3,t0
bfc00b08:	30a40002 	andi	a0,a1,0x2
bfc00b0c:	00061840 	sll	v1,a2,0x1
bfc00b10:	0044c825 	or	t9,v0,a0
bfc00b14:	307f0004 	andi	ra,v1,0x4
bfc00b18:	033fc025 	or	t8,t9,ra
bfc00b1c:	afb80010 	sw	t8,16(sp)
bfc00b20:	8faf0014 	lw	t7,20(sp)
bfc00b24:	8fac0010 	lw	t4,16(sp)
bfc00b28:	8fad0010 	lw	t5,16(sp)
bfc00b2c:	000f7080 	sll	t6,t7,0x2
bfc00b30:	024e5821 	addu	t3,s2,t6
bfc00b34:	000d5027 	nor	t2,zero,t5
bfc00b38:	ad6c0000 	sw	t4,0(t3)
bfc00b3c:	ae6a0000 	sw	t2,0(s3)
bfc00b40:	ae800000 	sw	zero,0(s4)
bfc00b44:	0ff006bb 	jal	bfc01aec <get_us>
bfc00b48:	00000000 	nop
bfc00b4c:	0051582a 	slt	t3,v0,s1
bfc00b50:	11600024 	beqz	t3,bfc00be4 <detectKeyPresses+0x184>
bfc00b54:	00000000 	nop
bfc00b58:	0ff006bb 	jal	bfc01aec <get_us>
bfc00b5c:	00000000 	nop
bfc00b60:	0051202a 	slt	a0,v0,s1
bfc00b64:	1080001f 	beqz	a0,bfc00be4 <detectKeyPresses+0x184>
bfc00b68:	00000000 	nop
bfc00b6c:	0ff006bb 	jal	bfc01aec <get_us>
bfc00b70:	00000000 	nop
bfc00b74:	0051302a 	slt	a2,v0,s1
bfc00b78:	10c0001a 	beqz	a2,bfc00be4 <detectKeyPresses+0x184>
bfc00b7c:	00000000 	nop
bfc00b80:	0ff006bb 	jal	bfc01aec <get_us>
bfc00b84:	00000000 	nop
bfc00b88:	0051282a 	slt	a1,v0,s1
bfc00b8c:	10a00015 	beqz	a1,bfc00be4 <detectKeyPresses+0x184>
bfc00b90:	00000000 	nop
bfc00b94:	0ff006bb 	jal	bfc01aec <get_us>
bfc00b98:	00000000 	nop
bfc00b9c:	0051382a 	slt	a3,v0,s1
bfc00ba0:	10e00010 	beqz	a3,bfc00be4 <detectKeyPresses+0x184>
bfc00ba4:	00000000 	nop
bfc00ba8:	0ff006bb 	jal	bfc01aec <get_us>
bfc00bac:	00000000 	nop
bfc00bb0:	0051402a 	slt	t0,v0,s1
bfc00bb4:	1100000b 	beqz	t0,bfc00be4 <detectKeyPresses+0x184>
bfc00bb8:	00000000 	nop
bfc00bbc:	0ff006bb 	jal	bfc01aec <get_us>
bfc00bc0:	00000000 	nop
bfc00bc4:	0051482a 	slt	t1,v0,s1
bfc00bc8:	11200006 	beqz	t1,bfc00be4 <detectKeyPresses+0x184>
bfc00bcc:	00000000 	nop
bfc00bd0:	0ff006bb 	jal	bfc01aec <get_us>
bfc00bd4:	00000000 	nop
bfc00bd8:	0051502a 	slt	t2,v0,s1
bfc00bdc:	1540ffd9 	bnez	t2,bfc00b44 <detectKeyPresses+0xe4>
bfc00be0:	00000000 	nop
bfc00be4:	8e0f0000 	lw	t7,0(s0)
bfc00be8:	00000000 	nop
bfc00bec:	31eef000 	andi	t6,t7,0xf000
bfc00bf0:	000e6b02 	srl	t5,t6,0xc
bfc00bf4:	afad001c 	sw	t5,28(sp)
bfc00bf8:	8fac001c 	lw	t4,28(sp)
bfc00bfc:	00000000 	nop
bfc00c00:	11800040 	beqz	t4,bfc00d04 <detectKeyPresses+0x2a4>
bfc00c04:	00000000 	nop
bfc00c08:	8e0d0000 	lw	t5,0(s0)
bfc00c0c:	00000000 	nop
bfc00c10:	31acf000 	andi	t4,t5,0xf000
bfc00c14:	000c5b02 	srl	t3,t4,0xc
bfc00c18:	afab001c 	sw	t3,28(sp)
bfc00c1c:	8faa001c 	lw	t2,28(sp)
bfc00c20:	00000000 	nop
bfc00c24:	11400037 	beqz	t2,bfc00d04 <detectKeyPresses+0x2a4>
bfc00c28:	00000000 	nop
bfc00c2c:	8e190000 	lw	t9,0(s0)
bfc00c30:	00000000 	nop
bfc00c34:	3338f000 	andi	t8,t9,0xf000
bfc00c38:	00187b02 	srl	t7,t8,0xc
bfc00c3c:	afaf001c 	sw	t7,28(sp)
bfc00c40:	8fae001c 	lw	t6,28(sp)
bfc00c44:	00000000 	nop
bfc00c48:	11c0002e 	beqz	t6,bfc00d04 <detectKeyPresses+0x2a4>
bfc00c4c:	00000000 	nop
bfc00c50:	8e040000 	lw	a0,0(s0)
bfc00c54:	00000000 	nop
bfc00c58:	3082f000 	andi	v0,a0,0xf000
bfc00c5c:	00021b02 	srl	v1,v0,0xc
bfc00c60:	afa3001c 	sw	v1,28(sp)
bfc00c64:	8fbf001c 	lw	ra,28(sp)
bfc00c68:	00000000 	nop
bfc00c6c:	13e00025 	beqz	ra,bfc00d04 <detectKeyPresses+0x2a4>
bfc00c70:	00000000 	nop
bfc00c74:	8e080000 	lw	t0,0(s0)
bfc00c78:	00000000 	nop
bfc00c7c:	3107f000 	andi	a3,t0,0xf000
bfc00c80:	00072b02 	srl	a1,a3,0xc
bfc00c84:	afa5001c 	sw	a1,28(sp)
bfc00c88:	8fa6001c 	lw	a2,28(sp)
bfc00c8c:	00000000 	nop
bfc00c90:	10c0001c 	beqz	a2,bfc00d04 <detectKeyPresses+0x2a4>
bfc00c94:	00000000 	nop
bfc00c98:	8e0c0000 	lw	t4,0(s0)
bfc00c9c:	00000000 	nop
bfc00ca0:	318bf000 	andi	t3,t4,0xf000
bfc00ca4:	000b5302 	srl	t2,t3,0xc
bfc00ca8:	afaa001c 	sw	t2,28(sp)
bfc00cac:	8fa9001c 	lw	t1,28(sp)
bfc00cb0:	00000000 	nop
bfc00cb4:	11200013 	beqz	t1,bfc00d04 <detectKeyPresses+0x2a4>
bfc00cb8:	00000000 	nop
bfc00cbc:	8e180000 	lw	t8,0(s0)
bfc00cc0:	00000000 	nop
bfc00cc4:	330ff000 	andi	t7,t8,0xf000
bfc00cc8:	000f7302 	srl	t6,t7,0xc
bfc00ccc:	afae001c 	sw	t6,28(sp)
bfc00cd0:	8fad001c 	lw	t5,28(sp)
bfc00cd4:	00000000 	nop
bfc00cd8:	11a0000a 	beqz	t5,bfc00d04 <detectKeyPresses+0x2a4>
bfc00cdc:	00000000 	nop
bfc00ce0:	8e020000 	lw	v0,0(s0)
bfc00ce4:	00000000 	nop
bfc00ce8:	3043f000 	andi	v1,v0,0xf000
bfc00cec:	0003fb02 	srl	ra,v1,0xc
bfc00cf0:	afbf001c 	sw	ra,28(sp)
bfc00cf4:	8fb9001c 	lw	t9,28(sp)
bfc00cf8:	00000000 	nop
bfc00cfc:	1720ffb9 	bnez	t9,bfc00be4 <detectKeyPresses+0x184>
bfc00d00:	00000000 	nop
bfc00d04:	aeb60000 	sw	s6,0(s5)
bfc00d08:	8fa50018 	lw	a1,24(sp)
bfc00d0c:	00000000 	nop
bfc00d10:	24a60001 	addiu	a2,a1,1
bfc00d14:	afa60018 	sw	a2,24(sp)
bfc00d18:	8fa40018 	lw	a0,24(sp)
bfc00d1c:	00000000 	nop
bfc00d20:	00041600 	sll	v0,a0,0x18
bfc00d24:	aee20000 	sw	v0,0(s7)
bfc00d28:	8fa30014 	lw	v1,20(sp)
bfc00d2c:	00000000 	nop
bfc00d30:	247f0001 	addiu	ra,v1,1
bfc00d34:	afbf0014 	sw	ra,20(sp)
bfc00d38:	8fb90014 	lw	t9,20(sp)
bfc00d3c:	00000000 	nop
bfc00d40:	2b380008 	slti	t8,t9,8
bfc00d44:	1700ff5f 	bnez	t8,bfc00ac4 <detectKeyPresses+0x64>
bfc00d48:	00000000 	nop
bfc00d4c:	3c12bfaf 	lui	s2,0xbfaf
bfc00d50:	3650e000 	ori	s0,s2,0xe000
bfc00d54:	3c110012 	lui	s1,0x12
bfc00d58:	ae000000 	sw	zero,0(s0)
bfc00d5c:	36304f80 	ori	s0,s1,0x4f80
bfc00d60:	0ff006bb 	jal	bfc01aec <get_us>
bfc00d64:	00000000 	nop
bfc00d68:	0050982a 	slt	s3,v0,s0
bfc00d6c:	12600024 	beqz	s3,bfc00e00 <detectKeyPresses+0x3a0>
bfc00d70:	00000000 	nop
bfc00d74:	0ff006bb 	jal	bfc01aec <get_us>
bfc00d78:	00000000 	nop
bfc00d7c:	0050a02a 	slt	s4,v0,s0
bfc00d80:	1280001f 	beqz	s4,bfc00e00 <detectKeyPresses+0x3a0>
bfc00d84:	00000000 	nop
bfc00d88:	0ff006bb 	jal	bfc01aec <get_us>
bfc00d8c:	00000000 	nop
bfc00d90:	0050a82a 	slt	s5,v0,s0
bfc00d94:	12a0001a 	beqz	s5,bfc00e00 <detectKeyPresses+0x3a0>
bfc00d98:	00000000 	nop
bfc00d9c:	0ff006bb 	jal	bfc01aec <get_us>
bfc00da0:	00000000 	nop
bfc00da4:	0050b02a 	slt	s6,v0,s0
bfc00da8:	12c00015 	beqz	s6,bfc00e00 <detectKeyPresses+0x3a0>
bfc00dac:	00000000 	nop
bfc00db0:	0ff006bb 	jal	bfc01aec <get_us>
bfc00db4:	00000000 	nop
bfc00db8:	0050b82a 	slt	s7,v0,s0
bfc00dbc:	12e00010 	beqz	s7,bfc00e00 <detectKeyPresses+0x3a0>
bfc00dc0:	00000000 	nop
bfc00dc4:	0ff006bb 	jal	bfc01aec <get_us>
bfc00dc8:	00000000 	nop
bfc00dcc:	0050382a 	slt	a3,v0,s0
bfc00dd0:	10e0000b 	beqz	a3,bfc00e00 <detectKeyPresses+0x3a0>
bfc00dd4:	00000000 	nop
bfc00dd8:	0ff006bb 	jal	bfc01aec <get_us>
bfc00ddc:	00000000 	nop
bfc00de0:	0050402a 	slt	t0,v0,s0
bfc00de4:	11000006 	beqz	t0,bfc00e00 <detectKeyPresses+0x3a0>
bfc00de8:	00000000 	nop
bfc00dec:	0ff006bb 	jal	bfc01aec <get_us>
bfc00df0:	00000000 	nop
bfc00df4:	0050482a 	slt	t1,v0,s0
bfc00df8:	1520ffd9 	bnez	t1,bfc00d60 <detectKeyPresses+0x300>
bfc00dfc:	00000000 	nop
bfc00e00:	8fbf0044 	lw	ra,68(sp)
bfc00e04:	8fb70040 	lw	s7,64(sp)
bfc00e08:	8fb6003c 	lw	s6,60(sp)
bfc00e0c:	8fb50038 	lw	s5,56(sp)
bfc00e10:	8fb40034 	lw	s4,52(sp)
bfc00e14:	8fb30030 	lw	s3,48(sp)
bfc00e18:	8fb2002c 	lw	s2,44(sp)
bfc00e1c:	8fb10028 	lw	s1,40(sp)
bfc00e20:	8fb00024 	lw	s0,36(sp)
bfc00e24:	03e00008 	jr	ra
bfc00e28:	27bd0048 	addiu	sp,sp,72
bfc00e2c:	00000000 	nop

bfc00e30 <displayPattern>:
displayPattern():
bfc00e30:	3c07bfaf 	lui	a3,0xbfaf
bfc00e34:	27bdffc8 	addiu	sp,sp,-56
bfc00e38:	34e5e000 	ori	a1,a3,0xe000
bfc00e3c:	34e6f000 	ori	a2,a3,0xf000
bfc00e40:	3403ffff 	li	v1,0xffff
bfc00e44:	3c02000f 	lui	v0,0xf
bfc00e48:	afb50030 	sw	s5,48(sp)
bfc00e4c:	afb0001c 	sw	s0,28(sp)
bfc00e50:	acc30000 	sw	v1,0(a2)
bfc00e54:	afbf0034 	sw	ra,52(sp)
bfc00e58:	afb4002c 	sw	s4,44(sp)
bfc00e5c:	afb30028 	sw	s3,40(sp)
bfc00e60:	afb20024 	sw	s2,36(sp)
bfc00e64:	afb10020 	sw	s1,32(sp)
bfc00e68:	aca00000 	sw	zero,0(a1)
bfc00e6c:	0080a821 	move	s5,a0
bfc00e70:	34504240 	ori	s0,v0,0x4240
bfc00e74:	0ff006bb 	jal	bfc01aec <get_us>
bfc00e78:	00000000 	nop
bfc00e7c:	0050202a 	slt	a0,v0,s0
bfc00e80:	10800024 	beqz	a0,bfc00f14 <displayPattern+0xe4>
bfc00e84:	00000000 	nop
bfc00e88:	0ff006bb 	jal	bfc01aec <get_us>
bfc00e8c:	00000000 	nop
bfc00e90:	0050982a 	slt	s3,v0,s0
bfc00e94:	1260001f 	beqz	s3,bfc00f14 <displayPattern+0xe4>
bfc00e98:	00000000 	nop
bfc00e9c:	0ff006bb 	jal	bfc01aec <get_us>
bfc00ea0:	00000000 	nop
bfc00ea4:	0050a02a 	slt	s4,v0,s0
bfc00ea8:	1280001a 	beqz	s4,bfc00f14 <displayPattern+0xe4>
bfc00eac:	00000000 	nop
bfc00eb0:	0ff006bb 	jal	bfc01aec <get_us>
bfc00eb4:	00000000 	nop
bfc00eb8:	0050182a 	slt	v1,v0,s0
bfc00ebc:	10600015 	beqz	v1,bfc00f14 <displayPattern+0xe4>
bfc00ec0:	00000000 	nop
bfc00ec4:	0ff006bb 	jal	bfc01aec <get_us>
bfc00ec8:	00000000 	nop
bfc00ecc:	0050382a 	slt	a3,v0,s0
bfc00ed0:	10e00010 	beqz	a3,bfc00f14 <displayPattern+0xe4>
bfc00ed4:	00000000 	nop
bfc00ed8:	0ff006bb 	jal	bfc01aec <get_us>
bfc00edc:	00000000 	nop
bfc00ee0:	0050882a 	slt	s1,v0,s0
bfc00ee4:	1220000b 	beqz	s1,bfc00f14 <displayPattern+0xe4>
bfc00ee8:	00000000 	nop
bfc00eec:	0ff006bb 	jal	bfc01aec <get_us>
bfc00ef0:	00000000 	nop
bfc00ef4:	0050902a 	slt	s2,v0,s0
bfc00ef8:	12400006 	beqz	s2,bfc00f14 <displayPattern+0xe4>
bfc00efc:	00000000 	nop
bfc00f00:	0ff006bb 	jal	bfc01aec <get_us>
bfc00f04:	00000000 	nop
bfc00f08:	0050202a 	slt	a0,v0,s0
bfc00f0c:	1480ffd9 	bnez	a0,bfc00e74 <displayPattern+0x44>
bfc00f10:	00000000 	nop
bfc00f14:	afa00010 	sw	zero,16(sp)
bfc00f18:	8fa90010 	lw	t1,16(sp)
bfc00f1c:	00000000 	nop
bfc00f20:	29280008 	slti	t0,t1,8
bfc00f24:	1100006c 	beqz	t0,bfc010d8 <displayPattern+0x2a8>
bfc00f28:	3c0abfaf 	lui	t2,0xbfaf
bfc00f2c:	3c0c000c 	lui	t4,0xc
bfc00f30:	3c0b0006 	lui	t3,0x6
bfc00f34:	3553e000 	ori	s3,t2,0xe000
bfc00f38:	35913500 	ori	s1,t4,0x3500
bfc00f3c:	35701a80 	ori	s0,t3,0x1a80
bfc00f40:	3552f000 	ori	s2,t2,0xf000
bfc00f44:	3414ffff 	li	s4,0xffff
bfc00f48:	8fb90010 	lw	t9,16(sp)
bfc00f4c:	00000000 	nop
bfc00f50:	0019c080 	sll	t8,t9,0x2
bfc00f54:	02b87821 	addu	t7,s5,t8
bfc00f58:	8dee0000 	lw	t6,0(t7)
bfc00f5c:	00000000 	nop
bfc00f60:	000e6827 	nor	t5,zero,t6
bfc00f64:	ae4d0000 	sw	t5,0(s2)
bfc00f68:	ae600000 	sw	zero,0(s3)
bfc00f6c:	0ff006bb 	jal	bfc01aec <get_us>
bfc00f70:	00000000 	nop
bfc00f74:	0051102a 	slt	v0,v0,s1
bfc00f78:	10400024 	beqz	v0,bfc0100c <displayPattern+0x1dc>
bfc00f7c:	00000000 	nop
bfc00f80:	0ff006bb 	jal	bfc01aec <get_us>
bfc00f84:	00000000 	nop
bfc00f88:	0051702a 	slt	t6,v0,s1
bfc00f8c:	11c0001f 	beqz	t6,bfc0100c <displayPattern+0x1dc>
bfc00f90:	00000000 	nop
bfc00f94:	0ff006bb 	jal	bfc01aec <get_us>
bfc00f98:	00000000 	nop
bfc00f9c:	0051782a 	slt	t7,v0,s1
bfc00fa0:	11e0001a 	beqz	t7,bfc0100c <displayPattern+0x1dc>
bfc00fa4:	00000000 	nop
bfc00fa8:	0ff006bb 	jal	bfc01aec <get_us>
bfc00fac:	00000000 	nop
bfc00fb0:	0051c02a 	slt	t8,v0,s1
bfc00fb4:	13000015 	beqz	t8,bfc0100c <displayPattern+0x1dc>
bfc00fb8:	00000000 	nop
bfc00fbc:	0ff006bb 	jal	bfc01aec <get_us>
bfc00fc0:	00000000 	nop
bfc00fc4:	0051c82a 	slt	t9,v0,s1
bfc00fc8:	13200010 	beqz	t9,bfc0100c <displayPattern+0x1dc>
bfc00fcc:	00000000 	nop
bfc00fd0:	0ff006bb 	jal	bfc01aec <get_us>
bfc00fd4:	00000000 	nop
bfc00fd8:	0051102a 	slt	v0,v0,s1
bfc00fdc:	1040000b 	beqz	v0,bfc0100c <displayPattern+0x1dc>
bfc00fe0:	00000000 	nop
bfc00fe4:	0ff006bb 	jal	bfc01aec <get_us>
bfc00fe8:	00000000 	nop
bfc00fec:	0051282a 	slt	a1,v0,s1
bfc00ff0:	10a00006 	beqz	a1,bfc0100c <displayPattern+0x1dc>
bfc00ff4:	00000000 	nop
bfc00ff8:	0ff006bb 	jal	bfc01aec <get_us>
bfc00ffc:	00000000 	nop
bfc01000:	0051302a 	slt	a2,v0,s1
bfc01004:	14c0ffd9 	bnez	a2,bfc00f6c <displayPattern+0x13c>
bfc01008:	00000000 	nop
bfc0100c:	ae540000 	sw	s4,0(s2)
bfc01010:	ae600000 	sw	zero,0(s3)
bfc01014:	0ff006bb 	jal	bfc01aec <get_us>
bfc01018:	00000000 	nop
bfc0101c:	0050282a 	slt	a1,v0,s0
bfc01020:	10a00024 	beqz	a1,bfc010b4 <displayPattern+0x284>
bfc01024:	00000000 	nop
bfc01028:	0ff006bb 	jal	bfc01aec <get_us>
bfc0102c:	00000000 	nop
bfc01030:	0050202a 	slt	a0,v0,s0
bfc01034:	1080001f 	beqz	a0,bfc010b4 <displayPattern+0x284>
bfc01038:	00000000 	nop
bfc0103c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01040:	00000000 	nop
bfc01044:	0050402a 	slt	t0,v0,s0
bfc01048:	1100001a 	beqz	t0,bfc010b4 <displayPattern+0x284>
bfc0104c:	00000000 	nop
bfc01050:	0ff006bb 	jal	bfc01aec <get_us>
bfc01054:	00000000 	nop
bfc01058:	0050482a 	slt	t1,v0,s0
bfc0105c:	11200015 	beqz	t1,bfc010b4 <displayPattern+0x284>
bfc01060:	00000000 	nop
bfc01064:	0ff006bb 	jal	bfc01aec <get_us>
bfc01068:	00000000 	nop
bfc0106c:	0050502a 	slt	t2,v0,s0
bfc01070:	11400010 	beqz	t2,bfc010b4 <displayPattern+0x284>
bfc01074:	00000000 	nop
bfc01078:	0ff006bb 	jal	bfc01aec <get_us>
bfc0107c:	00000000 	nop
bfc01080:	0050582a 	slt	t3,v0,s0
bfc01084:	1160000b 	beqz	t3,bfc010b4 <displayPattern+0x284>
bfc01088:	00000000 	nop
bfc0108c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01090:	00000000 	nop
bfc01094:	0050602a 	slt	t4,v0,s0
bfc01098:	11800006 	beqz	t4,bfc010b4 <displayPattern+0x284>
bfc0109c:	00000000 	nop
bfc010a0:	0ff006bb 	jal	bfc01aec <get_us>
bfc010a4:	00000000 	nop
bfc010a8:	0050682a 	slt	t5,v0,s0
bfc010ac:	15a0ffd9 	bnez	t5,bfc01014 <displayPattern+0x1e4>
bfc010b0:	00000000 	nop
bfc010b4:	8fa70010 	lw	a3,16(sp)
bfc010b8:	00000000 	nop
bfc010bc:	24e30001 	addiu	v1,a3,1
bfc010c0:	afa30010 	sw	v1,16(sp)
bfc010c4:	8fa60010 	lw	a2,16(sp)
bfc010c8:	00000000 	nop
bfc010cc:	28df0008 	slti	ra,a2,8
bfc010d0:	17e0ff9d 	bnez	ra,bfc00f48 <displayPattern+0x118>
bfc010d4:	00000000 	nop
bfc010d8:	3c12bfaf 	lui	s2,0xbfaf
bfc010dc:	8fbf0034 	lw	ra,52(sp)
bfc010e0:	3650f000 	ori	s0,s2,0xf000
bfc010e4:	3411ffff 	li	s1,0xffff
bfc010e8:	ae110000 	sw	s1,0(s0)
bfc010ec:	8fb50030 	lw	s5,48(sp)
bfc010f0:	8fb4002c 	lw	s4,44(sp)
bfc010f4:	8fb30028 	lw	s3,40(sp)
bfc010f8:	8fb20024 	lw	s2,36(sp)
bfc010fc:	8fb10020 	lw	s1,32(sp)
bfc01100:	8fb0001c 	lw	s0,28(sp)
bfc01104:	03e00008 	jr	ra
bfc01108:	27bd0038 	addiu	sp,sp,56
bfc0110c:	00000000 	nop

bfc01110 <memory_game>:
memory_game():
bfc01110:	3c07bfaf 	lui	a3,0xbfaf
bfc01114:	34e5f000 	ori	a1,a3,0xf000
bfc01118:	3406ffff 	li	a2,0xffff
bfc0111c:	27bdff40 	addiu	sp,sp,-192
bfc01120:	aca60000 	sw	a2,0(a1)
bfc01124:	afbe00b8 	sw	s8,184(sp)
bfc01128:	afb600b0 	sw	s6,176(sp)
bfc0112c:	afb400a8 	sw	s4,168(sp)
bfc01130:	afb300a4 	sw	s3,164(sp)
bfc01134:	afb1009c 	sw	s1,156(sp)
bfc01138:	afb00098 	sw	s0,152(sp)
bfc0113c:	afbf00bc 	sw	ra,188(sp)
bfc01140:	afb700b4 	sw	s7,180(sp)
bfc01144:	afb500ac 	sw	s5,172(sp)
bfc01148:	afb200a0 	sw	s2,160(sp)
bfc0114c:	0ff006ac 	jal	bfc01ab0 <get_count>
bfc01150:	00a0a021 	move	s4,a1
bfc01154:	af828010 	sw	v0,-32752(gp)
bfc01158:	3c04000c 	lui	a0,0xc
bfc0115c:	3c030006 	lui	v1,0x6
bfc01160:	3c02bfaf 	lui	v0,0xbfaf
bfc01164:	34933500 	ori	s3,a0,0x3500
bfc01168:	34701a80 	ori	s0,v1,0x1a80
bfc0116c:	27b60020 	addiu	s6,sp,32
bfc01170:	27be005c 	addiu	s8,sp,92
bfc01174:	3451f024 	ori	s1,v0,0xf024
bfc01178:	8e2b0000 	lw	t3,0(s1)
bfc0117c:	00000000 	nop
bfc01180:	316af000 	andi	t2,t3,0xf000
bfc01184:	000a4b02 	srl	t1,t2,0xc
bfc01188:	afa90014 	sw	t1,20(sp)
bfc0118c:	8fa80014 	lw	t0,20(sp)
bfc01190:	00000000 	nop
bfc01194:	1100fff8 	beqz	t0,bfc01178 <memory_game+0x68>
bfc01198:	00000000 	nop
bfc0119c:	8fa20014 	lw	v0,20(sp)
bfc011a0:	afa00014 	sw	zero,20(sp)
bfc011a4:	8fad0014 	lw	t5,20(sp)
bfc011a8:	00000000 	nop
bfc011ac:	29ac0008 	slti	t4,t5,8
bfc011b0:	11800037 	beqz	t4,bfc01290 <memory_game+0x180>
bfc011b4:	3c0e41c6 	lui	t6,0x41c6
bfc011b8:	8f858010 	lw	a1,-32752(gp)
bfc011bc:	35c74e6d 	ori	a3,t6,0x4e6d
bfc011c0:	0bf0048b 	j	bfc0122c <memory_game+0x11c>
bfc011c4:	24060001 	li	a2,1
	...
bfc011d0:	0000c012 	mflo	t8
bfc011d4:	27053039 	addiu	a1,t8,12345
bfc011d8:	00057c02 	srl	t7,a1,0x10
bfc011dc:	31ee0003 	andi	t6,t7,0x3
bfc011e0:	afae0010 	sw	t6,16(sp)
bfc011e4:	8fad0010 	lw	t5,16(sp)
bfc011e8:	00000000 	nop
bfc011ec:	01a66004 	sllv	t4,a2,t5
bfc011f0:	afac0010 	sw	t4,16(sp)
bfc011f4:	8fab0014 	lw	t3,20(sp)
bfc011f8:	8fb70010 	lw	s7,16(sp)
bfc011fc:	000b1880 	sll	v1,t3,0x2
bfc01200:	00765021 	addu	t2,v1,s6
bfc01204:	ad570000 	sw	s7,0(t2)
bfc01208:	8fa40014 	lw	a0,20(sp)
bfc0120c:	00000000 	nop
bfc01210:	24820001 	addiu	v0,a0,1
bfc01214:	afa20014 	sw	v0,20(sp)
bfc01218:	8fa90014 	lw	t1,20(sp)
bfc0121c:	00000000 	nop
bfc01220:	293f0008 	slti	ra,t1,8
bfc01224:	13e00019 	beqz	ra,bfc0128c <memory_game+0x17c>
bfc01228:	00000000 	nop
bfc0122c:	00a70018 	mult	a1,a3
bfc01230:	00005012 	mflo	t2
bfc01234:	25453039 	addiu	a1,t2,12345
bfc01238:	00054c02 	srl	t1,a1,0x10
bfc0123c:	31280003 	andi	t0,t1,0x3
bfc01240:	afa80010 	sw	t0,16(sp)
bfc01244:	8fa40010 	lw	a0,16(sp)
bfc01248:	00000000 	nop
bfc0124c:	00861804 	sllv	v1,a2,a0
bfc01250:	afa30010 	sw	v1,16(sp)
bfc01254:	8fa20014 	lw	v0,20(sp)
bfc01258:	8fb80010 	lw	t8,16(sp)
bfc0125c:	0002f880 	sll	ra,v0,0x2
bfc01260:	03f6c821 	addu	t9,ra,s6
bfc01264:	af380000 	sw	t8,0(t9)
bfc01268:	8fb70014 	lw	s7,20(sp)
bfc0126c:	00000000 	nop
bfc01270:	26f50001 	addiu	s5,s7,1
bfc01274:	afb50014 	sw	s5,20(sp)
bfc01278:	8fb20014 	lw	s2,20(sp)
bfc0127c:	00000000 	nop
bfc01280:	2a4f0008 	slti	t7,s2,8
bfc01284:	15e0ffd2 	bnez	t7,bfc011d0 <memory_game+0xc0>
bfc01288:	00a70018 	mult	a1,a3
bfc0128c:	af858010 	sw	a1,-32752(gp)
bfc01290:	3c07bfaf 	lui	a3,0xbfaf
bfc01294:	34e5e000 	ori	a1,a3,0xe000
bfc01298:	3406ffff 	li	a2,0xffff
bfc0129c:	ae860000 	sw	a2,0(s4)
bfc012a0:	aca00000 	sw	zero,0(a1)
bfc012a4:	0ff006bb 	jal	bfc01aec <get_us>
bfc012a8:	00000000 	nop
bfc012ac:	3c0d000f 	lui	t5,0xf
bfc012b0:	35ac4240 	ori	t4,t5,0x4240
bfc012b4:	004c582a 	slt	t3,v0,t4
bfc012b8:	11600030 	beqz	t3,bfc0137c <memory_game+0x26c>
bfc012bc:	00000000 	nop
bfc012c0:	0ff006bb 	jal	bfc01aec <get_us>
bfc012c4:	00000000 	nop
bfc012c8:	3c09000f 	lui	t1,0xf
bfc012cc:	35324240 	ori	s2,t1,0x4240
bfc012d0:	0052a82a 	slt	s5,v0,s2
bfc012d4:	12a00029 	beqz	s5,bfc0137c <memory_game+0x26c>
bfc012d8:	00000000 	nop
bfc012dc:	0ff006bb 	jal	bfc01aec <get_us>
bfc012e0:	3c17000f 	lui	s7,0xf
bfc012e4:	36e44240 	ori	a0,s7,0x4240
bfc012e8:	0044102a 	slt	v0,v0,a0
bfc012ec:	10400023 	beqz	v0,bfc0137c <memory_game+0x26c>
bfc012f0:	00000000 	nop
bfc012f4:	0ff006bb 	jal	bfc01aec <get_us>
bfc012f8:	00000000 	nop
bfc012fc:	3c06000f 	lui	a2,0xf
bfc01300:	34c34240 	ori	v1,a2,0x4240
bfc01304:	0043502a 	slt	t2,v0,v1
bfc01308:	1140001c 	beqz	t2,bfc0137c <memory_game+0x26c>
bfc0130c:	00000000 	nop
bfc01310:	0ff006bb 	jal	bfc01aec <get_us>
bfc01314:	00000000 	nop
bfc01318:	3c0b000f 	lui	t3,0xf
bfc0131c:	35654240 	ori	a1,t3,0x4240
bfc01320:	0045382a 	slt	a3,v0,a1
bfc01324:	10e00015 	beqz	a3,bfc0137c <memory_game+0x26c>
bfc01328:	00000000 	nop
bfc0132c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01330:	00000000 	nop
bfc01334:	3c0e000f 	lui	t6,0xf
bfc01338:	35cd4240 	ori	t5,t6,0x4240
bfc0133c:	004d602a 	slt	t4,v0,t5
bfc01340:	1180000e 	beqz	t4,bfc0137c <memory_game+0x26c>
bfc01344:	00000000 	nop
bfc01348:	0ff006bb 	jal	bfc01aec <get_us>
bfc0134c:	00000000 	nop
bfc01350:	3c19000f 	lui	t9,0xf
bfc01354:	37384240 	ori	t8,t9,0x4240
bfc01358:	0058782a 	slt	t7,v0,t8
bfc0135c:	11e00007 	beqz	t7,bfc0137c <memory_game+0x26c>
bfc01360:	00000000 	nop
bfc01364:	0ff006bb 	jal	bfc01aec <get_us>
bfc01368:	3c12000f 	lui	s2,0xf
bfc0136c:	36554240 	ori	s5,s2,0x4240
bfc01370:	0055402a 	slt	t0,v0,s5
bfc01374:	1500ffcb 	bnez	t0,bfc012a4 <memory_game+0x194>
bfc01378:	00000000 	nop
bfc0137c:	afa00010 	sw	zero,16(sp)
bfc01380:	8faf0010 	lw	t7,16(sp)
bfc01384:	00000000 	nop
bfc01388:	29ee0008 	slti	t6,t7,8
bfc0138c:	11c00067 	beqz	t6,bfc0152c <memory_game+0x41c>
bfc01390:	3c15bfaf 	lui	s5,0xbfaf
bfc01394:	36b2e000 	ori	s2,s5,0xe000
bfc01398:	3415ffff 	li	s5,0xffff
bfc0139c:	8fa20010 	lw	v0,16(sp)
bfc013a0:	00000000 	nop
bfc013a4:	0002f880 	sll	ra,v0,0x2
bfc013a8:	03f6c821 	addu	t9,ra,s6
bfc013ac:	8f380000 	lw	t8,0(t9)
bfc013b0:	00000000 	nop
bfc013b4:	0018b827 	nor	s7,zero,t8
bfc013b8:	ae970000 	sw	s7,0(s4)
bfc013bc:	ae400000 	sw	zero,0(s2)
bfc013c0:	0ff006bb 	jal	bfc01aec <get_us>
bfc013c4:	00000000 	nop
bfc013c8:	0053182a 	slt	v1,v0,s3
bfc013cc:	10600024 	beqz	v1,bfc01460 <memory_game+0x350>
bfc013d0:	00000000 	nop
bfc013d4:	0ff006bb 	jal	bfc01aec <get_us>
bfc013d8:	00000000 	nop
bfc013dc:	0053602a 	slt	t4,v0,s3
bfc013e0:	1180001f 	beqz	t4,bfc01460 <memory_game+0x350>
bfc013e4:	00000000 	nop
bfc013e8:	0ff006bb 	jal	bfc01aec <get_us>
bfc013ec:	00000000 	nop
bfc013f0:	0053682a 	slt	t5,v0,s3
bfc013f4:	11a0001a 	beqz	t5,bfc01460 <memory_game+0x350>
bfc013f8:	00000000 	nop
bfc013fc:	0ff006bb 	jal	bfc01aec <get_us>
bfc01400:	00000000 	nop
bfc01404:	0053702a 	slt	t6,v0,s3
bfc01408:	11c00015 	beqz	t6,bfc01460 <memory_game+0x350>
bfc0140c:	00000000 	nop
bfc01410:	0ff006bb 	jal	bfc01aec <get_us>
bfc01414:	00000000 	nop
bfc01418:	0053782a 	slt	t7,v0,s3
bfc0141c:	11e00010 	beqz	t7,bfc01460 <memory_game+0x350>
bfc01420:	00000000 	nop
bfc01424:	0ff006bb 	jal	bfc01aec <get_us>
bfc01428:	00000000 	nop
bfc0142c:	0053c02a 	slt	t8,v0,s3
bfc01430:	1300000b 	beqz	t8,bfc01460 <memory_game+0x350>
bfc01434:	00000000 	nop
bfc01438:	0ff006bb 	jal	bfc01aec <get_us>
bfc0143c:	00000000 	nop
bfc01440:	0053c82a 	slt	t9,v0,s3
bfc01444:	13200006 	beqz	t9,bfc01460 <memory_game+0x350>
bfc01448:	00000000 	nop
bfc0144c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01450:	00000000 	nop
bfc01454:	0053402a 	slt	t0,v0,s3
bfc01458:	1500ffd9 	bnez	t0,bfc013c0 <memory_game+0x2b0>
bfc0145c:	00000000 	nop
bfc01460:	ae950000 	sw	s5,0(s4)
bfc01464:	ae400000 	sw	zero,0(s2)
bfc01468:	0ff006bb 	jal	bfc01aec <get_us>
bfc0146c:	00000000 	nop
bfc01470:	0050202a 	slt	a0,v0,s0
bfc01474:	10800024 	beqz	a0,bfc01508 <memory_game+0x3f8>
bfc01478:	00000000 	nop
bfc0147c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01480:	00000000 	nop
bfc01484:	0050b82a 	slt	s7,v0,s0
bfc01488:	12e0001f 	beqz	s7,bfc01508 <memory_game+0x3f8>
bfc0148c:	00000000 	nop
bfc01490:	0ff006bb 	jal	bfc01aec <get_us>
bfc01494:	00000000 	nop
bfc01498:	0050502a 	slt	t2,v0,s0
bfc0149c:	1140001a 	beqz	t2,bfc01508 <memory_game+0x3f8>
bfc014a0:	00000000 	nop
bfc014a4:	0ff006bb 	jal	bfc01aec <get_us>
bfc014a8:	00000000 	nop
bfc014ac:	0050182a 	slt	v1,v0,s0
bfc014b0:	10600015 	beqz	v1,bfc01508 <memory_game+0x3f8>
bfc014b4:	00000000 	nop
bfc014b8:	0ff006bb 	jal	bfc01aec <get_us>
bfc014bc:	00000000 	nop
bfc014c0:	0050302a 	slt	a2,v0,s0
bfc014c4:	10c00010 	beqz	a2,bfc01508 <memory_game+0x3f8>
bfc014c8:	00000000 	nop
bfc014cc:	0ff006bb 	jal	bfc01aec <get_us>
bfc014d0:	00000000 	nop
bfc014d4:	0050382a 	slt	a3,v0,s0
bfc014d8:	10e0000b 	beqz	a3,bfc01508 <memory_game+0x3f8>
bfc014dc:	00000000 	nop
bfc014e0:	0ff006bb 	jal	bfc01aec <get_us>
bfc014e4:	00000000 	nop
bfc014e8:	0050282a 	slt	a1,v0,s0
bfc014ec:	10a00006 	beqz	a1,bfc01508 <memory_game+0x3f8>
bfc014f0:	00000000 	nop
bfc014f4:	0ff006bb 	jal	bfc01aec <get_us>
bfc014f8:	00000000 	nop
bfc014fc:	0050582a 	slt	t3,v0,s0
bfc01500:	1560ffd9 	bnez	t3,bfc01468 <memory_game+0x358>
bfc01504:	00000000 	nop
bfc01508:	8fa50010 	lw	a1,16(sp)
bfc0150c:	00000000 	nop
bfc01510:	24aa0001 	addiu	t2,a1,1
bfc01514:	afaa0010 	sw	t2,16(sp)
bfc01518:	8fa90010 	lw	t1,16(sp)
bfc0151c:	00000000 	nop
bfc01520:	29280008 	slti	t0,t1,8
bfc01524:	1500ff9d 	bnez	t0,bfc0139c <memory_game+0x28c>
bfc01528:	00000000 	nop
bfc0152c:	3407ffff 	li	a3,0xffff
bfc01530:	ae870000 	sw	a3,0(s4)
bfc01534:	afa0001c 	sw	zero,28(sp)
bfc01538:	afa00014 	sw	zero,20(sp)
bfc0153c:	8fa60014 	lw	a2,20(sp)
bfc01540:	00000000 	nop
bfc01544:	28d20008 	slti	s2,a2,8
bfc01548:	124000a9 	beqz	s2,bfc017f0 <memory_game+0x6e0>
bfc0154c:	3c0bbfaf 	lui	t3,0xbfaf
bfc01550:	3572e000 	ori	s2,t3,0xe000
bfc01554:	3415ffff 	li	s5,0xffff
bfc01558:	3577f010 	ori	s7,t3,0xf010
bfc0155c:	8e2f0000 	lw	t7,0(s1)
bfc01560:	00000000 	nop
bfc01564:	31eef000 	andi	t6,t7,0xf000
bfc01568:	000e6b02 	srl	t5,t6,0xc
bfc0156c:	afad0018 	sw	t5,24(sp)
bfc01570:	8fac0018 	lw	t4,24(sp)
bfc01574:	00000000 	nop
bfc01578:	1180fff8 	beqz	t4,bfc0155c <memory_game+0x44c>
bfc0157c:	00000000 	nop
bfc01580:	8fab0018 	lw	t3,24(sp)
bfc01584:	00000000 	nop
bfc01588:	31780001 	andi	t8,t3,0x1
bfc0158c:	000b78c3 	sra	t7,t3,0x3
bfc01590:	001868c0 	sll	t5,t8,0x3
bfc01594:	31ee0001 	andi	t6,t7,0x1
bfc01598:	000b6042 	srl	t4,t3,0x1
bfc0159c:	01ae3825 	or	a3,t5,t6
bfc015a0:	31850002 	andi	a1,t4,0x2
bfc015a4:	000b3040 	sll	a2,t3,0x1
bfc015a8:	00e54825 	or	t1,a3,a1
bfc015ac:	30ca0004 	andi	t2,a2,0x4
bfc015b0:	012a4025 	or	t0,t1,t2
bfc015b4:	afa80010 	sw	t0,16(sp)
bfc015b8:	8fa40014 	lw	a0,20(sp)
bfc015bc:	8fa20010 	lw	v0,16(sp)
bfc015c0:	00041880 	sll	v1,a0,0x2
bfc015c4:	007ef821 	addu	ra,v1,s8
bfc015c8:	afe20000 	sw	v0,0(ra)
bfc015cc:	8fb90010 	lw	t9,16(sp)
bfc015d0:	00000000 	nop
bfc015d4:	0019c027 	nor	t8,zero,t9
bfc015d8:	ae980000 	sw	t8,0(s4)
bfc015dc:	ae400000 	sw	zero,0(s2)
bfc015e0:	0ff006bb 	jal	bfc01aec <get_us>
bfc015e4:	00000000 	nop
bfc015e8:	0050c82a 	slt	t9,v0,s0
bfc015ec:	13200024 	beqz	t9,bfc01680 <memory_game+0x570>
bfc015f0:	00000000 	nop
bfc015f4:	0ff006bb 	jal	bfc01aec <get_us>
bfc015f8:	00000000 	nop
bfc015fc:	0050782a 	slt	t7,v0,s0
bfc01600:	11e0001f 	beqz	t7,bfc01680 <memory_game+0x570>
bfc01604:	00000000 	nop
bfc01608:	0ff006bb 	jal	bfc01aec <get_us>
bfc0160c:	00000000 	nop
bfc01610:	0050c02a 	slt	t8,v0,s0
bfc01614:	1300001a 	beqz	t8,bfc01680 <memory_game+0x570>
bfc01618:	00000000 	nop
bfc0161c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01620:	00000000 	nop
bfc01624:	0050c82a 	slt	t9,v0,s0
bfc01628:	13200015 	beqz	t9,bfc01680 <memory_game+0x570>
bfc0162c:	00000000 	nop
bfc01630:	0ff006bb 	jal	bfc01aec <get_us>
bfc01634:	00000000 	nop
bfc01638:	0050402a 	slt	t0,v0,s0
bfc0163c:	11000010 	beqz	t0,bfc01680 <memory_game+0x570>
bfc01640:	00000000 	nop
bfc01644:	0ff006bb 	jal	bfc01aec <get_us>
bfc01648:	00000000 	nop
bfc0164c:	0050102a 	slt	v0,v0,s0
bfc01650:	1040000b 	beqz	v0,bfc01680 <memory_game+0x570>
bfc01654:	00000000 	nop
bfc01658:	0ff006bb 	jal	bfc01aec <get_us>
bfc0165c:	00000000 	nop
bfc01660:	0050482a 	slt	t1,v0,s0
bfc01664:	11200006 	beqz	t1,bfc01680 <memory_game+0x570>
bfc01668:	00000000 	nop
bfc0166c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01670:	00000000 	nop
bfc01674:	0050202a 	slt	a0,v0,s0
bfc01678:	1480ffd9 	bnez	a0,bfc015e0 <memory_game+0x4d0>
bfc0167c:	00000000 	nop
bfc01680:	8e240000 	lw	a0,0(s1)
bfc01684:	00000000 	nop
bfc01688:	3083f000 	andi	v1,a0,0xf000
bfc0168c:	00031302 	srl	v0,v1,0xc
bfc01690:	afa20018 	sw	v0,24(sp)
bfc01694:	8fbf0018 	lw	ra,24(sp)
bfc01698:	00000000 	nop
bfc0169c:	13e00041 	beqz	ra,bfc017a4 <memory_game+0x694>
bfc016a0:	3c0ebfaf 	lui	t6,0xbfaf
bfc016a4:	8e230000 	lw	v1,0(s1)
bfc016a8:	00000000 	nop
bfc016ac:	306af000 	andi	t2,v1,0xf000
bfc016b0:	000a2302 	srl	a0,t2,0xc
bfc016b4:	afa40018 	sw	a0,24(sp)
bfc016b8:	8fbf0018 	lw	ra,24(sp)
bfc016bc:	00000000 	nop
bfc016c0:	13e00038 	beqz	ra,bfc017a4 <memory_game+0x694>
bfc016c4:	3c0ebfaf 	lui	t6,0xbfaf
bfc016c8:	8e2b0000 	lw	t3,0(s1)
bfc016cc:	00000000 	nop
bfc016d0:	3165f000 	andi	a1,t3,0xf000
bfc016d4:	00053b02 	srl	a3,a1,0xc
bfc016d8:	afa70018 	sw	a3,24(sp)
bfc016dc:	8fa60018 	lw	a2,24(sp)
bfc016e0:	00000000 	nop
bfc016e4:	10c0002f 	beqz	a2,bfc017a4 <memory_game+0x694>
bfc016e8:	3c0ebfaf 	lui	t6,0xbfaf
bfc016ec:	8e2f0000 	lw	t7,0(s1)
bfc016f0:	00000000 	nop
bfc016f4:	31eef000 	andi	t6,t7,0xf000
bfc016f8:	000e6b02 	srl	t5,t6,0xc
bfc016fc:	afad0018 	sw	t5,24(sp)
bfc01700:	8fac0018 	lw	t4,24(sp)
bfc01704:	00000000 	nop
bfc01708:	11800025 	beqz	t4,bfc017a0 <memory_game+0x690>
bfc0170c:	00000000 	nop
bfc01710:	8e220000 	lw	v0,0(s1)
bfc01714:	00000000 	nop
bfc01718:	3048f000 	andi	t0,v0,0xf000
bfc0171c:	0008cb02 	srl	t9,t0,0xc
bfc01720:	afb90018 	sw	t9,24(sp)
bfc01724:	8fb80018 	lw	t8,24(sp)
bfc01728:	00000000 	nop
bfc0172c:	1300001d 	beqz	t8,bfc017a4 <memory_game+0x694>
bfc01730:	3c0ebfaf 	lui	t6,0xbfaf
bfc01734:	8e2a0000 	lw	t2,0(s1)
bfc01738:	00000000 	nop
bfc0173c:	3144f000 	andi	a0,t2,0xf000
bfc01740:	0004fb02 	srl	ra,a0,0xc
bfc01744:	afbf0018 	sw	ra,24(sp)
bfc01748:	8fa90018 	lw	t1,24(sp)
bfc0174c:	00000000 	nop
bfc01750:	11200014 	beqz	t1,bfc017a4 <memory_game+0x694>
bfc01754:	3c0ebfaf 	lui	t6,0xbfaf
bfc01758:	8e250000 	lw	a1,0(s1)
bfc0175c:	00000000 	nop
bfc01760:	30a7f000 	andi	a3,a1,0xf000
bfc01764:	00073302 	srl	a2,a3,0xc
bfc01768:	afa60018 	sw	a2,24(sp)
bfc0176c:	8fa30018 	lw	v1,24(sp)
bfc01770:	00000000 	nop
bfc01774:	1060000b 	beqz	v1,bfc017a4 <memory_game+0x694>
bfc01778:	3c0ebfaf 	lui	t6,0xbfaf
bfc0177c:	8e2e0000 	lw	t6,0(s1)
bfc01780:	00000000 	nop
bfc01784:	31cdf000 	andi	t5,t6,0xf000
bfc01788:	000d6302 	srl	t4,t5,0xc
bfc0178c:	afac0018 	sw	t4,24(sp)
bfc01790:	8fab0018 	lw	t3,24(sp)
bfc01794:	00000000 	nop
bfc01798:	1560ffb9 	bnez	t3,bfc01680 <memory_game+0x570>
bfc0179c:	00000000 	nop
bfc017a0:	3c0ebfaf 	lui	t6,0xbfaf
bfc017a4:	35cdf000 	ori	t5,t6,0xf000
bfc017a8:	adb50000 	sw	s5,0(t5)
bfc017ac:	8fac001c 	lw	t4,28(sp)
bfc017b0:	00000000 	nop
bfc017b4:	258b0001 	addiu	t3,t4,1
bfc017b8:	afab001c 	sw	t3,28(sp)
bfc017bc:	8fa5001c 	lw	a1,28(sp)
bfc017c0:	00000000 	nop
bfc017c4:	00053e00 	sll	a3,a1,0x18
bfc017c8:	aee70000 	sw	a3,0(s7)
bfc017cc:	8fa60014 	lw	a2,20(sp)
bfc017d0:	00000000 	nop
bfc017d4:	24ca0001 	addiu	t2,a2,1
bfc017d8:	afaa0014 	sw	t2,20(sp)
bfc017dc:	8fa90014 	lw	t1,20(sp)
bfc017e0:	00000000 	nop
bfc017e4:	29280008 	slti	t0,t1,8
bfc017e8:	1500ff5c 	bnez	t0,bfc0155c <memory_game+0x44c>
bfc017ec:	00000000 	nop
bfc017f0:	3c17bfaf 	lui	s7,0xbfaf
bfc017f4:	36f5e000 	ori	s5,s7,0xe000
bfc017f8:	aea00000 	sw	zero,0(s5)
bfc017fc:	0ff006bb 	jal	bfc01aec <get_us>
bfc01800:	00000000 	nop
bfc01804:	3c180012 	lui	t8,0x12
bfc01808:	370f4f80 	ori	t7,t8,0x4f80
bfc0180c:	004f902a 	slt	s2,v0,t7
bfc01810:	12400032 	beqz	s2,bfc018dc <memory_game+0x7cc>
bfc01814:	3c02bfaf 	lui	v0,0xbfaf
bfc01818:	0ff006bb 	jal	bfc01aec <get_us>
bfc0181c:	00000000 	nop
bfc01820:	3c040012 	lui	a0,0x12
bfc01824:	34894f80 	ori	t1,a0,0x4f80
bfc01828:	0049902a 	slt	s2,v0,t1
bfc0182c:	1240002b 	beqz	s2,bfc018dc <memory_game+0x7cc>
bfc01830:	3c02bfaf 	lui	v0,0xbfaf
bfc01834:	0ff006bb 	jal	bfc01aec <get_us>
bfc01838:	00000000 	nop
bfc0183c:	3c060012 	lui	a2,0x12
bfc01840:	34c34f80 	ori	v1,a2,0x4f80
bfc01844:	0043502a 	slt	t2,v0,v1
bfc01848:	11400024 	beqz	t2,bfc018dc <memory_game+0x7cc>
bfc0184c:	3c02bfaf 	lui	v0,0xbfaf
bfc01850:	0ff006bb 	jal	bfc01aec <get_us>
bfc01854:	00000000 	nop
bfc01858:	3c0b0012 	lui	t3,0x12
bfc0185c:	35654f80 	ori	a1,t3,0x4f80
bfc01860:	0045382a 	slt	a3,v0,a1
bfc01864:	10e0001d 	beqz	a3,bfc018dc <memory_game+0x7cc>
bfc01868:	3c02bfaf 	lui	v0,0xbfaf
bfc0186c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01870:	00000000 	nop
bfc01874:	3c0e0012 	lui	t6,0x12
bfc01878:	35cd4f80 	ori	t5,t6,0x4f80
bfc0187c:	004d602a 	slt	t4,v0,t5
bfc01880:	11800016 	beqz	t4,bfc018dc <memory_game+0x7cc>
bfc01884:	3c02bfaf 	lui	v0,0xbfaf
bfc01888:	0ff006bb 	jal	bfc01aec <get_us>
bfc0188c:	00000000 	nop
bfc01890:	3c0f0012 	lui	t7,0x12
bfc01894:	35f74f80 	ori	s7,t7,0x4f80
bfc01898:	0057a82a 	slt	s5,v0,s7
bfc0189c:	12a0000f 	beqz	s5,bfc018dc <memory_game+0x7cc>
bfc018a0:	3c02bfaf 	lui	v0,0xbfaf
bfc018a4:	0ff006bb 	jal	bfc01aec <get_us>
bfc018a8:	00000000 	nop
bfc018ac:	3c080012 	lui	t0,0x12
bfc018b0:	35194f80 	ori	t9,t0,0x4f80
bfc018b4:	0059c02a 	slt	t8,v0,t9
bfc018b8:	13000008 	beqz	t8,bfc018dc <memory_game+0x7cc>
bfc018bc:	3c02bfaf 	lui	v0,0xbfaf
bfc018c0:	0ff006bb 	jal	bfc01aec <get_us>
bfc018c4:	00000000 	nop
bfc018c8:	3c090012 	lui	t1,0x12
bfc018cc:	35324f80 	ori	s2,t1,0x4f80
bfc018d0:	0052102a 	slt	v0,v0,s2
bfc018d4:	1440ffc9 	bnez	v0,bfc017fc <memory_game+0x6ec>
bfc018d8:	3c02bfaf 	lui	v0,0xbfaf
bfc018dc:	3459e000 	ori	t9,v0,0xe000
bfc018e0:	3c1f0007 	lui	ra,0x7
bfc018e4:	afa0001c 	sw	zero,28(sp)
bfc018e8:	37f2a120 	ori	s2,ra,0xa120
bfc018ec:	ae800000 	sw	zero,0(s4)
bfc018f0:	af200000 	sw	zero,0(t9)
bfc018f4:	0ff006bb 	jal	bfc01aec <get_us>
bfc018f8:	00000000 	nop
bfc018fc:	0052182a 	slt	v1,v0,s2
bfc01900:	10600024 	beqz	v1,bfc01994 <memory_game+0x884>
bfc01904:	3409ffff 	li	t1,0xffff
bfc01908:	0ff006bb 	jal	bfc01aec <get_us>
bfc0190c:	00000000 	nop
bfc01910:	0052a82a 	slt	s5,v0,s2
bfc01914:	12a0001f 	beqz	s5,bfc01994 <memory_game+0x884>
bfc01918:	3409ffff 	li	t1,0xffff
bfc0191c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01920:	00000000 	nop
bfc01924:	0052b82a 	slt	s7,v0,s2
bfc01928:	12e0001a 	beqz	s7,bfc01994 <memory_game+0x884>
bfc0192c:	3409ffff 	li	t1,0xffff
bfc01930:	0ff006bb 	jal	bfc01aec <get_us>
bfc01934:	00000000 	nop
bfc01938:	0052782a 	slt	t7,v0,s2
bfc0193c:	11e00015 	beqz	t7,bfc01994 <memory_game+0x884>
bfc01940:	3409ffff 	li	t1,0xffff
bfc01944:	0ff006bb 	jal	bfc01aec <get_us>
bfc01948:	00000000 	nop
bfc0194c:	0052c02a 	slt	t8,v0,s2
bfc01950:	13000010 	beqz	t8,bfc01994 <memory_game+0x884>
bfc01954:	3409ffff 	li	t1,0xffff
bfc01958:	0ff006bb 	jal	bfc01aec <get_us>
bfc0195c:	00000000 	nop
bfc01960:	0052c82a 	slt	t9,v0,s2
bfc01964:	1320000b 	beqz	t9,bfc01994 <memory_game+0x884>
bfc01968:	3409ffff 	li	t1,0xffff
bfc0196c:	0ff006bb 	jal	bfc01aec <get_us>
bfc01970:	00000000 	nop
bfc01974:	0052102a 	slt	v0,v0,s2
bfc01978:	10400006 	beqz	v0,bfc01994 <memory_game+0x884>
bfc0197c:	3409ffff 	li	t1,0xffff
bfc01980:	0ff006bb 	jal	bfc01aec <get_us>
bfc01984:	00000000 	nop
bfc01988:	0052402a 	slt	t0,v0,s2
bfc0198c:	1500ffd9 	bnez	t0,bfc018f4 <memory_game+0x7e4>
bfc01990:	3409ffff 	li	t1,0xffff
bfc01994:	ae890000 	sw	t1,0(s4)
bfc01998:	afa00018 	sw	zero,24(sp)
bfc0199c:	8fa80018 	lw	t0,24(sp)
bfc019a0:	00000000 	nop
bfc019a4:	29040008 	slti	a0,t0,8
bfc019a8:	1480000e 	bnez	a0,bfc019e4 <memory_game+0x8d4>
bfc019ac:	3c07bfaf 	lui	a3,0xbfaf
bfc019b0:	0bf00692 	j	bfc01a48 <memory_game+0x938>
bfc019b4:	34e4f010 	ori	a0,a3,0xf010
	...
bfc019c0:	8fb90018 	lw	t9,24(sp)
bfc019c4:	00000000 	nop
bfc019c8:	27380001 	addiu	t8,t9,1
bfc019cc:	afb80018 	sw	t8,24(sp)
bfc019d0:	8faf0018 	lw	t7,24(sp)
bfc019d4:	00000000 	nop
bfc019d8:	29f20008 	slti	s2,t7,8
bfc019dc:	12400019 	beqz	s2,bfc01a44 <memory_game+0x934>
bfc019e0:	3c07bfaf 	lui	a3,0xbfaf
bfc019e4:	8fae0018 	lw	t6,24(sp)
bfc019e8:	8fad0018 	lw	t5,24(sp)
bfc019ec:	000e6080 	sll	t4,t6,0x2
bfc019f0:	000d5880 	sll	t3,t5,0x2
bfc019f4:	01962821 	addu	a1,t4,s6
bfc019f8:	017e3821 	addu	a3,t3,s8
bfc019fc:	8ca60000 	lw	a2,0(a1)
bfc01a00:	8cea0000 	lw	t2,0(a3)
bfc01a04:	00000000 	nop
bfc01a08:	14caffed 	bne	a2,t2,bfc019c0 <memory_game+0x8b0>
bfc01a0c:	00000000 	nop
bfc01a10:	8fb7001c 	lw	s7,28(sp)
bfc01a14:	00000000 	nop
bfc01a18:	26f50001 	addiu	s5,s7,1
bfc01a1c:	afb5001c 	sw	s5,28(sp)
bfc01a20:	8fb90018 	lw	t9,24(sp)
bfc01a24:	00000000 	nop
bfc01a28:	27380001 	addiu	t8,t9,1
bfc01a2c:	afb80018 	sw	t8,24(sp)
bfc01a30:	8faf0018 	lw	t7,24(sp)
bfc01a34:	00000000 	nop
bfc01a38:	29f20008 	slti	s2,t7,8
bfc01a3c:	1640ffe9 	bnez	s2,bfc019e4 <memory_game+0x8d4>
bfc01a40:	3c07bfaf 	lui	a3,0xbfaf
bfc01a44:	34e4f010 	ori	a0,a3,0xf010
bfc01a48:	8c830000 	lw	v1,0(a0)
bfc01a4c:	8faa001c 	lw	t2,28(sp)
bfc01a50:	3c06bfaf 	lui	a2,0xbfaf
bfc01a54:	34c8f004 	ori	t0,a2,0xf004
bfc01a58:	01434825 	or	t1,t2,v1
bfc01a5c:	24060001 	li	a2,1
bfc01a60:	ac890000 	sw	t1,0(a0)
bfc01a64:	ad060000 	sw	a2,0(t0)
bfc01a68:	8fa2001c 	lw	v0,28(sp)
bfc01a6c:	241f0008 	li	ra,8
bfc01a70:	105f0006 	beq	v0,ra,bfc01a8c <memory_game+0x97c>
bfc01a74:	3c0ebfaf 	lui	t6,0xbfaf
bfc01a78:	35cdf008 	ori	t5,t6,0xf008
bfc01a7c:	240c0002 	li	t4,2
bfc01a80:	adac0000 	sw	t4,0(t5)
bfc01a84:	0bf0045e 	j	bfc01178 <memory_game+0x68>
bfc01a88:	00000000 	nop
bfc01a8c:	3c0bbfaf 	lui	t3,0xbfaf
bfc01a90:	3565f008 	ori	a1,t3,0xf008
bfc01a94:	aca60000 	sw	a2,0(a1)
bfc01a98:	0bf0045e 	j	bfc01178 <memory_game+0x68>
bfc01a9c:	00000000 	nop

bfc01aa0 <_get_count>:
_get_count():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:14
bfc01aa0:	3c19bfb0 	lui	t9,0xbfb0
bfc01aa4:	8f22e000 	lw	v0,-8192(t9)
bfc01aa8:	03e00008 	jr	ra
bfc01aac:	00000000 	nop

bfc01ab0 <get_count>:
get_count():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:19
bfc01ab0:	3c19bfb0 	lui	t9,0xbfb0
bfc01ab4:	8f22e000 	lw	v0,-8192(t9)
bfc01ab8:	03e00008 	jr	ra
bfc01abc:	00000000 	nop

bfc01ac0 <get_clock>:
get_clock():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:38
bfc01ac0:	3c19bfb0 	lui	t9,0xbfb0
bfc01ac4:	8f22e000 	lw	v0,-8192(t9)
bfc01ac8:	03e00008 	jr	ra
bfc01acc:	00000000 	nop

bfc01ad0 <get_ns>:
_get_count():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:6
bfc01ad0:	3c19bfb0 	lui	t9,0xbfb0
bfc01ad4:	8f22e000 	lw	v0,-8192(t9)
bfc01ad8:	00000000 	nop
bfc01adc:	000218c0 	sll	v1,v0,0x3
bfc01ae0:	00021040 	sll	v0,v0,0x1
get_ns():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:46
bfc01ae4:	03e00008 	jr	ra
bfc01ae8:	00431021 	addu	v0,v0,v1

bfc01aec <get_us>:
_get_count():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:6
bfc01aec:	3c19bfb0 	lui	t9,0xbfb0
bfc01af0:	8f23e000 	lw	v1,-8192(t9)
bfc01af4:	24020064 	li	v0,100
get_us():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:55
bfc01af8:	14400002 	bnez	v0,bfc01b04 <get_us+0x18>
bfc01afc:	0062001b 	divu	zero,v1,v0
bfc01b00:	0007000d 	break	0x7
bfc01b04:	00001012 	mflo	v0
bfc01b08:	03e00008 	jr	ra
bfc01b0c:	00000000 	nop

bfc01b10 <clock_gettime>:
clock_gettime():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:22
bfc01b10:	27bdffe8 	addiu	sp,sp,-24
bfc01b14:	afbf0014 	sw	ra,20(sp)
bfc01b18:	00a05021 	move	t2,a1
_get_count():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:6
bfc01b1c:	3c19bfb0 	lui	t9,0xbfb0
bfc01b20:	8f26e000 	lw	a2,-8192(t9)
clock_gettime():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:27
bfc01b24:	3c030001 	lui	v1,0x1
bfc01b28:	346386a0 	ori	v1,v1,0x86a0
bfc01b2c:	14600002 	bnez	v1,bfc01b38 <clock_gettime+0x28>
bfc01b30:	00c3001b 	divu	zero,a2,v1
bfc01b34:	0007000d 	break	0x7
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:26
bfc01b38:	24080064 	li	t0,100
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:28
bfc01b3c:	3c054876 	lui	a1,0x4876
bfc01b40:	34a5e800 	ori	a1,a1,0xe800
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:25
bfc01b44:	000610c0 	sll	v0,a2,0x3
bfc01b48:	00063840 	sll	a3,a2,0x1
bfc01b4c:	00e23821 	addu	a3,a3,v0
bfc01b50:	240203e8 	li	v0,1000
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:29
bfc01b54:	3c04bfc0 	lui	a0,0xbfc0
bfc01b58:	24842030 	addiu	a0,a0,8240
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:27
bfc01b5c:	00001812 	mflo	v1
bfc01b60:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:26
bfc01b64:	15000002 	bnez	t0,bfc01b70 <clock_gettime+0x60>
bfc01b68:	00c8001b 	divu	zero,a2,t0
bfc01b6c:	0007000d 	break	0x7
bfc01b70:	00004012 	mflo	t0
bfc01b74:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:28
bfc01b78:	14a00002 	bnez	a1,bfc01b84 <clock_gettime+0x74>
bfc01b7c:	00c5001b 	divu	zero,a2,a1
bfc01b80:	0007000d 	break	0x7
bfc01b84:	00003012 	mflo	a2
bfc01b88:	ad460000 	sw	a2,0(t2)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:27
bfc01b8c:	14400002 	bnez	v0,bfc01b98 <clock_gettime+0x88>
bfc01b90:	0062001b 	divu	zero,v1,v0
bfc01b94:	0007000d 	break	0x7
bfc01b98:	00004810 	mfhi	t1
bfc01b9c:	ad49000c 	sw	t1,12(t2)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:25
bfc01ba0:	14400002 	bnez	v0,bfc01bac <clock_gettime+0x9c>
bfc01ba4:	00e2001b 	divu	zero,a3,v0
bfc01ba8:	0007000d 	break	0x7
bfc01bac:	00002810 	mfhi	a1
bfc01bb0:	ad450004 	sw	a1,4(t2)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:26
bfc01bb4:	14400002 	bnez	v0,bfc01bc0 <clock_gettime+0xb0>
bfc01bb8:	0102001b 	divu	zero,t0,v0
bfc01bbc:	0007000d 	break	0x7
bfc01bc0:	00001810 	mfhi	v1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:29
bfc01bc4:	0ff006f8 	jal	bfc01be0 <printf>
bfc01bc8:	ad430008 	sw	v1,8(t2)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/time.c:31
bfc01bcc:	8fbf0014 	lw	ra,20(sp)
bfc01bd0:	00001021 	move	v0,zero
bfc01bd4:	03e00008 	jr	ra
bfc01bd8:	27bd0018 	addiu	sp,sp,24
bfc01bdc:	00000000 	nop

bfc01be0 <printf>:
printf():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:2
bfc01be0:	27bdffc8 	addiu	sp,sp,-56
bfc01be4:	afb30024 	sw	s3,36(sp)
bfc01be8:	afbf0034 	sw	ra,52(sp)
bfc01bec:	afb60030 	sw	s6,48(sp)
bfc01bf0:	afb5002c 	sw	s5,44(sp)
bfc01bf4:	afb40028 	sw	s4,40(sp)
bfc01bf8:	afb20020 	sw	s2,32(sp)
bfc01bfc:	afb1001c 	sw	s1,28(sp)
bfc01c00:	afb00018 	sw	s0,24(sp)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:10
bfc01c04:	80900000 	lb	s0,0(a0)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:2
bfc01c08:	00809821 	move	s3,a0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:8
bfc01c0c:	27a4003c 	addiu	a0,sp,60
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:2
bfc01c10:	afa5003c 	sw	a1,60(sp)
bfc01c14:	afa60040 	sw	a2,64(sp)
bfc01c18:	afa70044 	sw	a3,68(sp)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:10
bfc01c1c:	12000013 	beqz	s0,bfc01c6c <printf+0x8c>
bfc01c20:	afa40010 	sw	a0,16(sp)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:17
bfc01c24:	3c02bfc0 	lui	v0,0xbfc0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:9
bfc01c28:	00809021 	move	s2,a0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:17
bfc01c2c:	24562050 	addiu	s6,v0,8272
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:9
bfc01c30:	00008821 	move	s1,zero
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:13
bfc01c34:	24140025 	li	s4,37
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:79
bfc01c38:	2415000a 	li	s5,10
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:13
bfc01c3c:	12140016 	beq	s0,s4,bfc01c98 <printf+0xb8>
bfc01c40:	02711021 	addu	v0,s3,s1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:79
bfc01c44:	1215002f 	beq	s0,s5,bfc01d04 <printf+0x124>
bfc01c48:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:80
bfc01c4c:	0ff00791 	jal	bfc01e44 <putchar>
bfc01c50:	02002021 	move	a0,s0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:10
bfc01c54:	26310001 	addiu	s1,s1,1
bfc01c58:	02711021 	addu	v0,s3,s1
bfc01c5c:	80500000 	lb	s0,0(v0)
bfc01c60:	00000000 	nop
bfc01c64:	1600fff5 	bnez	s0,bfc01c3c <printf+0x5c>
bfc01c68:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:84
bfc01c6c:	8fbf0034 	lw	ra,52(sp)
bfc01c70:	00001021 	move	v0,zero
bfc01c74:	8fb60030 	lw	s6,48(sp)
bfc01c78:	8fb5002c 	lw	s5,44(sp)
bfc01c7c:	8fb40028 	lw	s4,40(sp)
bfc01c80:	8fb30024 	lw	s3,36(sp)
bfc01c84:	8fb20020 	lw	s2,32(sp)
bfc01c88:	8fb1001c 	lw	s1,28(sp)
bfc01c8c:	8fb00018 	lw	s0,24(sp)
bfc01c90:	03e00008 	jr	ra
bfc01c94:	27bd0038 	addiu	sp,sp,56
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:13
bfc01c98:	80440001 	lb	a0,1(v0)
bfc01c9c:	24050001 	li	a1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:17
bfc01ca0:	2482ffdb 	addiu	v0,a0,-37
bfc01ca4:	304200ff 	andi	v0,v0,0xff
bfc01ca8:	2c430054 	sltiu	v1,v0,84
bfc01cac:	14600005 	bnez	v1,bfc01cc4 <printf+0xe4>
bfc01cb0:	00021080 	sll	v0,v0,0x2
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:73
bfc01cb4:	0ff00791 	jal	bfc01e44 <putchar>
bfc01cb8:	24040025 	li	a0,37
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:10
bfc01cbc:	0bf00716 	j	bfc01c58 <printf+0x78>
bfc01cc0:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:17
bfc01cc4:	02c21021 	addu	v0,s6,v0
bfc01cc8:	8c430000 	lw	v1,0(v0)
bfc01ccc:	00000000 	nop
bfc01cd0:	00600008 	jr	v1
bfc01cd4:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:65
bfc01cd8:	26310001 	addiu	s1,s1,1
bfc01cdc:	02711021 	addu	v0,s3,s1
bfc01ce0:	80440001 	lb	a0,1(v0)
bfc01ce4:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:67
bfc01ce8:	2482ffcf 	addiu	v0,a0,-49
bfc01cec:	304200ff 	andi	v0,v0,0xff
bfc01cf0:	2c420009 	sltiu	v0,v0,9
bfc01cf4:	1440003f 	bnez	v0,bfc01df4 <printf+0x214>
bfc01cf8:	00002821 	move	a1,zero
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:17
bfc01cfc:	0bf00729 	j	bfc01ca4 <printf+0xc4>
bfc01d00:	2482ffdb 	addiu	v0,a0,-37
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:79
bfc01d04:	0ff00791 	jal	bfc01e44 <putchar>
bfc01d08:	2404000d 	li	a0,13
bfc01d0c:	0bf00713 	j	bfc01c4c <printf+0x6c>
bfc01d10:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:30
bfc01d14:	8e440000 	lw	a0,0(s2)
bfc01d18:	2406000a 	li	a2,10
bfc01d1c:	0ff007cc 	jal	bfc01f30 <printbase>
bfc01d20:	00003821 	move	a3,zero
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:31
bfc01d24:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:32
bfc01d28:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01d2c:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:20
bfc01d30:	8e440000 	lw	a0,0(s2)
bfc01d34:	0ff0079c 	jal	bfc01e70 <putstring>
bfc01d38:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:21
bfc01d3c:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01d40:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:56
bfc01d44:	8e440000 	lw	a0,0(s2)
bfc01d48:	24060010 	li	a2,16
bfc01d4c:	0ff007cc 	jal	bfc01f30 <printbase>
bfc01d50:	00003821 	move	a3,zero
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:57
bfc01d54:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:58
bfc01d58:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01d5c:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:45
bfc01d60:	8e440000 	lw	a0,0(s2)
bfc01d64:	24060008 	li	a2,8
bfc01d68:	0ff007cc 	jal	bfc01f30 <printbase>
bfc01d6c:	00003821 	move	a3,zero
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:46
bfc01d70:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:47
bfc01d74:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01d78:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:40
bfc01d7c:	8e440000 	lw	a0,0(s2)
bfc01d80:	2406000a 	li	a2,10
bfc01d84:	0ff007cc 	jal	bfc01f30 <printbase>
bfc01d88:	00003821 	move	a3,zero
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:41
bfc01d8c:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:42
bfc01d90:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01d94:	26310002 	addiu	s1,s1,2
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:35
bfc01d98:	8e440000 	lw	a0,0(s2)
bfc01d9c:	2406000a 	li	a2,10
bfc01da0:	0ff007cc 	jal	bfc01f30 <printbase>
bfc01da4:	24070001 	li	a3,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:36
bfc01da8:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:37
bfc01dac:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01db0:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:25
bfc01db4:	8e440000 	lw	a0,0(s2)
bfc01db8:	0ff00791 	jal	bfc01e44 <putchar>
bfc01dbc:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:26
bfc01dc0:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01dc4:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:50
bfc01dc8:	8e440000 	lw	a0,0(s2)
bfc01dcc:	24060002 	li	a2,2
bfc01dd0:	0ff007cc 	jal	bfc01f30 <printbase>
bfc01dd4:	00003821 	move	a3,zero
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:51
bfc01dd8:	26520004 	addiu	s2,s2,4
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:52
bfc01ddc:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01de0:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:61
bfc01de4:	0ff00791 	jal	bfc01e44 <putchar>
bfc01de8:	24040025 	li	a0,37
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:62
bfc01dec:	0bf00715 	j	bfc01c54 <printf+0x74>
bfc01df0:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:67
bfc01df4:	02713021 	addu	a2,s3,s1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:68
bfc01df8:	000510c0 	sll	v0,a1,0x3
bfc01dfc:	00051840 	sll	v1,a1,0x1
bfc01e00:	00621821 	addu	v1,v1,v0
bfc01e04:	00641821 	addu	v1,v1,a0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:67
bfc01e08:	80c40002 	lb	a0,2(a2)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:68
bfc01e0c:	2465ffd0 	addiu	a1,v1,-48
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:67
bfc01e10:	2482ffcf 	addiu	v0,a0,-49
bfc01e14:	304200ff 	andi	v0,v0,0xff
bfc01e18:	2c420009 	sltiu	v0,v0,9
bfc01e1c:	26310001 	addiu	s1,s1,1
bfc01e20:	1040ff9f 	beqz	v0,bfc01ca0 <printf+0xc0>
bfc01e24:	24c60001 	addiu	a2,a2,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printf.c:68
bfc01e28:	0bf0077f 	j	bfc01dfc <printf+0x21c>
bfc01e2c:	000510c0 	sll	v0,a1,0x3

bfc01e30 <tgt_putchar>:
tgt_putchar():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/putchar.c:9
bfc01e30:	3c19bfb0 	lui	t9,0xbfb0
bfc01e34:	03e00008 	jr	ra
bfc01e38:	a324fff0 	sb	a0,-16(t9)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/putchar.c:18
bfc01e3c:	03e00008 	jr	ra
bfc01e40:	00000000 	nop

bfc01e44 <putchar>:
putchar():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/putchar.c:2
bfc01e44:	27bdffe8 	addiu	sp,sp,-24
bfc01e48:	afbf0014 	sw	ra,20(sp)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/putchar.c:3
bfc01e4c:	0ff0078c 	jal	bfc01e30 <tgt_putchar>
bfc01e50:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/putchar.c:5
bfc01e54:	8fbf0014 	lw	ra,20(sp)
bfc01e58:	00001021 	move	v0,zero
bfc01e5c:	03e00008 	jr	ra
bfc01e60:	27bd0018 	addiu	sp,sp,24
	...

bfc01e70 <putstring>:
putstring():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:2
bfc01e70:	27bdffe0 	addiu	sp,sp,-32
bfc01e74:	afb10014 	sw	s1,20(sp)
bfc01e78:	afbf001c 	sw	ra,28(sp)
bfc01e7c:	afb20018 	sw	s2,24(sp)
bfc01e80:	afb00010 	sw	s0,16(sp)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:4
bfc01e84:	80900000 	lb	s0,0(a0)
bfc01e88:	00000000 	nop
bfc01e8c:	12000013 	beqz	s0,bfc01edc <putstring+0x6c>
bfc01e90:	00808821 	move	s1,a0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:6
bfc01e94:	0bf007ad 	j	bfc01eb4 <putstring+0x44>
bfc01e98:	2412000a 	li	s2,10
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:7
bfc01e9c:	0ff00791 	jal	bfc01e44 <putchar>
bfc01ea0:	02002021 	move	a0,s0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:4
bfc01ea4:	82300000 	lb	s0,0(s1)
bfc01ea8:	00000000 	nop
bfc01eac:	1200000b 	beqz	s0,bfc01edc <putstring+0x6c>
bfc01eb0:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:6
bfc01eb4:	1612fff9 	bne	s0,s2,bfc01e9c <putstring+0x2c>
bfc01eb8:	26310001 	addiu	s1,s1,1
bfc01ebc:	0ff00791 	jal	bfc01e44 <putchar>
bfc01ec0:	2404000d 	li	a0,13
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:7
bfc01ec4:	0ff00791 	jal	bfc01e44 <putchar>
bfc01ec8:	02002021 	move	a0,s0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:4
bfc01ecc:	82300000 	lb	s0,0(s1)
bfc01ed0:	00000000 	nop
bfc01ed4:	1600fff7 	bnez	s0,bfc01eb4 <putstring+0x44>
bfc01ed8:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:11
bfc01edc:	8fbf001c 	lw	ra,28(sp)
bfc01ee0:	00001021 	move	v0,zero
bfc01ee4:	8fb20018 	lw	s2,24(sp)
bfc01ee8:	8fb10014 	lw	s1,20(sp)
bfc01eec:	8fb00010 	lw	s0,16(sp)
bfc01ef0:	03e00008 	jr	ra
bfc01ef4:	27bd0020 	addiu	sp,sp,32

bfc01ef8 <puts>:
puts():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:15
bfc01ef8:	27bdffe8 	addiu	sp,sp,-24
bfc01efc:	afbf0014 	sw	ra,20(sp)
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:16
bfc01f00:	0ff0079c 	jal	bfc01e70 <putstring>
bfc01f04:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:17
bfc01f08:	0ff00791 	jal	bfc01e44 <putchar>
bfc01f0c:	2404000d 	li	a0,13
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:18
bfc01f10:	0ff00791 	jal	bfc01e44 <putchar>
bfc01f14:	2404000a 	li	a0,10
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/puts.c:20
bfc01f18:	8fbf0014 	lw	ra,20(sp)
bfc01f1c:	00001021 	move	v0,zero
bfc01f20:	03e00008 	jr	ra
bfc01f24:	27bd0018 	addiu	sp,sp,24
	...

bfc01f30 <printbase>:
printbase():
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:2
bfc01f30:	27bdff98 	addiu	sp,sp,-104
bfc01f34:	afb30060 	sw	s3,96(sp)
bfc01f38:	afb2005c 	sw	s2,92(sp)
bfc01f3c:	afbf0064 	sw	ra,100(sp)
bfc01f40:	afb10058 	sw	s1,88(sp)
bfc01f44:	afb00054 	sw	s0,84(sp)
bfc01f48:	00801821 	move	v1,a0
bfc01f4c:	00a09821 	move	s3,a1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:7
bfc01f50:	10e00003 	beqz	a3,bfc01f60 <printbase+0x30>
bfc01f54:	00c09021 	move	s2,a2
bfc01f58:	0480002f 	bltz	a0,bfc02018 <printbase+0xe8>
bfc01f5c:	2404002d 	li	a0,45
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:12
bfc01f60:	00608021 	move	s0,v1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:14
bfc01f64:	1200000c 	beqz	s0,bfc01f98 <printbase+0x68>
bfc01f68:	00008821 	move	s1,zero
bfc01f6c:	27a50010 	addiu	a1,sp,16
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:16
bfc01f70:	16400002 	bnez	s2,bfc01f7c <printbase+0x4c>
bfc01f74:	0212001b 	divu	zero,s0,s2
bfc01f78:	0007000d 	break	0x7
bfc01f7c:	00b12021 	addu	a0,a1,s1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:14
bfc01f80:	26310001 	addiu	s1,s1,1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:16
bfc01f84:	00001010 	mfhi	v0
bfc01f88:	a0820000 	sb	v0,0(a0)
bfc01f8c:	00001812 	mflo	v1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:14
bfc01f90:	1460fff7 	bnez	v1,bfc01f70 <printbase+0x40>
bfc01f94:	00608021 	move	s0,v1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:22
bfc01f98:	0233102a 	slt	v0,s1,s3
bfc01f9c:	10400002 	beqz	v0,bfc01fa8 <printbase+0x78>
bfc01fa0:	02201821 	move	v1,s1
bfc01fa4:	02601821 	move	v1,s3
bfc01fa8:	1060000c 	beqz	v1,bfc01fdc <printbase+0xac>
bfc01fac:	2470ffff 	addiu	s0,v1,-1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:2
bfc01fb0:	27a20010 	addiu	v0,sp,16
bfc01fb4:	00509021 	addu	s2,v0,s0
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:24
bfc01fb8:	26020001 	addiu	v0,s0,1
bfc01fbc:	0222102a 	slt	v0,s1,v0
bfc01fc0:	1040000e 	beqz	v0,bfc01ffc <printbase+0xcc>
bfc01fc4:	24040030 	li	a0,48
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:25
bfc01fc8:	02009821 	move	s3,s0
bfc01fcc:	0ff00791 	jal	bfc01e44 <putchar>
bfc01fd0:	2610ffff 	addiu	s0,s0,-1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:22
bfc01fd4:	1660fff8 	bnez	s3,bfc01fb8 <printbase+0x88>
bfc01fd8:	2652ffff 	addiu	s2,s2,-1
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:28
bfc01fdc:	8fbf0064 	lw	ra,100(sp)
bfc01fe0:	00001021 	move	v0,zero
bfc01fe4:	8fb30060 	lw	s3,96(sp)
bfc01fe8:	8fb2005c 	lw	s2,92(sp)
bfc01fec:	8fb10058 	lw	s1,88(sp)
bfc01ff0:	8fb00054 	lw	s0,84(sp)
bfc01ff4:	03e00008 	jr	ra
bfc01ff8:	27bd0068 	addiu	sp,sp,104
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:24
bfc01ffc:	82440000 	lb	a0,0(s2)
bfc02000:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:25
bfc02004:	2882000a 	slti	v0,a0,10
bfc02008:	14400007 	bnez	v0,bfc02028 <printbase+0xf8>
bfc0200c:	02009821 	move	s3,s0
bfc02010:	0bf007f3 	j	bfc01fcc <printbase+0x9c>
bfc02014:	24840057 	addiu	a0,a0,87
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:10
bfc02018:	0ff00791 	jal	bfc01e44 <putchar>
bfc0201c:	00038023 	negu	s0,v1
bfc02020:	0bf007d9 	j	bfc01f64 <printbase+0x34>
bfc02024:	00000000 	nop
/media/sf_nscscc2018/release_v0.03_dev/func_test_v0.02/soft/memory_game/lib/printbase.c:25
bfc02028:	0bf007f2 	j	bfc01fc8 <printbase+0x98>
bfc0202c:	24840030 	addiu	a0,a0,48

Disassembly of section .data:

bfc02030 <_fdata-0x188>:
bfc02030:	636f6c63 	0x636f6c63
bfc02034:	736e206b 	0x736e206b
bfc02038:	2c64253d 	sltiu	a0,v1,9533
bfc0203c:	3d636573 	0x3d636573
bfc02040:	000a6425 	0xa6425
	...
bfc02050:	bfc01de4 	0xbfc01de4
bfc02054:	bfc01cb4 	0xbfc01cb4
bfc02058:	bfc01cb4 	0xbfc01cb4
bfc0205c:	bfc01cb4 	0xbfc01cb4
bfc02060:	bfc01cb4 	0xbfc01cb4
bfc02064:	bfc01cb4 	0xbfc01cb4
bfc02068:	bfc01cb4 	0xbfc01cb4
bfc0206c:	bfc01cb4 	0xbfc01cb4
bfc02070:	bfc01cb4 	0xbfc01cb4
bfc02074:	bfc01cb4 	0xbfc01cb4
bfc02078:	bfc01cb4 	0xbfc01cb4
bfc0207c:	bfc01cd8 	0xbfc01cd8
bfc02080:	bfc01ce8 	0xbfc01ce8
bfc02084:	bfc01ce8 	0xbfc01ce8
bfc02088:	bfc01ce8 	0xbfc01ce8
bfc0208c:	bfc01ce8 	0xbfc01ce8
bfc02090:	bfc01ce8 	0xbfc01ce8
bfc02094:	bfc01ce8 	0xbfc01ce8
bfc02098:	bfc01ce8 	0xbfc01ce8
bfc0209c:	bfc01ce8 	0xbfc01ce8
bfc020a0:	bfc01ce8 	0xbfc01ce8
bfc020a4:	bfc01cb4 	0xbfc01cb4
bfc020a8:	bfc01cb4 	0xbfc01cb4
bfc020ac:	bfc01cb4 	0xbfc01cb4
bfc020b0:	bfc01cb4 	0xbfc01cb4
bfc020b4:	bfc01cb4 	0xbfc01cb4
bfc020b8:	bfc01cb4 	0xbfc01cb4
bfc020bc:	bfc01cb4 	0xbfc01cb4
bfc020c0:	bfc01cb4 	0xbfc01cb4
bfc020c4:	bfc01cb4 	0xbfc01cb4
bfc020c8:	bfc01cb4 	0xbfc01cb4
bfc020cc:	bfc01cb4 	0xbfc01cb4
bfc020d0:	bfc01cb4 	0xbfc01cb4
bfc020d4:	bfc01cb4 	0xbfc01cb4
bfc020d8:	bfc01cb4 	0xbfc01cb4
bfc020dc:	bfc01cb4 	0xbfc01cb4
bfc020e0:	bfc01cb4 	0xbfc01cb4
bfc020e4:	bfc01cb4 	0xbfc01cb4
bfc020e8:	bfc01cb4 	0xbfc01cb4
bfc020ec:	bfc01cb4 	0xbfc01cb4
bfc020f0:	bfc01cb4 	0xbfc01cb4
bfc020f4:	bfc01cb4 	0xbfc01cb4
bfc020f8:	bfc01cb4 	0xbfc01cb4
bfc020fc:	bfc01cb4 	0xbfc01cb4
bfc02100:	bfc01cb4 	0xbfc01cb4
bfc02104:	bfc01cb4 	0xbfc01cb4
bfc02108:	bfc01cb4 	0xbfc01cb4
bfc0210c:	bfc01cb4 	0xbfc01cb4
bfc02110:	bfc01cb4 	0xbfc01cb4
bfc02114:	bfc01cb4 	0xbfc01cb4
bfc02118:	bfc01cb4 	0xbfc01cb4
bfc0211c:	bfc01cb4 	0xbfc01cb4
bfc02120:	bfc01cb4 	0xbfc01cb4
bfc02124:	bfc01cb4 	0xbfc01cb4
bfc02128:	bfc01cb4 	0xbfc01cb4
bfc0212c:	bfc01cb4 	0xbfc01cb4
bfc02130:	bfc01cb4 	0xbfc01cb4
bfc02134:	bfc01cb4 	0xbfc01cb4
bfc02138:	bfc01cb4 	0xbfc01cb4
bfc0213c:	bfc01cb4 	0xbfc01cb4
bfc02140:	bfc01cb4 	0xbfc01cb4
bfc02144:	bfc01dc8 	0xbfc01dc8
bfc02148:	bfc01db4 	0xbfc01db4
bfc0214c:	bfc01d98 	0xbfc01d98
bfc02150:	bfc01cb4 	0xbfc01cb4
bfc02154:	bfc01cb4 	0xbfc01cb4
bfc02158:	bfc01cb4 	0xbfc01cb4
bfc0215c:	bfc01cb4 	0xbfc01cb4
bfc02160:	bfc01cb4 	0xbfc01cb4
bfc02164:	bfc01cb4 	0xbfc01cb4
bfc02168:	bfc01cb4 	0xbfc01cb4
bfc0216c:	bfc01d7c 	0xbfc01d7c
bfc02170:	bfc01cb4 	0xbfc01cb4
bfc02174:	bfc01cb4 	0xbfc01cb4
bfc02178:	bfc01d60 	0xbfc01d60
bfc0217c:	bfc01d44 	0xbfc01d44
bfc02180:	bfc01cb4 	0xbfc01cb4
bfc02184:	bfc01cb4 	0xbfc01cb4
bfc02188:	bfc01d30 	0xbfc01d30
bfc0218c:	bfc01cb4 	0xbfc01cb4
bfc02190:	bfc01d14 	0xbfc01d14
bfc02194:	bfc01cb4 	0xbfc01cb4
bfc02198:	bfc01cb4 	0xbfc01cb4
bfc0219c:	bfc01d44 	0xbfc01d44
bfc021a0:	3a000600 	xori	zero,s0,0x600
	...

bfc021b8 <_fdata>:
	...

bfc021c0 <__CTOR_LIST__>:
	...

bfc021c8 <__CTOR_END__>:
	...

bfc021d0 <__DTOR_END__>:
__DTOR_END__():
bfc021d0:	00000001 	0x1

Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	0x1c
   4:	00000002 	srl	zero,zero,0x0
   8:	00040000 	sll	zero,a0,0x0
   c:	00000000 	nop
  10:	bfc01aa0 	0xbfc01aa0
  14:	0000013c 	0x13c
	...
  20:	0000001c 	0x1c
  24:	020f0002 	0x20f0002
  28:	00040000 	sll	zero,a0,0x0
  2c:	00000000 	nop
  30:	bfc01be0 	0xbfc01be0
  34:	00000250 	0x250
	...
  40:	0000001c 	0x1c
  44:	02dc0002 	0x2dc0002
  48:	00040000 	sll	zero,a0,0x0
  4c:	00000000 	nop
  50:	bfc01e30 	0xbfc01e30
  54:	00000034 	0x34
	...
  60:	0000001c 	0x1c
  64:	03680002 	0x3680002
  68:	00040000 	sll	zero,a0,0x0
  6c:	00000000 	nop
  70:	bfc01e70 	0xbfc01e70
  74:	000000b8 	0xb8
	...
  80:	0000001c 	0x1c
  84:	04170002 	0x4170002
  88:	00040000 	sll	zero,a0,0x0
  8c:	00000000 	nop
  90:	bfc01f30 	0xbfc01f30
  94:	00000100 	sll	zero,zero,0x4
	...

Disassembly of section .debug_pubnames:

00000000 <.debug_pubnames>:
   0:	00000061 	0x61
   4:	00000002 	srl	zero,zero,0x0
   8:	020f0000 	0x20f0000
   c:	00a70000 	0xa70000
  10:	675f0000 	0x675f0000
  14:	635f7465 	0x635f7465
  18:	746e756f 	jalx	1b9d5bc <data_size+0x1b9d418>
  1c:	0000c400 	sll	t8,zero,0x10
  20:	74656700 	jalx	1959c00 <data_size+0x1959a5c>
  24:	756f635f 	jalx	5bd8d7c <data_size+0x5bd8bd8>
  28:	de00746e 	0xde00746e
  2c:	67000000 	0x67000000
  30:	635f7465 	0x635f7465
  34:	6b636f6c 	0x6b636f6c
  38:	00010600 	sll	zero,at,0x18
  3c:	74656700 	jalx	1959c00 <data_size+0x1959a5c>
  40:	00736e5f 	0x736e5f
  44:	00000152 	0x152
  48:	5f746567 	0x5f746567
  4c:	9c007375 	0x9c007375
  50:	63000001 	0x63000001
  54:	6b636f6c 	0x6b636f6c
  58:	7465675f 	jalx	1959d7c <data_size+0x1959bd8>
  5c:	656d6974 	0x656d6974
  60:	00000000 	nop
  64:	00001900 	sll	v1,zero,0x4
  68:	0f000200 	jal	c000800 <data_size+0xc00065c>
  6c:	cd000002 	lwc3	$0,2(t0)
  70:	35000000 	ori	zero,t0,0x0
  74:	70000000 	0x70000000
  78:	746e6972 	jalx	1b9a5c8 <data_size+0x1b9a424>
  7c:	00000066 	0x66
  80:	002a0000 	0x2a0000
  84:	00020000 	sll	zero,v0,0x0
  88:	000002dc 	0x2dc
  8c:	0000008c 	syscall	0x2
  90:	00000033 	0x33
  94:	5f746774 	0x5f746774
  98:	63747570 	0x63747570
  9c:	00726168 	0x726168
  a0:	00000060 	0x60
  a4:	63747570 	0x63747570
  a8:	00726168 	0x726168
  ac:	00000000 	nop
  b0:	00000025 	move	zero,zero
  b4:	03680002 	0x3680002
  b8:	00af0000 	0xaf0000
  bc:	00330000 	0x330000
  c0:	75700000 	jalx	5c00000 <data_size+0x5bffe5c>
  c4:	72747374 	0x72747374
  c8:	00676e69 	0x676e69
  cc:	00000083 	sra	zero,zero,0x2
  d0:	73747570 	0x73747570
  d4:	00000000 	nop
  d8:	00001c00 	sll	v1,zero,0x10
  dc:	17000200 	bnez	t8,8e0 <data_size+0x73c>
  e0:	fb000004 	0xfb000004
  e4:	33000000 	andi	zero,t8,0x0
  e8:	70000000 	0x70000000
  ec:	746e6972 	jalx	1b9a5c8 <data_size+0x1b9a424>
  f0:	65736162 	0x65736162
  f4:	00000000 	nop
	...

Disassembly of section .pdr:

00000000 <.pdr>:
   0:	bfc00390 	0xbfc00390
	...
  14:	00000008 	jr	zero
  18:	0000001d 	0x1d
  1c:	0000001f 	0x1f
  20:	bfc00500 	0xbfc00500
	...
  34:	00000008 	jr	zero
  38:	0000001d 	0x1d
  3c:	0000001f 	0x1f
  40:	bfc00640 	0xbfc00640
	...
  58:	0000001d 	0x1d
  5c:	0000001f 	0x1f
  60:	bfc00670 	0xbfc00670
	...
  78:	0000001d 	0x1d
  7c:	0000001f 	0x1f
  80:	bfc00680 	0xbfc00680
  84:	80010000 	lb	at,0(zero)
  88:	fffffffc 	0xfffffffc
	...
  94:	00000018 	mult	zero,zero
  98:	0000001d 	0x1d
  9c:	0000001f 	0x1f
  a0:	bfc00760 	0xbfc00760
	...
  b4:	00000008 	jr	zero
  b8:	0000001d 	0x1d
  bc:	0000001f 	0x1f
  c0:	bfc00850 	0xbfc00850
  c4:	80070000 	lb	a3,0(zero)
  c8:	fffffffc 	0xfffffffc
	...
  d4:	00000028 	0x28
  d8:	0000001d 	0x1d
  dc:	0000001f 	0x1f
  e0:	bfc00a60 	0xbfc00a60
  e4:	80ff0000 	lb	ra,0(a3)
  e8:	fffffffc 	0xfffffffc
	...
  f4:	00000048 	0x48
  f8:	0000001d 	0x1d
  fc:	0000001f 	0x1f
 100:	bfc00e30 	0xbfc00e30
 104:	803f0000 	lb	ra,0(at)
 108:	fffffffc 	0xfffffffc
	...
 114:	00000038 	0x38
 118:	0000001d 	0x1d
 11c:	0000001f 	0x1f
 120:	bfc01110 	0xbfc01110
 124:	c0ff0000 	lwc0	$31,0(a3)
 128:	fffffffc 	0xfffffffc
	...
 134:	000000c0 	sll	zero,zero,0x3
 138:	0000001d 	0x1d
 13c:	0000001f 	0x1f
 140:	bfc01aa0 	0xbfc01aa0
	...
 158:	0000001d 	0x1d
 15c:	0000001f 	0x1f
 160:	bfc01ab0 	0xbfc01ab0
	...
 178:	0000001d 	0x1d
 17c:	0000001f 	0x1f
 180:	bfc01ac0 	0xbfc01ac0
	...
 198:	0000001d 	0x1d
 19c:	0000001f 	0x1f
 1a0:	bfc01ad0 	0xbfc01ad0
	...
 1b8:	0000001d 	0x1d
 1bc:	0000001f 	0x1f
 1c0:	bfc01aec 	0xbfc01aec
	...
 1d8:	0000001d 	0x1d
 1dc:	0000001f 	0x1f
 1e0:	bfc01b10 	0xbfc01b10
 1e4:	80000000 	lb	zero,0(zero)
 1e8:	fffffffc 	0xfffffffc
	...
 1f4:	00000018 	mult	zero,zero
 1f8:	0000001d 	0x1d
 1fc:	0000001f 	0x1f
 200:	bfc01be0 	0xbfc01be0
 204:	807f0000 	lb	ra,0(v1)
 208:	fffffffc 	0xfffffffc
	...
 214:	00000038 	0x38
 218:	0000001d 	0x1d
 21c:	0000001f 	0x1f
 220:	bfc01e30 	0xbfc01e30
	...
 238:	0000001d 	0x1d
 23c:	0000001f 	0x1f
 240:	bfc01e44 	0xbfc01e44
 244:	80000000 	lb	zero,0(zero)
 248:	fffffffc 	0xfffffffc
	...
 254:	00000018 	mult	zero,zero
 258:	0000001d 	0x1d
 25c:	0000001f 	0x1f
 260:	bfc01e70 	0xbfc01e70
 264:	80070000 	lb	a3,0(zero)
 268:	fffffffc 	0xfffffffc
	...
 274:	00000020 	add	zero,zero,zero
 278:	0000001d 	0x1d
 27c:	0000001f 	0x1f
 280:	bfc01ef8 	0xbfc01ef8
 284:	80000000 	lb	zero,0(zero)
 288:	fffffffc 	0xfffffffc
	...
 294:	00000018 	mult	zero,zero
 298:	0000001d 	0x1d
 29c:	0000001f 	0x1f
 2a0:	bfc01f30 	0xbfc01f30
 2a4:	800f0000 	lb	t7,0(zero)
 2a8:	fffffffc 	0xfffffffc
	...
 2b4:	00000068 	0x68
 2b8:	0000001d 	0x1d
 2bc:	0000001f 	0x1f

Disassembly of section .comment:

00000000 <.comment>:
   0:	43434700 	c0	0x1434700
   4:	4728203a 	c1	0x128203a
   8:	2029554e 	addi	t1,at,21838
   c:	2e332e34 	sltiu	s3,s1,11828
  10:	47000030 	c1	0x1000030
  14:	203a4343 	addi	k0,at,17219
  18:	554e4728 	0x554e4728
  1c:	2e342029 	sltiu	s4,s1,8233
  20:	00302e33 	0x302e33
  24:	43434700 	c0	0x1434700
  28:	4728203a 	c1	0x128203a
  2c:	2029554e 	addi	t1,at,21838
  30:	2e332e34 	sltiu	s3,s1,11828
  34:	47000030 	c1	0x1000030
  38:	203a4343 	addi	k0,at,17219
  3c:	554e4728 	0x554e4728
  40:	2e342029 	sltiu	s4,s1,8233
  44:	00302e33 	0x302e33
  48:	43434700 	c0	0x1434700
  4c:	4728203a 	c1	0x128203a
  50:	2029554e 	addi	t1,at,21838
  54:	2e332e34 	sltiu	s3,s1,11828
  58:	47000030 	c1	0x1000030
  5c:	203a4343 	addi	k0,at,17219
  60:	554e4728 	0x554e4728
  64:	2e342029 	sltiu	s4,s1,8233
  68:	00302e33 	0x302e33

Disassembly of section .gnu.attributes:

00000000 <.gnu.attributes>:
   0:	00000f41 	0xf41
   4:	756e6700 	jalx	5b99c00 <data_size+0x5b99a5c>
   8:	00070100 	sll	zero,a3,0x4
   c:	03040000 	0x3040000

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	25011101 	addiu	at,t0,4353
   4:	030b130e 	0x30b130e
   8:	110e1b0e 	beq	t0,t6,6c44 <data_size+0x6aa0>
   c:	10011201 	beq	zero,at,4814 <data_size+0x4670>
  10:	02000006 	srlv	zero,zero,s0
  14:	0b0b0024 	j	c2c0090 <data_size+0xc2bfeec>
  18:	0e030b3e 	jal	80c2cf8 <data_size+0x80c2b54>
  1c:	16030000 	bne	s0,v1,20 <data_size-0x184>
  20:	3a0e0300 	xori	t6,s0,0x300
  24:	490b3b0b 	0x490b3b0b
  28:	04000013 	bltz	zero,78 <data_size-0x12c>
  2c:	0b0b0024 	j	c2c0090 <data_size+0xc2bfeec>
  30:	08030b3e 	j	c2cf8 <data_size+0xc2b54>
  34:	13050000 	beq	t8,a1,38 <data_size-0x16c>
  38:	0b0e0301 	j	c380c04 <data_size+0xc380a60>
  3c:	3b0b3a0b 	xori	t3,t8,0x3a0b
  40:	0013010b 	0x13010b
  44:	000d0600 	sll	zero,t5,0x18
  48:	0b3a0e03 	j	ce8380c <data_size+0xce83668>
  4c:	13490b3b 	beq	k0,t1,2d3c <data_size+0x2b98>
  50:	00000a38 	0xa38
  54:	3f012e07 	0x3f012e07
  58:	3a0e030c 	xori	t6,s0,0x30c
  5c:	490b3b0b 	0x490b3b0b
  60:	010b2013 	0x10b2013
  64:	08000013 	j	4c <data_size-0x158>
  68:	0e030034 	jal	80c00d0 <data_size+0x80bff2c>
  6c:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
  70:	00001349 	0x1349
  74:	31012e09 	andi	at,t0,0x2e09
  78:	12011113 	beq	s0,at,44c8 <data_size+0x4324>
  7c:	06408101 	bltz	s2,fffe0484 <_stack+0x403ce2ec>
  80:	13010a40 	beq	t8,at,2984 <data_size+0x27e0>
  84:	340a0000 	li	t2,0x0
  88:	00133100 	sll	a2,s3,0x4
  8c:	002e0b00 	0x2e0b00
  90:	0e030c3f 	jal	80c30fc <data_size+0x80c2f58>
  94:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
  98:	01111349 	0x1111349
  9c:	40810112 	0x40810112
  a0:	000a4006 	srlv	t0,t2,zero
  a4:	012e0c00 	0x12e0c00
  a8:	0e030c3f 	jal	80c30fc <data_size+0x80c2f58>
  ac:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
  b0:	01111349 	0x1111349
  b4:	40810112 	0x40810112
  b8:	010a4006 	srlv	t0,t2,t0
  bc:	0d000013 	jal	400004c <data_size+0x3fffea8>
  c0:	08030034 	j	c00d0 <data_size+0xbff2c>
  c4:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
  c8:	00001349 	0x1349
  cc:	3f012e0e 	0x3f012e0e
  d0:	3a0e030c 	xori	t6,s0,0x30c
  d4:	270b3b0b 	addiu	t3,t8,15115
  d8:	1113490c 	beq	t0,s3,1250c <data_size+0x12368>
  dc:	81011201 	lb	at,4609(t0)
  e0:	0a400640 	j	9001900 <data_size+0x900175c>
  e4:	00001301 	0x1301
  e8:	0300340f 	0x300340f
  ec:	3b0b3a08 	xori	t3,t8,0x3a08
  f0:	0213490b 	0x213490b
  f4:	10000006 	b	110 <data_size-0x94>
  f8:	1331011d 	beq	t9,s1,570 <data_size+0x3cc>
  fc:	01120111 	0x1120111
 100:	0b590b58 	j	d642d60 <data_size+0xd642bbc>
 104:	0b110000 	j	c440000 <data_size+0xc43fe5c>
 108:	12011101 	beq	s0,at,4510 <data_size+0x436c>
 10c:	12000001 	beqz	s0,114 <data_size-0x90>
 110:	08030034 	j	c00d0 <data_size+0xbff2c>
 114:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
 118:	0a021349 	j	8084d24 <data_size+0x8084b80>
 11c:	2e130000 	sltiu	s3,s0,0
 120:	030c3f01 	0x30c3f01
 124:	3b0b3a0e 	xori	t3,t8,0x3a0e
 128:	490c270b 	0x490c270b
 12c:	12011113 	beq	s0,at,457c <data_size+0x43d8>
 130:	06408101 	bltz	s2,fffe0538 <_stack+0x403ce3a0>
 134:	13010640 	beq	t8,at,1a38 <data_size+0x1894>
 138:	05140000 	0x5140000
 13c:	3a080300 	xori	t0,s0,0x300
 140:	490b3b0b 	0x490b3b0b
 144:	00060213 	0x60213
 148:	000f1500 	sll	v0,t7,0x14
 14c:	13490b0b 	beq	k0,t1,2d7c <data_size+0x2bd8>
 150:	01000000 	0x1000000
 154:	0e250111 	jal	8940444 <data_size+0x89402a0>
 158:	0e030b13 	jal	80c2c4c <data_size+0x80c2aa8>
 15c:	01110e1b 	0x1110e1b
 160:	06100112 	bltzal	s0,5ac <data_size+0x408>
 164:	0f020000 	jal	c080000 <data_size+0xc07fe5c>
 168:	000b0b00 	sll	at,t3,0xc
 16c:	00240300 	0x240300
 170:	0b3e0b0b 	j	cf82c2c <data_size+0xcf82a88>
 174:	00000e03 	sra	at,zero,0x18
 178:	3f012e04 	0x3f012e04
 17c:	3a0e030c 	xori	t6,s0,0x30c
 180:	270b3b0b 	addiu	t3,t8,15115
 184:	1113490c 	beq	t0,s3,125b8 <data_size+0x12414>
 188:	81011201 	lb	at,4609(t0)
 18c:	06400640 	bltz	s2,1a90 <data_size+0x18ec>
 190:	00001301 	0x1301
 194:	03000505 	0x3000505
 198:	3b0b3a08 	xori	t3,t8,0x3a08
 19c:	0213490b 	0x213490b
 1a0:	06000006 	bltz	s0,1bc <data_size+0x18>
 1a4:	00000018 	mult	zero,zero
 1a8:	03003407 	0x3003407
 1ac:	3b0b3a08 	xori	t3,t8,0x3a08
 1b0:	0213490b 	0x213490b
 1b4:	08000006 	j	18 <data_size-0x18c>
 1b8:	08030034 	j	c00d0 <data_size+0xbff2c>
 1bc:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
 1c0:	00001349 	0x1349
 1c4:	03003409 	0x3003409
 1c8:	3b0b3a08 	xori	t3,t8,0x3a08
 1cc:	0213490b 	0x213490b
 1d0:	0a00000a 	j	8000028 <data_size+0x7fffe84>
 1d4:	0e03000a 	jal	80c0028 <data_size+0x80bfe84>
 1d8:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
 1dc:	240b0000 	li	t3,0
 1e0:	3e0b0b00 	0x3e0b0b00
 1e4:	0008030b 	0x8030b
 1e8:	000f0c00 	sll	at,t7,0x10
 1ec:	13490b0b 	beq	k0,t1,2e1c <data_size+0x2c78>
 1f0:	260d0000 	addiu	t5,s0,0
 1f4:	00134900 	sll	t1,s3,0x4
 1f8:	11010000 	beq	t0,at,1fc <data_size+0x58>
 1fc:	130e2501 	beq	t8,t6,9604 <data_size+0x9460>
 200:	1b0e030b 	0x1b0e030b
 204:	1201110e 	beq	s0,at,4640 <data_size+0x449c>
 208:	00061001 	0x61001
 20c:	00240200 	0x240200
 210:	0b3e0b0b 	j	cf82c2c <data_size+0xcf82a88>
 214:	00000e03 	sra	at,zero,0x18
 218:	3f012e03 	0x3f012e03
 21c:	3a0e030c 	xori	t6,s0,0x30c
 220:	110b3b0b 	beq	t0,t3,ee50 <data_size+0xecac>
 224:	81011201 	lb	at,4609(t0)
 228:	0a400640 	j	9001900 <data_size+0x900175c>
 22c:	00001301 	0x1301
 230:	03000504 	0x3000504
 234:	3b0b3a08 	xori	t3,t8,0x3a08
 238:	0213490b 	0x213490b
 23c:	0500000a 	bltz	t0,268 <data_size+0xc4>
 240:	0b0b0024 	j	c2c0090 <data_size+0xc2bfeec>
 244:	08030b3e 	j	c2cf8 <data_size+0xc2b54>
 248:	2e060000 	sltiu	a2,s0,0
 24c:	030c3f01 	0x30c3f01
 250:	3b0b3a0e 	xori	t3,t8,0x3a0e
 254:	490c270b 	0x490c270b
 258:	12011113 	beq	s0,at,46a8 <data_size+0x4504>
 25c:	06408101 	bltz	s2,fffe0664 <_stack+0x403ce4cc>
 260:	00000640 	sll	zero,zero,0x19
 264:	03000507 	0x3000507
 268:	3b0b3a08 	xori	t3,t8,0x3a08
 26c:	0213490b 	0x213490b
 270:	00000006 	srlv	zero,zero,zero
 274:	25011101 	addiu	at,t0,4353
 278:	030b130e 	0x30b130e
 27c:	110e1b0e 	beq	t0,t6,6eb8 <data_size+0x6d14>
 280:	10011201 	beq	zero,at,4a88 <data_size+0x48e4>
 284:	02000006 	srlv	zero,zero,s0
 288:	0b0b0024 	j	c2c0090 <data_size+0xc2bfeec>
 28c:	0e030b3e 	jal	80c2cf8 <data_size+0x80c2b54>
 290:	2e030000 	sltiu	v1,s0,0
 294:	030c3f01 	0x30c3f01
 298:	3b0b3a0e 	xori	t3,t8,0x3a0e
 29c:	490c270b 	0x490c270b
 2a0:	12011113 	beq	s0,at,46f0 <data_size+0x454c>
 2a4:	06408101 	bltz	s2,fffe06ac <_stack+0x403ce514>
 2a8:	13010640 	beq	t8,at,1bac <data_size+0x1a08>
 2ac:	05040000 	0x5040000
 2b0:	3a080300 	xori	t0,s0,0x300
 2b4:	490b3b0b 	0x490b3b0b
 2b8:	00060213 	0x60213
 2bc:	00340500 	0x340500
 2c0:	0b3a0803 	j	ce8200c <data_size+0xce81e68>
 2c4:	13490b3b 	beq	k0,t1,2fb4 <data_size+0x2e10>
 2c8:	00000602 	srl	zero,zero,0x18
 2cc:	0b002406 	j	c009018 <data_size+0xc008e74>
 2d0:	030b3e0b 	0x30b3e0b
 2d4:	07000008 	bltz	t8,2f8 <data_size+0x154>
 2d8:	0b0b000f 	j	c2c003c <data_size+0xc2bfe98>
 2dc:	00001349 	0x1349
 2e0:	3f012e08 	0x3f012e08
 2e4:	3a0e030c 	xori	t6,s0,0x30c
 2e8:	270b3b0b 	addiu	t3,t8,15115
 2ec:	1113490c 	beq	t0,s3,12720 <data_size+0x1257c>
 2f0:	81011201 	lb	at,4609(t0)
 2f4:	06400640 	bltz	s2,1bf8 <data_size+0x1a54>
 2f8:	01000000 	0x1000000
 2fc:	0e250111 	jal	8940444 <data_size+0x89402a0>
 300:	0e030b13 	jal	80c2c4c <data_size+0x80c2aa8>
 304:	01110e1b 	0x1110e1b
 308:	06100112 	bltzal	s0,754 <data_size+0x5b0>
 30c:	24020000 	li	v0,0
 310:	3e0b0b00 	0x3e0b0b00
 314:	000e030b 	0xe030b
 318:	012e0300 	0x12e0300
 31c:	0e030c3f 	jal	80c30fc <data_size+0x80c2f58>
 320:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
 324:	13490c27 	beq	k0,t1,33c4 <data_size+0x3220>
 328:	01120111 	0x1120111
 32c:	40064081 	0x40064081
 330:	00130106 	0x130106
 334:	00050400 	sll	zero,a1,0x10
 338:	0b3a0803 	j	ce8200c <data_size+0xce81e68>
 33c:	13490b3b 	beq	k0,t1,302c <data_size+0x2e88>
 340:	00000602 	srl	zero,zero,0x18
 344:	03000505 	0x3000505
 348:	3b0b3a0e 	xori	t3,t8,0x3a0e
 34c:	0213490b 	0x213490b
 350:	06000006 	bltz	s0,36c <data_size+0x1c8>
 354:	08030034 	j	c00d0 <data_size+0xbff2c>
 358:	0b3b0b3a 	j	cec2ce8 <data_size+0xcec2b44>
 35c:	06021349 	0x6021349
 360:	34070000 	li	a3,0x0
 364:	3a080300 	xori	t0,s0,0x300
 368:	490b3b0b 	0x490b3b0b
 36c:	000a0213 	0xa0213
 370:	00340800 	0x340800
 374:	0b3a0e03 	j	ce8380c <data_size+0xce83668>
 378:	13490b3b 	beq	k0,t1,3068 <data_size+0x2ec4>
 37c:	00000602 	srl	zero,zero,0x18
 380:	0b002409 	j	c009024 <data_size+0xc008e80>
 384:	030b3e0b 	0x30b3e0b
 388:	0a000008 	j	8000020 <data_size+0x7fffe7c>
 38c:	13490101 	beq	k0,t1,794 <data_size+0x5f0>
 390:	00001301 	0x1301
 394:	4900210b 	bc2f	87c4 <data_size+0x8620>
 398:	000b2f13 	0xb2f13
 39c:	00240c00 	0x240c00
 3a0:	0b3e0b0b 	j	cf82c2c <data_size+0xcf82a88>
 3a4:	Address 0x00000000000003a4 is out of bounds.


Disassembly of section .debug_info:

00000000 <.debug_info>:
   0:	0000020b 	0x20b
   4:	00000002 	srl	zero,zero,0x0
   8:	01040000 	0x1040000
   c:	000000ba 	0xba
  10:	00009101 	0x9101
  14:	00003e00 	sll	a3,zero,0x18
  18:	c01aa000 	lwc0	$26,-24576(zero)
  1c:	c01bdcbf 	lwc0	$27,-9025(zero)
  20:	000000bf 	0xbf
  24:	07040200 	0x7040200
  28:	00000031 	0x31
  2c:	2c070402 	sltiu	a3,zero,1026
  30:	03000000 	0x3000000
  34:	00000023 	negu	zero,zero
  38:	002c0302 	0x2c0302
  3c:	04040000 	0x4040000
  40:	746e6905 	jalx	1b9a414 <data_size+0x1b9a270>
  44:	001a0500 	sll	zero,k0,0x14
  48:	02100000 	0x2100000
  4c:	00008a1f 	0x8a1f
  50:	00b30600 	0xb30600
  54:	20020000 	addi	v0,zero,0
  58:	00000033 	0x33
  5c:	06001002 	bltz	s0,4068 <data_size+0x3ec4>
  60:	000000c9 	0xc9
  64:	00332102 	0x332102
  68:	10020000 	beq	zero,v0,6c <data_size-0x138>
  6c:	00ab0604 	0xab0604
  70:	22020000 	addi	v0,s0,0
  74:	00000033 	0x33
  78:	06081002 	0x6081002
  7c:	00000012 	mflo	zero
  80:	00332302 	0x332302
  84:	10020000 	beq	zero,v0,88 <data_size-0x11c>
  88:	0107000c 	syscall	0x41c00
  8c:	00000007 	srav	zero,zero,zero
  90:	002c0401 	0x2c0401
  94:	a7000000 	sh	zero,0(t8)
  98:	08000000 	j	0 <data_size-0x1a4>
  9c:	00000098 	0x98
  a0:	002c0501 	0x2c0501
  a4:	09000000 	j	4000000 <data_size+0x3fffe5c>
  a8:	0000008a 	0x8a
  ac:	bfc01aa0 	0xbfc01aa0
  b0:	bfc01ab0 	0xbfc01ab0
  b4:	00000010 	mfhi	zero
  b8:	00c46d01 	0xc46d01
  bc:	9b0a0000 	lwr	t2,0(t8)
  c0:	00000000 	nop
  c4:	0008010b 	0x8010b
  c8:	11010000 	beq	t0,at,cc <data_size-0xd8>
  cc:	0000002c 	0x2c
  d0:	bfc01ab0 	0xbfc01ab0
  d4:	bfc01ac0 	0xbfc01ac0
  d8:	00000020 	add	zero,zero,zero
  dc:	010c6d01 	0x10c6d01
  e0:	000000a1 	0xa1
  e4:	002c2201 	0x2c2201
  e8:	1ac00000 	blez	s6,ec <data_size-0xb8>
  ec:	1ad0bfc0 	0x1ad0bfc0
  f0:	0030bfc0 	0x30bfc0
  f4:	6d010000 	0x6d010000
  f8:	00000106 	0x106
  fc:	01006e0d 	break	0x100,0x1b8
 100:	00002c23 	0x2c23
 104:	010e0000 	0x10e0000
 108:	0000008a 	0x8a
 10c:	2c012901 	sltiu	at,zero,10497
 110:	d0000000 	0xd0000000
 114:	ecbfc01a 	swc3	$31,-16358(a1)
 118:	40bfc01a 	0x40bfc01a
 11c:	01000000 	0x1000000
 120:	0001526d 	0x1526d
 124:	006e0f00 	0x6e0f00
 128:	002c2a01 	0x2c2a01
 12c:	00000000 	nop
 130:	8a100000 	lwl	s0,0(s0)
 134:	d0000000 	0xd0000000
 138:	e4bfc01a 	swc1	$f31,-16358(a1)
 13c:	01bfc01a 	0x1bfc01a
 140:	1ad0112b 	0x1ad0112b
 144:	1ae4bfc0 	0x1ae4bfc0
 148:	9b0abfc0 	lwr	t2,-16448(t8)
 14c:	00000000 	nop
 150:	010e0000 	0x10e0000
 154:	00000000 	nop
 158:	2c013201 	sltiu	at,zero,12801
 15c:	ec000000 	swc3	$0,0(zero)
 160:	10bfc01a 	beq	a1,ra,ffff01cc <_stack+0x403de034>
 164:	50bfc01b 	0x50bfc01b
 168:	01000000 	0x1000000
 16c:	00019c6d 	0x19c6d
 170:	006e1200 	0x6e1200
 174:	002c3301 	0x2c3301
 178:	53010000 	0x53010000
 17c:	00008a10 	0x8a10
 180:	c01aec00 	lwc0	$26,-5120(zero)
 184:	c01af8bf 	lwc0	$26,-1857(zero)
 188:	113401bf 	beq	t1,s4,888 <data_size+0x6e4>
 18c:	bfc01aec 	0xbfc01aec
 190:	bfc01af8 	0xbfc01af8
 194:	00009b0a 	0x9b0a
 198:	00000000 	nop
 19c:	00d10113 	0xd10113
 1a0:	16010000 	bne	s0,at,1a4 <data_size>
 1a4:	00002c01 	0x2c01
 1a8:	c01b1000 	lwc0	$27,4096(zero)
 1ac:	c01bdcbf 	lwc0	$27,-9025(zero)
 1b0:	000060bf 	0x60bf
 1b4:	00001300 	sll	v0,zero,0xc
 1b8:	00020800 	sll	at,v0,0x0
 1bc:	65731400 	0x65731400
 1c0:	1501006c 	bne	t0,at,374 <data_size+0x1d0>
 1c4:	0000003e 	0x3e
 1c8:	00000032 	0x32
 1cc:	706d7414 	0x706d7414
 1d0:	08150100 	j	540400 <data_size+0x54025c>
 1d4:	45000002 	bc1f	1e0 <data_size+0x3c>
 1d8:	0f000000 	jal	c000000 <data_size+0xbfffe5c>
 1dc:	1701006e 	bne	t8,at,398 <data_size+0x1f4>
 1e0:	0000002c 	0x2c
 1e4:	00000063 	0x63
 1e8:	00008a10 	0x8a10
 1ec:	c01b1c00 	lwc0	$27,7168(zero)
 1f0:	c01b24bf 	lwc0	$27,9407(zero)
 1f4:	111801bf 	beq	t0,t8,8f4 <data_size+0x750>
 1f8:	bfc01b1c 	0xbfc01b1c
 1fc:	bfc01b24 	0xbfc01b24
 200:	00009b0a 	0x9b0a
 204:	00000000 	nop
 208:	00450415 	0x450415
 20c:	c9000000 	lwc2	$0,0(t0)
 210:	02000000 	0x2000000
 214:	00015300 	sll	t2,at,0xc
 218:	ba010400 	swr	at,1024(s0)
 21c:	01000000 	0x1000000
 220:	000000e5 	0xe5
 224:	0000003e 	0x3e
 228:	bfc01be0 	0xbfc01be0
 22c:	bfc01e30 	0xbfc01e30
 230:	0000007d 	0x7d
 234:	04030402 	0x4030402
 238:	00003107 	0x3107
 23c:	07040300 	0x7040300
 240:	0000002c 	0x2c
 244:	00ee0104 	0xee0104
 248:	02010000 	0x2010000
 24c:	0000ad01 	0xad01
 250:	c01be000 	lwc0	$27,-8192(zero)
 254:	c01e30bf 	lwc0	$30,12479(zero)
 258:	000088bf 	0x88bf
 25c:	00007600 	sll	t6,zero,0x18
 260:	0000ad00 	sll	s5,zero,0x14
 264:	6d660500 	0x6d660500
 268:	01010074 	0x1010074
 26c:	000000b4 	0xb4
 270:	00000095 	0x95
 274:	00690706 	0x690706
 278:	00ad0301 	0xad0301
 27c:	00be0000 	0xbe0000
 280:	63080000 	0x63080000
 284:	bf040100 	0xbf040100
 288:	07000000 	bltz	t8,28c <data_size+0xe8>
 28c:	00677261 	0x677261
 290:	00c60501 	0xc60501
 294:	00dc0000 	0xdc0000
 298:	61090000 	0x61090000
 29c:	06010070 	bgez	s0,460 <data_size+0x2bc>
 2a0:	00000025 	move	zero,zero
 2a4:	07108d02 	bltzal	t8,fffe36b0 <_stack+0x403d1518>
 2a8:	07010077 	bgez	t8,488 <data_size+0x2e4>
 2ac:	000000ad 	0xad
 2b0:	000000fa 	0xfa
 2b4:	0000df0a 	0xdf0a
 2b8:	00450100 	0x450100
 2bc:	6905040b 	0x6905040b
 2c0:	0c00746e 	jal	1d1b8 <data_size+0x1d014>
 2c4:	0000ba04 	0xba04
 2c8:	00bf0d00 	0xbf0d00
 2cc:	01030000 	0x1030000
 2d0:	0000fc06 	0xfc06
 2d4:	25040c00 	addiu	a0,t0,3072
 2d8:	00000000 	nop
 2dc:	00000088 	0x88
 2e0:	01fa0002 	0x1fa0002
 2e4:	01040000 	0x1040000
 2e8:	000000ba 	0xba
 2ec:	00010101 	0x10101
 2f0:	00003e00 	sll	a3,zero,0x18
 2f4:	c01e3000 	lwc0	$30,12288(zero)
 2f8:	c01e64bf 	lwc0	$30,25791(zero)
 2fc:	000129bf 	0x129bf
 300:	07040200 	0x7040200
 304:	00000031 	0x31
 308:	2c070402 	sltiu	a3,zero,1026
 30c:	03000000 	0x3000000
 310:	0000f501 	0xf501
 314:	30080100 	andi	t0,zero,0x100
 318:	44bfc01e 	0x44bfc01e
 31c:	bcbfc01e 	0xbcbfc01e
 320:	01000000 	0x1000000
 324:	0000596d 	0x596d
 328:	00630400 	0x630400
 32c:	00590801 	0x590801
 330:	54010000 	0x54010000
 334:	05040500 	0x5040500
 338:	00746e69 	0x746e69
 33c:	00f90106 	0xf90106
 340:	02010000 	0x2010000
 344:	00005901 	0x5901
 348:	c01e4400 	lwc0	$30,17408(zero)
 34c:	c01e64bf 	lwc0	$30,25791(zero)
 350:	0000ccbf 	0xccbf
 354:	00018600 	sll	s0,at,0x18
 358:	00630700 	0x630700
 35c:	00590101 	0x590101
 360:	01a50000 	0x1a50000
 364:	00000000 	nop
 368:	000000ab 	0xab
 36c:	02740002 	0x2740002
 370:	01040000 	0x1040000
 374:	000000ba 	0xba
 378:	00010b01 	0x10b01
 37c:	00003e00 	sll	a3,zero,0x18
 380:	c01e7000 	lwc0	$30,28672(zero)
 384:	c01f28bf 	lwc0	$31,10431(zero)
 388:	000169bf 	0x169bf
 38c:	07040200 	0x7040200
 390:	00000031 	0x31
 394:	2c070402 	sltiu	a3,zero,1026
 398:	03000000 	0x3000000
 39c:	00011701 	0x11701
 3a0:	01020100 	0x1020100
 3a4:	0000006f 	0x6f
 3a8:	bfc01e70 	0xbfc01e70
 3ac:	bfc01ef8 	0xbfc01ef8
 3b0:	000000f4 	0xf4
 3b4:	000001b8 	0x1b8
 3b8:	0000006f 	0x6f
 3bc:	01007304 	0x1007304
 3c0:	00007601 	0x7601
 3c4:	0001d700 	sll	k0,at,0x1c
 3c8:	00630500 	0x630500
 3cc:	007c0301 	0x7c0301
 3d0:	02000000 	0x2000000
 3d4:	06000000 	bltz	s0,3d8 <data_size+0x234>
 3d8:	6e690504 	0x6e690504
 3dc:	04070074 	0x4070074
 3e0:	0000007c 	0x7c
 3e4:	fc060102 	0xfc060102
 3e8:	08000000 	j	0 <data_size-0x1a4>
 3ec:	00011201 	0x11201
 3f0:	010f0100 	0x10f0100
 3f4:	0000006f 	0x6f
 3f8:	bfc01ef8 	0xbfc01ef8
 3fc:	bfc01f28 	0xbfc01f28
 400:	00000110 	0x110
 404:	00000213 	0x213
 408:	01007304 	0x1007304
 40c:	0000760e 	0x760e
 410:	00023200 	sll	a2,v0,0x8
 414:	f7000000 	0xf7000000
 418:	02000000 	0x2000000
 41c:	0002fb00 	sll	ra,v0,0xc
 420:	ba010400 	swr	at,1024(s0)
 424:	01000000 	0x1000000
 428:	00000121 	0x121
 42c:	0000003e 	0x3e
 430:	bfc01f30 	0xbfc01f30
 434:	bfc02030 	0xbfc02030
 438:	000001ac 	0x1ac
 43c:	31070402 	andi	a3,t0,0x402
 440:	02000000 	0x2000000
 444:	002c0704 	0x2c0704
 448:	01030000 	0x1030000
 44c:	00000141 	0x141
 450:	d2010201 	0xd2010201
 454:	30000000 	andi	zero,zero,0x0
 458:	30bfc01f 	andi	ra,a1,0xc01f
 45c:	38bfc020 	xori	ra,a1,0xc020
 460:	45000001 	bc1f	468 <data_size+0x2c4>
 464:	d2000002 	0xd2000002
 468:	04000000 	bltz	zero,46c <data_size+0x2c8>
 46c:	01010076 	0x1010076
 470:	000000d9 	0xd9
 474:	00000265 	0x265
 478:	01007704 	0x1007704
 47c:	0000d201 	0xd201
 480:	0002c500 	sll	t8,v0,0x14
 484:	01460500 	0x1460500
 488:	01010000 	0x1010000
 48c:	000000d2 	0xd2
 490:	00000330 	0x330
 494:	00013c05 	0x13c05
 498:	d2010100 	0xd2010100
 49c:	85000000 	lh	zero,0(t0)
 4a0:	06000003 	bltz	s0,4b0 <data_size+0x30c>
 4a4:	03010069 	0x3010069
 4a8:	000000d2 	0xd2
 4ac:	000003ae 	0x3ae
 4b0:	01006a06 	0x1006a06
 4b4:	0000d203 	sra	k0,zero,0x8
 4b8:	0003d700 	sll	k0,v1,0x1c
 4bc:	00630600 	0x630600
 4c0:	00d20401 	0xd20401
 4c4:	04000000 	bltz	zero,4c8 <data_size+0x324>
 4c8:	62070000 	0x62070000
 4cc:	01006675 	0x1006675
 4d0:	0000e005 	0xe005
 4d4:	a8910300 	swl	s1,768(a0)
 4d8:	012d087f 	0x12d087f
 4dc:	06010000 	bgez	s0,4e0 <data_size+0x33c>
 4e0:	0000002c 	0x2c
 4e4:	0000041e 	0x41e
 4e8:	05040900 	0x5040900
 4ec:	00746e69 	0x746e69
 4f0:	33050402 	andi	a1,t8,0x402
 4f4:	0a000001 	j	8000004 <data_size+0x7fffe60>
 4f8:	000000f3 	0xf3
 4fc:	000000f0 	0xf0
 500:	0000f00b 	0xf00b
 504:	0c003f00 	jal	fc00 <data_size+0xfa5c>
 508:	01020704 	0x1020704
 50c:	0000fc06 	0xfc06
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
   0:	00000079 	0x79
   4:	00320002 	0x320002
   8:	01010000 	0x1010000
   c:	000d0efb 	0xd0efb
  10:	01010101 	0x1010101
  14:	01000000 	0x1000000
  18:	2e010000 	sltiu	at,s0,0
  1c:	6e692f2e 	0x6e692f2e
  20:	64756c63 	0x64756c63
  24:	74000065 	jalx	194 <data_size-0x10>
  28:	2e656d69 	sltiu	a1,s3,28009
  2c:	00000063 	0x63
  30:	6d697400 	0x6d697400
  34:	00682e65 	0x682e65
  38:	00000001 	0x1
  3c:	a0020500 	sb	v0,1280(zero)
  40:	15bfc01a 	bne	t5,ra,ffff00ac <_stack+0x403ddf14>
  44:	f5010a03 	0xf5010a03
  48:	f20f0314 	0xf20f0314
  4c:	5d03f516 	0x5d03f516
  50:	08280301 	j	a00c04 <data_size+0xa00a60>
  54:	5403863c 	0x5403863c
  58:	ba310301 	swr	s1,769(s1)
  5c:	74085f03 	jalx	217c0c <data_size+0x217a68>
  60:	4a700382 	c2	0x700382
  64:	08821503 	j	208540c <data_size+0x2085268>
  68:	f67f4c3b 	0xf67f4c3b
  6c:	3e088180 	0x3e088180
  70:	3a083b08 	xori	t0,s0,0x3b08
  74:	84f53d08 	lh	s5,15624(a3)
  78:	01001002 	0x1001002
  7c:	0000a801 	0xa801
  80:	1f000200 	bgtz	t8,884 <data_size+0x6e0>
  84:	01000000 	0x1000000
  88:	0d0efb01 	jal	43bec04 <data_size+0x43bea60>
  8c:	01010100 	0x1010100
  90:	00000001 	0x1
  94:	01000001 	0x1000001
  98:	69727000 	0x69727000
  9c:	2e66746e 	sltiu	a2,s3,29806
  a0:	00000063 	0x63
  a4:	05000000 	bltz	t0,a8 <data_size-0xfc>
  a8:	c01be002 	lwc0	$27,-8190(zero)
  ac:	240213bf 	li	v0,5055
  b0:	4a78031a 	c2	0x78031a
  b4:	4a7a0350 	c2	0x7a0350
  b8:	780389c2 	0x780389c2
  bc:	7803524a 	0x7803524a
  c0:	c2034e4a 	lwc0	$3,20042(s0)
  c4:	be034a00 	0xbe034a00
  c8:	c2034a7f 	lwc0	$3,19071(s0)
  cc:	03838200 	0x3838200
  d0:	03827fba 	0x3827fba
  d4:	740800ca 	jalx	200328 <data_size+0x200184>
  d8:	027fb903 	0x27fb903
  dc:	0386012c 	0x386012c
  e0:	033c0838 	0x33c0838
  e4:	03898241 	0x3898241
  e8:	f43c0830 	0xf43c0830
  ec:	3c084e03 	lui	t0,0x4e03
  f0:	03823e03 	0x3823e03
  f4:	4bf3f24f 	c2	0x1f3f24f
  f8:	bb827403 	swr	v0,29699(gp)
  fc:	f3822303 	0xf3822303
 100:	8273034b 	lb	s3,843(s3)
 104:	79034bf3 	0x79034bf3
 108:	034bf382 	0x34bf382
 10c:	4bf38279 	c2	0x1f38279
 110:	bb827403 	swr	v0,29699(gp)
 114:	f3821803 	0xf3821803
 118:	8209034b 	lb	t1,843(s0)
 11c:	f14b8783 	0xf14b8783
 120:	7508494b 	jalx	421252c <data_size+0x4212388>
 124:	01000802 	0x1000802
 128:	00003c01 	0x3c01
 12c:	20000200 	addi	zero,zero,512
 130:	01000000 	0x1000000
 134:	0d0efb01 	jal	43bec04 <data_size+0x43bea60>
 138:	01010100 	0x1010100
 13c:	00000001 	0x1
 140:	01000001 	0x1000001
 144:	74757000 	jalx	1d5c000 <data_size+0x1d5be5c>
 148:	72616863 	0x72616863
 14c:	0000632e 	0x632e
 150:	00000000 	nop
 154:	1e300205 	0x1e300205
 158:	1319bfc0 	beq	t8,t9,ffff005c <_stack+0x403ddec4>
 15c:	03ba0903 	0x3ba0903
 160:	84838270 	lh	v1,-32144(a0)
 164:	01001002 	0x1001002
 168:	00003f01 	0x3f01
 16c:	1d000200 	bgtz	t0,970 <data_size+0x7cc>
 170:	01000000 	0x1000000
 174:	0d0efb01 	jal	43bec04 <data_size+0x43bea60>
 178:	01010100 	0x1010100
 17c:	00000001 	0x1
 180:	01000001 	0x1000001
 184:	74757000 	jalx	1d5c000 <data_size+0x1d5be5c>
 188:	00632e73 	0x632e73
 18c:	00000000 	nop
 190:	70020500 	0x70020500
 194:	13bfc01e 	beq	sp,ra,ffff0210 <_stack+0x403de078>
 198:	83f43e08 	lb	s4,15880(ra)
 19c:	7ff3f47f 	0x7ff3f47f
 1a0:	83b008f9 	lb	s0,2297(sp)
 1a4:	02848383 	0x2848383
 1a8:	01010010 	0x1010010
 1ac:	00000053 	0x53
 1b0:	00220002 	0x220002
 1b4:	01010000 	0x1010000
 1b8:	000d0efb 	0xd0efb
 1bc:	01010101 	0x1010101
 1c0:	01000000 	0x1000000
 1c4:	00010000 	sll	zero,at,0x0
 1c8:	6e697270 	0x6e697270
 1cc:	73616274 	0x73616274
 1d0:	00632e65 	0x632e65
 1d4:	00000000 	nop
 1d8:	30020500 	andi	v0,zero,0x500
 1dc:	13bfc01f 	beq	sp,ra,ffff025c <_stack+0x403de0c4>
 1e0:	f7877408 	0xf7877408
 1e4:	4cf0bc4c 	0x4cf0bc4c
 1e8:	6c038ab8 	0x6c038ab8
 1ec:	16037408 	bne	s0,v1,1d210 <data_size+0x1d06c>
 1f0:	88b7f382 	lwl	s7,-3198(a1)
 1f4:	0383e008 	0x383e008
 1f8:	033c0871 	0x33c0871
 1fc:	0802f20f 	j	bc83c <data_size+0xbc698>
 200:	Address 0x0000000000000200 is out of bounds.


Disassembly of section .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	syscall
   4:	ffffffff 	0xffffffff
   8:	7c010001 	0x7c010001
   c:	001d0c1f 	0x1d0c1f
  10:	0000000c 	syscall
  14:	00000000 	nop
  18:	bfc01aa0 	0xbfc01aa0
  1c:	00000010 	mfhi	zero
  20:	0000000c 	syscall
  24:	00000000 	nop
  28:	bfc01ab0 	0xbfc01ab0
  2c:	00000010 	mfhi	zero
  30:	0000000c 	syscall
  34:	00000000 	nop
  38:	bfc01ac0 	0xbfc01ac0
  3c:	00000010 	mfhi	zero
  40:	0000000c 	syscall
  44:	00000000 	nop
  48:	bfc01ad0 	0xbfc01ad0
  4c:	0000001c 	0x1c
  50:	0000000c 	syscall
  54:	00000000 	nop
  58:	bfc01aec 	0xbfc01aec
  5c:	00000024 	and	zero,zero,zero
  60:	00000014 	0x14
  64:	00000000 	nop
  68:	bfc01b10 	0xbfc01b10
  6c:	000000cc 	syscall	0x3
  70:	44180e44 	0x44180e44
  74:	0000019f 	0x19f
  78:	0000000c 	syscall
  7c:	ffffffff 	0xffffffff
  80:	7c010001 	0x7c010001
  84:	001d0c1f 	0x1d0c1f
  88:	00000020 	add	zero,zero,zero
  8c:	00000078 	0x78
  90:	bfc01be0 	0xbfc01be0
  94:	00000250 	0x250
  98:	60380e44 	0x60380e44
  9c:	07910890 	bgezal	gp,22e0 <data_size+0x213c>
  a0:	04940692 	0x4940692
  a4:	02960395 	0x2960395
  a8:	0593019f 	0x593019f
  ac:	0000000c 	syscall
  b0:	ffffffff 	0xffffffff
  b4:	7c010001 	0x7c010001
  b8:	001d0c1f 	0x1d0c1f
  bc:	0000000c 	syscall
  c0:	000000ac 	0xac
  c4:	bfc01e30 	0xbfc01e30
  c8:	00000014 	0x14
  cc:	00000014 	0x14
  d0:	000000ac 	0xac
  d4:	bfc01e44 	0xbfc01e44
  d8:	00000020 	add	zero,zero,zero
  dc:	44180e44 	0x44180e44
  e0:	0000019f 	0x19f
  e4:	0000000c 	syscall
  e8:	ffffffff 	0xffffffff
  ec:	7c010001 	0x7c010001
  f0:	001d0c1f 	0x1d0c1f
  f4:	00000018 	mult	zero,zero
  f8:	000000e4 	0xe4
  fc:	bfc01e70 	0xbfc01e70
 100:	00000088 	0x88
 104:	50200e44 	0x50200e44
 108:	02920490 	0x2920490
 10c:	0391019f 	0x391019f
 110:	00000014 	0x14
 114:	000000e4 	0xe4
 118:	bfc01ef8 	0xbfc01ef8
 11c:	00000030 	0x30
 120:	44180e44 	0x44180e44
 124:	0000019f 	0x19f
 128:	0000000c 	syscall
 12c:	ffffffff 	0xffffffff
 130:	7c010001 	0x7c010001
 134:	001d0c1f 	0x1d0c1f
 138:	0000001c 	0x1c
 13c:	00000128 	0x128
 140:	bfc01f30 	0xbfc01f30
 144:	00000100 	sll	zero,zero,0x4
 148:	54680e44 	0x54680e44
 14c:	04910590 	bgezal	a0,1790 <data_size+0x15ec>
 150:	0392019f 	0x392019f
 154:	00000293 	0x293

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
   0:	0000003c 	0x3c
   4:	00000044 	0x44
   8:	00520001 	0x520001
   c:	00000000 	nop
  10:	70000000 	0x70000000
  14:	74000000 	jalx	0 <data_size-0x1a4>
  18:	01000000 	0x1000000
  1c:	00746d00 	0x746d00
  20:	013c0000 	0x13c0000
  24:	00020000 	sll	zero,v0,0x0
  28:	0000188d 	break	0x0,0x62
  2c:	00000000 	nop
  30:	00700000 	0x700000
  34:	00b80000 	0xb80000
  38:	00010000 	sll	zero,at,0x0
  3c:	00000054 	0x54
  40:	00000000 	nop
  44:	00007000 	sll	t6,zero,0x0
  48:	0000a000 	sll	s4,zero,0x0
  4c:	55000100 	0x55000100
  50:	000000a0 	0xa0
  54:	0000012c 	0x12c
  58:	005a0001 	0x5a0001
  5c:	00000000 	nop
  60:	84000000 	lh	zero,0(zero)
  64:	e8000000 	swc2	$0,0(zero)
  68:	01000000 	0x1000000
  6c:	00005600 	sll	t2,zero,0x18
	...
  78:	00040000 	sll	zero,a0,0x0
  7c:	00010000 	sll	zero,at,0x0
  80:	0000046d 	0x46d
  84:	00025000 	sll	t2,v0,0x0
  88:	8d000200 	lw	zero,512(t0)
  8c:	00000038 	0x38
	...
  98:	00003000 	sll	a2,zero,0x0
  9c:	54000100 	0x54000100
  a0:	00000030 	0x30
  a4:	000000a4 	0xa4
  a8:	b8630001 	swr	v1,1(v1)
  ac:	50000000 	0x50000000
  b0:	01000002 	0x1000002
  b4:	00006300 	sll	t4,zero,0xc
  b8:	00000000 	nop
  bc:	00540000 	0x540000
  c0:	00ac0000 	0xac0000
  c4:	00010000 	sll	zero,at,0x0
  c8:	0000b861 	0xb861
  cc:	00025000 	sll	t2,v0,0x0
  d0:	61000100 	0x61000100
	...
  dc:	0000004c 	syscall	0x1
  e0:	000000a8 	0xa8
  e4:	b8620001 	swr	v0,1(v1)
  e8:	50000000 	0x50000000
  ec:	01000002 	0x1000002
  f0:	00006200 	sll	t4,zero,0x8
  f4:	00000000 	nop
  f8:	00c00000 	0xc00000
  fc:	00dc0000 	0xdc0000
 100:	00010000 	sll	zero,at,0x0
 104:	0000e455 	0xe455
 108:	00012400 	sll	a0,at,0x10
 10c:	55000100 	0x55000100
 110:	00000134 	0x134
 114:	00000144 	0x144
 118:	50550001 	0x50550001
 11c:	5c000001 	0x5c000001
 120:	01000001 	0x1000001
 124:	01645500 	0x1645500
 128:	01740000 	0x1740000
 12c:	00010000 	sll	zero,at,0x0
 130:	00018055 	0x18055
 134:	00019000 	sll	s2,at,0x0
 138:	55000100 	0x55000100
 13c:	0000019c 	0x19c
 140:	000001ac 	0x1ac
 144:	b8550001 	swr	s5,1(v0)
 148:	c8000001 	lwc2	$0,1(zero)
 14c:	01000001 	0x1000001
 150:	01d45500 	0x1d45500
 154:	01e00000 	0x1e00000
 158:	00010000 	sll	zero,at,0x0
 15c:	0001e855 	0x1e855
 160:	0001f800 	sll	ra,at,0x0
 164:	55000100 	0x55000100
 168:	00000204 	0x204
 16c:	0000020c 	syscall	0x8
 170:	14550001 	bne	v0,s5,178 <data_size-0x2c>
 174:	50000002 	0x50000002
 178:	01000002 	0x1000002
 17c:	00005500 	sll	t2,zero,0x14
 180:	00000000 	nop
 184:	00140000 	sll	zero,s4,0x0
 188:	00180000 	sll	zero,t8,0x0
 18c:	00010000 	sll	zero,at,0x0
 190:	0000186d 	0x186d
 194:	00003400 	sll	a2,zero,0x10
 198:	8d000200 	lw	zero,512(t0)
 19c:	00000018 	mult	zero,zero
 1a0:	00000000 	nop
 1a4:	00001400 	sll	v0,zero,0x10
 1a8:	00002400 	sll	a0,zero,0x10
 1ac:	54000100 	0x54000100
	...
 1bc:	00000004 	sllv	zero,zero,zero
 1c0:	046d0001 	0x46d0001
 1c4:	88000000 	lwl	zero,0(zero)
 1c8:	02000000 	0x2000000
 1cc:	00208d00 	0x208d00
	...
 1d8:	24000000 	li	zero,0
 1dc:	01000000 	0x1000000
 1e0:	00245400 	0x245400
 1e4:	007c0000 	0x7c0000
 1e8:	00010000 	sll	zero,at,0x0
 1ec:	00007c61 	0x7c61
 1f0:	00008800 	sll	s1,zero,0x0
 1f4:	54000100 	0x54000100
	...
 200:	0000001c 	0x1c
 204:	00000080 	sll	zero,zero,0x2
 208:	00600001 	0x600001
 20c:	00000000 	nop
 210:	88000000 	lwl	zero,0(zero)
 214:	8c000000 	lw	zero,0(zero)
 218:	01000000 	0x1000000
 21c:	008c6d00 	0x8c6d00
 220:	00b80000 	0xb80000
 224:	00020000 	sll	zero,v0,0x0
 228:	0000188d 	break	0x0,0x62
 22c:	00000000 	nop
 230:	00880000 	0x880000
 234:	00980000 	0x980000
 238:	00010000 	sll	zero,at,0x0
 23c:	00000054 	0x54
	...
 248:	00000400 	sll	zero,zero,0x10
 24c:	6d000100 	0x6d000100
 250:	00000004 	sllv	zero,zero,zero
 254:	00000100 	sll	zero,zero,0x4
 258:	e88d0003 	swc2	$13,3(a0)
	...
 268:	00002800 	sll	a1,zero,0x0
 26c:	54000100 	0x54000100
 270:	00000028 	0x28
 274:	00000060 	0x60
 278:	68530001 	0x68530001
 27c:	6c000000 	0x6c000000
 280:	01000000 	0x1000000
 284:	006c5300 	0x6c5300
 288:	00980000 	0x980000
 28c:	00010000 	sll	zero,at,0x0
 290:	0000ac54 	0xac54
 294:	0000d400 	sll	k0,zero,0x10
 298:	54000100 	0x54000100
 29c:	000000e8 	0xe8
 2a0:	000000e8 	0xe8
 2a4:	e8540001 	swc2	$20,1(v0)
 2a8:	f0000000 	0xf0000000
 2ac:	01000000 	0x1000000
 2b0:	00f85300 	0xf85300
 2b4:	00f80000 	0xf80000
 2b8:	00010000 	sll	zero,at,0x0
 2bc:	00000053 	0x53
	...
 2c8:	00002800 	sll	a1,zero,0x0
 2cc:	55000100 	0x55000100
 2d0:	00000028 	0x28
 2d4:	00000098 	0x98
 2d8:	98630001 	lwr	v1,1(v1)
 2dc:	a4000000 	sh	zero,0(zero)
 2e0:	01000000 	0x1000000
 2e4:	00ac5500 	0xac5500
 2e8:	00b80000 	0xb80000
 2ec:	00010000 	sll	zero,at,0x0
 2f0:	0000b863 	0xb863
 2f4:	0000cc00 	sll	t9,zero,0x10
 2f8:	55000100 	0x55000100
 2fc:	000000cc 	syscall	0x3
 300:	000000d4 	0xd4
 304:	d4630001 	0xd4630001
 308:	e8000000 	swc2	$0,0(zero)
 30c:	01000000 	0x1000000
 310:	00e85500 	0xe85500
 314:	00f80000 	0xf80000
 318:	00010000 	sll	zero,at,0x0
 31c:	0000f863 	0xf863
 320:	00010000 	sll	zero,at,0x0
 324:	55000100 	0x55000100
	...
 334:	00000028 	0x28
 338:	28560001 	slti	s6,v0,1
 33c:	88000000 	lwl	zero,0(zero)
 340:	01000000 	0x1000000
 344:	00886200 	0x886200
 348:	00a40000 	0xa40000
 34c:	00010000 	sll	zero,at,0x0
 350:	0000ac56 	0xac56
 354:	0000bc00 	sll	s7,zero,0x10
 358:	62000100 	0x62000100
 35c:	000000bc 	0xbc
 360:	000000e8 	0xe8
 364:	e8560001 	swc2	$22,1(v0)
 368:	f8000000 	0xf8000000
 36c:	01000000 	0x1000000
 370:	00f86200 	0xf86200
 374:	01000000 	0x1000000
 378:	00010000 	sll	zero,at,0x0
 37c:	00000056 	0x56
	...
 388:	0000a400 	sll	s4,zero,0x10
 38c:	57000100 	0x57000100
 390:	000000ac 	0xac
 394:	000000f0 	0xf0
 398:	f8570001 	0xf8570001
 39c:	00000000 	nop
 3a0:	01000001 	0x1000001
 3a4:	00005700 	sll	t2,zero,0x1c
 3a8:	00000000 	nop
 3ac:	003c0000 	0x3c0000
 3b0:	00c00000 	0xc00000
 3b4:	00010000 	sll	zero,at,0x0
 3b8:	0000cc61 	0xcc61
 3bc:	0000e800 	sll	sp,zero,0x0
 3c0:	61000100 	0x61000100
 3c4:	000000f8 	0xf8
 3c8:	00000100 	sll	zero,zero,0x4
 3cc:	00610001 	0x610001
 3d0:	00000000 	nop
 3d4:	6c000000 	0x6c000000
 3d8:	a4000000 	sh	zero,0(zero)
 3dc:	01000000 	0x1000000
 3e0:	00ac5300 	0xac5300
 3e4:	00e80000 	0xe80000
 3e8:	00010000 	sll	zero,at,0x0
 3ec:	0000f853 	0xf853
 3f0:	00010000 	sll	zero,at,0x0
 3f4:	53000100 	0x53000100
	...
 400:	000000d4 	0xd4
 404:	000000e0 	0xe0
 408:	f8540001 	0xf8540001
 40c:	f8000000 	0xf8000000
 410:	01000000 	0x1000000
 414:	00005400 	sll	t2,zero,0x10
 418:	00000000 	nop
 41c:	00340000 	0x340000
 420:	00800000 	0x800000
 424:	00010000 	sll	zero,at,0x0
 428:	0000ac60 	0xac60
 42c:	0000c400 	sll	t8,zero,0x10
 430:	60000100 	0x60000100
 434:	000000e8 	0xe8
 438:	000000f8 	0xf8
 43c:	00600001 	0x600001
 440:	00000000 	nop
 444:	Address 0x0000000000000444 is out of bounds.


Disassembly of section .debug_str:

00000000 <.debug_str>:
   0:	5f746567 	0x5f746567
   4:	5f007375 	0x5f007375
   8:	5f746567 	0x5f746567
   c:	6e756f63 	0x6e756f63
  10:	76740074 	jalx	9d001d0 <data_size+0x9d0002c>
  14:	65736d5f 	0x65736d5f
  18:	69740063 	0x69740063
  1c:	7073656d 	0x7073656d
  20:	5f006365 	0x5f006365
  24:	636f6c63 	0x636f6c63
  28:	00745f6b 	0x745f6b
  2c:	676e6f6c 	0x676e6f6c
  30:	736e7520 	0x736e7520
  34:	656e6769 	0x656e6769
  38:	6e692064 	0x6e692064
  3c:	6d2f0074 	0x6d2f0074
  40:	61696465 	0x61696465
  44:	5f66732f 	0x5f66732f
  48:	7363736e 	0x7363736e
  4c:	30326363 	andi	s2,at,0x6363
  50:	722f3831 	0x722f3831
  54:	61656c65 	0x61656c65
  58:	765f6573 	jalx	97d95cc <data_size+0x97d9428>
  5c:	33302e30 	andi	s0,t9,0x2e30
  60:	7665645f 	jalx	995917c <data_size+0x9958fd8>
  64:	6e75662f 	0x6e75662f
  68:	65745f63 	0x65745f63
  6c:	765f7473 	jalx	97dd1cc <data_size+0x97dd028>
  70:	32302e30 	andi	s0,s1,0x2e30
  74:	666f732f 	0x666f732f
  78:	656d2f74 	0x656d2f74
  7c:	79726f6d 	0x79726f6d
  80:	6d61675f 	0x6d61675f
  84:	696c2f65 	0x696c2f65
  88:	65670062 	0x65670062
  8c:	736e5f74 	0x736e5f74
  90:	6d697400 	0x6d697400
  94:	00632e65 	0x632e65
  98:	6e6f635f 	0x6e6f635f
  9c:	6c617674 	0x6c617674
  a0:	74656700 	jalx	1959c00 <data_size+0x1959a5c>
  a4:	6f6c635f 	0x6f6c635f
  a8:	74006b63 	jalx	1ad8c <data_size+0x1abe8>
  ac:	73755f76 	0x73755f76
  b0:	74006365 	jalx	18d94 <data_size+0x18bf0>
  b4:	65735f76 	0x65735f76
  b8:	4e470063 	c3	0x470063
  bc:	20432055 	addi	v1,v0,8277
  c0:	2e332e34 	sltiu	s3,s1,11828
  c4:	672d2030 	0x672d2030
  c8:	5f767400 	0x5f767400
  cc:	6365736e 	0x6365736e
  d0:	6f6c6300 	0x6f6c6300
  d4:	675f6b63 	0x675f6b63
  d8:	69747465 	0x69747465
  dc:	6100656d 	0x6100656d
  e0:	6e696167 	0x6e696167
  e4:	69727000 	0x69727000
  e8:	2e66746e 	sltiu	a2,s3,29806
  ec:	72700063 	0x72700063
  f0:	66746e69 	0x66746e69
  f4:	74677400 	jalx	19dd000 <data_size+0x19dce5c>
  f8:	7475705f 	jalx	1d5c17c <data_size+0x1d5bfd8>
  fc:	72616863 	0x72616863
 100:	74757000 	jalx	1d5c000 <data_size+0x1d5be5c>
 104:	72616863 	0x72616863
 108:	7000632e 	0x7000632e
 10c:	2e737475 	sltiu	s3,s3,29813
 110:	75700063 	jalx	5c0018c <data_size+0x5bfffe8>
 114:	70007374 	0x70007374
 118:	74737475 	jalx	1cdd1d4 <data_size+0x1cdd030>
 11c:	676e6972 	0x676e6972
 120:	69727000 	0x69727000
 124:	6162746e 	0x6162746e
 128:	632e6573 	0x632e6573
 12c:	6c617600 	0x6c617600
 130:	6c006575 	0x6c006575
 134:	20676e6f 	addi	a3,v1,28271
 138:	00746e69 	0x746e69
 13c:	6e676973 	0x6e676973
 140:	69727000 	0x69727000
 144:	6162746e 	0x6162746e
 148:	Address 0x0000000000000148 is out of bounds.

