//specific inst macro definition

`define NOP			6'b000000
`define AND 		6'b100100
`define OR 			6'b100101
`define XOR 		6'b100110
`define NOR			6'b100111
`define ANDI		6'b001100
`define ORI			6'b001101
`define XORI		6'b001110
`define LUI			6'b001111

`define SLL			6'b000000
`define SLLV		6'b000100
`define SRL 		6'b000010
`define SRLV 		6'b000110
`define SRA 		6'b000011
`define SRAV 		6'b000111

`define MFHI  		6'b010000
`define MTHI  		6'b010001
`define MFLO  		6'b010010
`define MTLO  		6'b010011

`define SLT  6'b101010
`define SLTU  6'b101011
`define SLTI  6'b001010
`define SLTIU  6'b001011   
`define ADD  6'b100000
`define ADDU  6'b100001
`define SUB  6'b100010
`define SUBU  6'b100011
`define ADDI  6'b001000
`define ADDIU  6'b001001

`define MULT  6'b011000
`define MULTU  6'b011001
`define DIV  6'b011010
`define DIVU  6'b011011

`define J  6'b000010
`define JAL  6'b000011
`define JALR  6'b001001
`define JR  6'b001000
`define BEQ  6'b000100
`define BGEZ  5'b00001
`define BGEZAL  5'b10001
`define BGTZ  6'b000111
`define BLEZ  6'b000110
`define BLTZ  5'b00000
`define BLTZAL  5'b10000
`define BNE  6'b000101

`define LB  6'b100000
`define LBU  6'b100100
`define LH  6'b100001
`define LHU  6'b100101
`define LW  6'b100011
`define SB  6'b101000
`define SH  6'b101001
`define SW  6'b101011

`define SYSCALL 6'b001100
`define BREAK 6'b001101
   
`define ERET 32'b01000010000000000000000000011000

`define R_TYPE 6'b000000
`define REGIMM_INST 6'b000001

// ALU CONTROL 5bit
`define NO_CONTROL  5'b00000

`define AND_CONTROL 5'b00001
`define OR_CONTROL  5'b00010
`define XOR_CONTROL 5'b00011
`define NOR_CONTROL 5'b00100
`define LUI_CONTROL 5'b00101

`define SLL_CONTROL 5'b01000
`define SRL_CONTROL 5'b01001
`define SRA_CONTROL 5'b01010
`define SLLV_CONTROL    5'b01011
`define SRLV_CONTROL    5'b01100
`define SRAV_CONTROL    5'b01101

`define ADD_CONTROL     5'b10000
`define ADDU_CONTROL    5'b10001
`define SUB_CONTROL     5'b10010
`define SUBU_CONTROL    5'b10011
`define SLT_CONTROL     5'b10100
`define SLTU_CONTROL    5'b10101

`define MULT_CONTROL    5'b11000
`define MULTU_CONTROL   5'b11001
`define DIV_CONTROL     5'b11010
`define DIVU_CONTROL    5'b11011

`define MFHI_CONTROL    5'b11100
`define MTHI_CONTROL    5'b11101
`define MFLO_CONTROL    5'b11110
`define MTLO_CONTROL    5'b11111

`define MFC0_CONTROL    5'b10110
`define MTC0_CONTROL    5'b10111

//CP0
`define CP0_BADVADDR    5'b01000       //只读
`define CP0_COUNT    5'b01001        //可读写
`define CP0_COMPARE    5'b01011      //可读写
`define CP0_STATUS    5'b01100       //可读写
`define CP0_CAUSE    5'b01101        //只读
`define CP0_EPC    5'b01110          //可读写
`define CP0_PRID    5'b01111         //只读
`define CP0_CONFIG    5'b10000       //只读