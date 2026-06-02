`timescale 1ns / 1ps

module aludec(
    input wire[5:0] funct,
    input wire[2:0] aluop,
    output reg[3:0] alucontrol,
    output reg jr
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

    always @(*) begin
        jr = 1'b0;
        case (aluop)
            3'b000: alucontrol = ALU_ADD; // lw/sw/addi
            3'b001: alucontrol = ALU_SUB; // beq/bne compare
            3'b010: alucontrol = ALU_OR;  // ori
            3'b011: alucontrol = ALU_AND; // andi
            3'b100: alucontrol = ALU_XOR; // xori
            3'b101: alucontrol = ALU_LUI; // lui
            3'b110: begin                 // R-type
                case (funct)
                    6'b100000: alucontrol = ALU_ADD; // add
                    6'b100001: alucontrol = ALU_ADD; // addu
                    6'b100010: alucontrol = ALU_SUB; // sub
                    6'b100011: alucontrol = ALU_SUB; // subu
                    6'b100100: alucontrol = ALU_AND; // and
                    6'b100101: alucontrol = ALU_OR;  // or
                    6'b100110: alucontrol = ALU_XOR; // xor (bonus for tests/tools)
                    6'b101010: alucontrol = ALU_SLT; // slt
                    6'b000000: alucontrol = ALU_SLL; // sll
                    6'b000010: alucontrol = ALU_SRL; // srl
                    6'b001000: begin                 // jr
                        alucontrol = ALU_ADD;
                        jr = 1'b1;
                    end
                    default: alucontrol = ALU_AND;
                endcase
            end
            default: alucontrol = ALU_AND;
        endcase
    end
endmodule
