`timescale 1ns / 1ps

module data_mem(
    input wire clk,
    input wire we,
    input wire[31:0] a,
    input wire[31:0] d,
    output reg[31:0] spo
    );

    reg [31:0] ram[0:1023];
    wire [9:0] word_addr = a[11:2];

    always @(posedge clk) begin
        if (we) begin
            ram[word_addr] <= d;
        end
        spo <= ram[word_addr];
    end
endmodule
