`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/24 16:59:00
// Design Name: 
// Module Name: calculate
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


module calculate(
    input wire [7:0] num1,
    input wire [2:0] op,
    output [31:0] result
    );
    wire [31:0] num2;
    wire [31:0] Sign_extend;
    
    assign num2 = 32'h00000001;
    assign Sign_extend={{24{1'b0}},num1[7:0]};
    assign result = (op == 3'b000)? Sign_extend + num2:
                    (op == 3'b001)? Sign_extend - num2:
                    (op == 3'b010)? Sign_extend & num2:
                    (op == 3'b011)? Sign_extend | num2:
                    (op == 3'b100)? ~Sign_extend: 32'h00000000;
endmodule
