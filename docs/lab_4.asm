.data
   a:  .word  3
.text  0x0000						#;代码开始的首地址
main: 
	addi $2, $0, 5 		# initialize $2=5 		0  20020005
	addi $3, $0, 12 	# initialize $3=12 		4  2003000c
	addi $7, $3,-9 		# initialize $7=3 		8  2067fff7
	or $4, $7, $2 		# $4 <= 3 or 5 = 7 		c  00e22025
	and $5, $3, $4 		# $5 <= 12 and 7 = 4 	10 00642824
	add $5, $5, $4 		# $5 = 4 + 7 = 11 		14 00a42820
	beq $5, $7, end 	# shouldn’t be taken 	18 10a7000c
	slt $4, $3, $4 		# $4 = 12 < 7 = 0 		1c 0064202a
	beq $4, $0, around 	# should be taken 		20 10800002
	nop					# empty inst			24 00000000
	addi $5, $0, 0 		# shouldn’t happen 		28 20050000
around: 
	slt $4, $7, $2 		# $4 = 3 < 5 = 1 		2c 00e2202a
	add $7, $4, $5 		# $7 = 1 + 11 = 12 		30 00853820
	sub $7, $7, $2 		# $7 = 12 - 5 = 7 		34 00e23822
	sw $7, 68($3) 		# [80] = 7 				38 ac670044
	lw $2, 80($0) 		# $2 = [80] = 7 		3c 8c020050
	j end 				# should be taken 		40 08000013
	nop					# empty inst			44 00000000
	addi $2, $0, 1 		# shouldn’t happen 		48 20020001
end: 
	sw $2, 84($0)		# write adr 84=7 		4c ac020054