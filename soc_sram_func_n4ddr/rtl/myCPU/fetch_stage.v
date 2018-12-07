`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/02 16:14:02
// Design Name: 
// Module Name: fetch_stage
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


module fetch_stage(
    input wire clk,
    input wire resetn,            //low active
	input wire stall,
    input wire flush,
	input wire [31:0] pc_next,newpc,

	output reg [31:0] inst_sram_addr,
    output wire inst_sram_en,
    output wire  [31:0] pc
    );

    always @(posedge clk) begin
        if (~resetn) begin
            inst_sram_addr <= 32'hbfc00000;
        end else if(flush) begin
            inst_sram_addr <= newpc;
        end else if(~stall) begin
            inst_sram_addr <= pc_next;
        end
    end

    assign pc = inst_sram_addr;
    assign inst_sram_en = ~resetn ? 1'b0 :
                        flush ? 1'b0 :
                        stall ? 1'b0 : 1'b1;
    // assign inst_sram_addr = ~resetn ? 32'hbfc00000 :
                            // ~stall ? pc_next :
                            // pc;

    
endmodule
