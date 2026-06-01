`timescale 1ns / 1ps

module boot_rom(
    input wire clk,
    input wire[7:0] a,
    output reg[31:0] spo
    );

    reg [31:0] rom[0:255];

    initial begin
        $readmemh("lab_6_boot.mem", rom);
    end

    always @(posedge clk) begin
        spo <= rom[a];
    end
endmodule
