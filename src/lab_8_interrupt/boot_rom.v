`timescale 1ns / 1ps

module boot_rom(
    input wire clk,
    input wire[9:0] a,
    output reg[31:0] spo
    );

    reg [31:0] rom[0:1023];

    initial begin
        $readmemh("lab_8_boot.mem", rom);
    end

    always @(posedge clk) begin
        spo <= rom[a];
    end
endmodule
