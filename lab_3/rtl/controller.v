`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: controller
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


module controller(
	input wire[5:0] op,funct,
	input wire zero,
	output wire memtoreg,memwrite,
	output wire pcsrc,alusrc,
	output wire regdst,regwrite,
	output wire jump,
	output wire[2:0] alucontrol
    );
	wire[1:0] aluop;
	wire branch;

	maindec md(op,memtoreg,memwrite,branch,alusrc,regdst,regwrite,jump,aluop);
	aludec ad(funct,aluop,alucontrol);

	assign pcsrc = branch & zero;
endmodule
