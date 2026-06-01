`timescale 1ns / 1ps

module inst_mem(
    input wire clk,
    input wire[5:0] a,
    output reg[31:0] spo
    );

    reg [31:0] ram[0:63];

    initial begin
        $readmemh("lab_4_inst.mem", ram);
    end

    always @(posedge clk) begin
        spo <= ram[a];
    end
endmodule
