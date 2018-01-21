`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/25 17:41:44
// Design Name: 
// Module Name: clk_div
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


module clk_div(
	input wire hclk,
	output reg lclk,
	input wire rst
    );
	
	reg[31:0] cnt = 32'd0;
	reg gatebuf = 1'b0;
	always @(posedge hclk) begin
		//cnt == 32'd50000000
		if(cnt == 32'd50000000) begin
			gatebuf <= ~gatebuf;
			lclk <= gatebuf;
			cnt <= 32'd0;
		end else begin
			cnt <= cnt + 32'd1;
		end
	end
endmodule
