`timescale 1ns / 1ps

module alu(
    input wire[31:0] a,
    input wire[31:0] b,
    input wire[4:0] shamt,
    input wire[3:0] op,
    output reg[31:0] y,
    output reg overflow,
    output wire zero
    );

    localparam ALU_AND = 4'b0000;
    localparam ALU_OR  = 4'b0001;
    localparam ALU_ADD = 4'b0010;
    localparam ALU_SUB = 4'b0011;
    localparam ALU_SLT = 4'b0100;
    localparam ALU_XOR = 4'b0101;
    localparam ALU_SLL = 4'b0110;
    localparam ALU_SRL = 4'b0111;
    localparam ALU_LUI = 4'b1000;

    wire[31:0] sum = a + b;
    wire[31:0] diff = a - b;

    always @(*) begin
        case (op)
            ALU_AND: y = a & b;
            ALU_OR:  y = a | b;
            ALU_ADD: y = sum;
            ALU_SUB: y = diff;
            ALU_SLT: y = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0;
            ALU_XOR: y = a ^ b;
            ALU_SLL: y = b << shamt;
            ALU_SRL: y = b >> shamt;
            ALU_LUI: y = {b[15:0], 16'b0};
            default: y = 32'b0;
        endcase
    end

    always @(*) begin
        case (op)
            ALU_ADD: overflow = (a[31] == b[31]) && (sum[31] != a[31]);
            ALU_SUB: overflow = (a[31] != b[31]) && (diff[31] != a[31]);
            default: overflow = 1'b0;
        endcase
    end

    assign zero = (y == 32'b0);
endmodule
