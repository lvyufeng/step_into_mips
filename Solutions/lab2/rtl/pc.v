`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: pc
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


module pc(
	input wire clk,
	input wire rst,

	output reg[8:0] pc,
	output reg ce
    );

	always @(posedge clk) begin
		if(rst == 1'b1) begin
			 ce <= 1'b0;
		end else begin
			 ce <= 1'b1;
		end
	end

	always @(posedge clk) begin
		if(ce == 1'b0) begin
			 pc <= 9'h00;
		end else begin
			 pc <= pc + 4'h1;
		end
	end
endmodule
