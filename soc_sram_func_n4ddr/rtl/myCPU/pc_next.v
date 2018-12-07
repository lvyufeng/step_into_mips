`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/02 16:09:12
// Design Name: 
// Module Name: pc_next
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


module pc_next(
    input wire[31:0] pc,inst,
    input wire[2:0] signal,//1 jump 0 jr
    input wire[31:0] jr_src,
    output wire[31:0] pc_next
    );

    assign pc_next = signal[2] ? pc + {{14{inst[15]}},inst[15:0],2'b00} :
                    signal[1] ? {pc[31:28],inst[25:0],2'b00} : 
                    signal[0] ? jr_src :
                    pc + 4;
endmodule
