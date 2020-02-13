`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/22 09:53:32
// Design Name: 
// Module Name: floprc
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


module floprc #(parameter WIDTH = 8)(
	input wire clk,rst,clear,
	input wire[WIDTH-1:0] d,
	output reg[WIDTH-1:0] q
    );

	always @(posedge clk,posedge rst) begin
		if(rst) begin
			q <= 0;
		end else if (clear)begin
			q <= 0;
		end else begin 
			q <= d;
		end
	end
endmodule
