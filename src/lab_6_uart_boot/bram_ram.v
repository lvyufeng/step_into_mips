`timescale 1ns / 1ps

module bram_ram #(
    parameter ADDR_WIDTH = 10
)(
    input wire clk,
    input wire we,
    input wire[ADDR_WIDTH-1:0] word_addr,
    input wire[31:0] wdata,
    output reg[31:0] rdata
    );

    reg [31:0] ram[0:(1 << ADDR_WIDTH)-1];

    always @(posedge clk) begin
        if (we) begin
            ram[word_addr] <= wdata;
        end
        rdata <= ram[word_addr];
    end
endmodule
