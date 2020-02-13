`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/28 15:58:09
// Design Name: 
// Module Name: Rom
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


module Rom(
    input [15:0] ins,
    input clk,
    input reset,
    output [6:0] seg,
    output [7:0] ans
    );
    wire [31:0] InsData;
    Ins_ROM Ins_Rom(.clka(clk),         // input wire clka
            .addra({{16{ins[15]}},ins[15:0]}),     // input wire [15 : 0] addra
            .douta(InsData[31:0])         // output wire [31 : 0] douta
    );
    display display_0(.clk(clk),.reset(reset),.s(InsData),.ans(ans),.seg(seg));
            
endmodule
