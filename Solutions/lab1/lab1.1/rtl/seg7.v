`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/17 01:14:44
// Design Name: 
// Module Name: seg7
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

module seg7(
    input wire [3:0]din,
    output reg [6:0]dout
    );
 
    always@(*)
    case(din)
        5'h0:dout = 7'b000_0001;
        5'h1:dout = 7'b100_1111;
        5'h2:dout = 7'b001_0010;
        5'h3:dout = 7'b000_0110;
        5'h4:dout = 7'b100_1100;
        5'h5:dout = 7'b010_0100;
        5'h6:dout = 7'b010_0000;
        5'h7:dout = 7'b000_1111;
        5'h8:dout = 7'b000_0000;
        5'h9:dout = 7'b000_0100;
        5'ha:dout = 7'b000_1000;
        5'hb:dout = 7'b110_0000;
        5'hc:dout = 7'b011_0001;
        5'hd:dout = 7'b100_0010;
        5'he:dout = 7'b011_0000;
        5'hf:dout = 7'b011_1000;
        default:dout = 7'b111_1111;        
    endcase
    
    
endmodule