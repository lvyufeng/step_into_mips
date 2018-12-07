`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/02 19:09:37
// Design Name: 
// Module Name: wb_stage
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


module wb_stage(
    input wire clk,resetn,
    input wire stall,flush,
    input wire[31:0] pc,result,
    input wire[4:0] writereg,
    input wire controls,
    output wire[31:0] pc_next,result_next,
    output reg[4:0] writereg_next,
    output wire regwrite,

    input wire hilo_write,
    input wire[63:0] hilo,
    output reg hilo_write_next,
    output reg[63:0] hilo_next,
    //cp0
	input wire cp0_write,
	output reg cp0_write_next
    );

    reg[31:0] pcW,resultW;
    reg controlsW;

    always @(posedge clk) begin
        if (~resetn) begin
            pcW <= 32'hbfc00000;
            resultW <= 32'b0;
            writereg_next <= 5'b0;
            controlsW <= 1'b0;
            hilo_next <= 64'b0;
            hilo_write_next <= 1'b0;
            cp0_write_next <= 1'b0;
        end else if(flush) begin
            pcW <= 32'hbfc00000;
            resultW <= 32'b0;
            writereg_next <= 5'b0;
            controlsW <= 1'b0;
            hilo_next <= 64'b0;
            hilo_write_next <= 1'b0;
            cp0_write_next <= 1'b0;
        end else if(~stall) begin
            pcW <= pc;
            resultW <= result;
            writereg_next <= writereg;
            controlsW <= controls;
            hilo_next <= hilo;
            hilo_write_next <= hilo_write;
            cp0_write_next <= cp0_write;
        end
    end

    assign pc_next = pcW;
    assign result_next = resultW;
    assign regwrite = controlsW;
endmodule
