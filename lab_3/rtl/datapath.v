`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 15:12:22
// Design Name: 
// Module Name: datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath(
	input wire clk,rst,
	input wire memtoreg,pcsrc,
	input wire alusrc,regdst,
	input wire regwrite,jump,
	input wire[2:0] alucontrol,
	output wire overflow,zero,
	output wire[31:0] pc,
	input wire[31:0] instr,
	output wire[31:0] aluout,writedata,
	input wire[31:0] readdata
    );
	
	wire[4:0] writereg;
	wire[31:0] pcnext,pcnextbr,pcplus4,pcbranch;
	wire[31:0] signimm,signimmsh;
	wire[31:0] srca,srcb;
	wire[31:0] result;

	flopr #(32) pcreg(clk,rst,pcnext,pc);
	adder pcadd1(pc,32'b100,pcplus4);
	sl2 immsh(signimm,signimmsh);
	adder pcadd2(pcplus4,signimmsh,pcbranch);
	mux2 #(32) pcbrmux(pcplus4,pcbranch,pcsrc,pcnextbr);
	mux2 #(32) pcmux(pcnextbr,{pcplus4[31:28],instr[25:0],2'b00},jump,pcnext);

	regfile rf(clk,regwrite,instr[25:21],instr[20:16],writereg,result,srca,writedata);
	mux2 #(5) wrmux(instr[20:16],instr[15:11],regdst,writereg);
	mux2 #(32) resmux(aluout,readdata,memtoreg,result);
	signext se(instr[15:0],signimm);

	mux2 #(32) srcbmux(writedata,signimm,alusrc,srcb);
	alu alu(srca,srcb,alucontrol,aluout,overflow,zero);

endmodule
