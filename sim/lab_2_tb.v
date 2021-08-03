`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/25 19:30:17
// Design Name: 
// Module Name: test_bench
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


module test_bench(

    );
	
	reg rst;
	reg clk;
	wire [7:0] ans;
	wire [6:0] seg;
	wire [9:0] led;
	initial
	begin 
		clk = 1'b0;
		rst = 1'b1;
		#500;
		rst = 1'b0;
	end
	always #10 clk = ~clk;
	top top(
		.hclk(clk),
		.rst(rst),
		.seg(seg),
	    .ans(ans),
	    .led(led)
		);
endmodule
