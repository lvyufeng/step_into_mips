`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 20:21:43
// Design Name: 
// Module Name: top
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


module top(
	input wire hclk,rst,
	output wire [6:0]seg,
    output wire [7:0]ans,
    output wire [9:0]led
    );
	wire [8 : 0] addra;
	wire [31 : 0] douta;
	wire ce;
	wire clk;

	clk_div clk_div(
		.hclk(hclk),
		.lclk(clk),
		.rst(rst)
		);

	controller controller_1(
		.op(douta[31:26]),
		.funct(douta[5:0]),
		.zero(1'b0),
		.memtoreg(led[9]),
		.memwrite(led[8]),
		.pcsrc(led[7]),
		.alusrc(led[6]),
		.regdst(led[5]),
		.regwrite(led[4]),
		.jump(led[3]),
		.alucontrol(led[2:0])
    );
	pc pc(
		.clk(clk),
		.rst(rst),

		.pc(addra),
		.ce(ce)
    );
    inst_rom inst_rom (
		.clka(clk),    // input wire clka
		.ena(ce),      // input wire ena
		.addra(addra),  // input wire [8 : 0] addra
		.douta(douta)  // output wire [31 : 0] douta
	);

	display display(
	   .clk(hclk),
	   .reset(rst),
	   .s(douta),
	   .seg(seg),
	   .ans(ans)
    );
endmodule
