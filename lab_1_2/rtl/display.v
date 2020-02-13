`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/17 01:12:00
// Design Name: 
// Module Name: display
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



module display(
    input wire clk,reset,
    input wire [31:0]s,
    output wire [6:0]seg,
    output reg [7:0]ans
    );
    reg [20:0]count;
    reg [4:0]digit; 

    always @(*) begin :
    
    end

    always@(posedge clk,posedge reset)
    if(reset)  
        count = 0;
    else 
        count = count + 1;
       
    always @(posedge clk)
    case(count[20:18])
        0:begin
            ans = 8'b11111110;
            digit = s[3:0];
        end
        
        1:begin
            ans = 8'b11111101;
            digit = s[7:4];
        end

        2:begin
            ans = 8'b11111011;
            digit =s[11:8];
        end
        
        3:begin
            ans = 8'b11110111;
            digit = s[15:12];
        end
        
         4:begin
             ans = 8'b11101111;
             digit = s[19:16];
         end
               
         5:begin
             ans = 8'b11011111;
             digit = s[23:20];
         end
       
         6:begin
             ans = 8'b10111111;
             digit =s[27:24];
         end
               
         7:begin
             ans = 8'b01111111;
             digit = s[31:28];
         end
    endcase
    
    seg7 U4(.din(digit),.dout(seg));
endmodule