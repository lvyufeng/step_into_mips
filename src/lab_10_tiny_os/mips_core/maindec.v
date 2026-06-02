`timescale 1ns / 1ps

module maindec(
    input wire[5:0] op,
    input wire[4:0] rs,
    input wire[5:0] funct,
    output reg memtoreg,
    output reg memwrite,
    output reg branch,
    output reg branchne,
    output reg alusrc,
    output reg[1:0] regdst,
    output reg regwrite,
    output reg jump,
    output reg jal,
    output reg eret,
    output reg cp0toreg,
    output reg cp0write,
    output reg[1:0] immsrc,
    output reg[2:0] aluop
    );

    localparam IMM_SIGN  = 2'b00;
    localparam IMM_ZERO  = 2'b01;
    localparam IMM_UPPER = 2'b10;

    always @(*) begin
        memtoreg = 1'b0;
        memwrite = 1'b0;
        branch   = 1'b0;
        branchne = 1'b0;
        alusrc   = 1'b0;
        regdst   = 2'b00; // rt
        regwrite = 1'b0;
        jump     = 1'b0;
        jal      = 1'b0;
        eret     = 1'b0;
        cp0toreg = 1'b0;
        cp0write = 1'b0;
        immsrc   = IMM_SIGN;
        aluop    = 3'b000; // add

        case (op)
            6'b000000: begin // R-type
                regwrite = 1'b1;
                regdst = 2'b01; // rd
                aluop = 3'b110;
            end
            6'b100011: begin // lw
                regwrite = 1'b1;
                memtoreg = 1'b1;
                alusrc = 1'b1;
                aluop = 3'b000;
            end
            6'b101011: begin // sw
                memwrite = 1'b1;
                alusrc = 1'b1;
                aluop = 3'b000;
            end
            6'b000100: begin // beq
                branch = 1'b1;
                aluop = 3'b001;
            end
            6'b000101: begin // bne
                branch = 1'b1;
                branchne = 1'b1;
                aluop = 3'b001;
            end
            6'b001000: begin // addi
                regwrite = 1'b1;
                alusrc = 1'b1;
                aluop = 3'b000;
            end
            6'b001101: begin // ori
                regwrite = 1'b1;
                alusrc = 1'b1;
                immsrc = IMM_ZERO;
                aluop = 3'b010;
            end
            6'b001100: begin // andi
                regwrite = 1'b1;
                alusrc = 1'b1;
                immsrc = IMM_ZERO;
                aluop = 3'b011;
            end
            6'b001110: begin // xori
                regwrite = 1'b1;
                alusrc = 1'b1;
                immsrc = IMM_ZERO;
                aluop = 3'b100;
            end
            6'b001111: begin // lui
                regwrite = 1'b1;
                alusrc = 1'b1;
                immsrc = IMM_UPPER;
                aluop = 3'b101;
            end
            6'b000010: begin // j
                jump = 1'b1;
            end
            6'b000011: begin // jal
                jump = 1'b1;
                jal = 1'b1;
                regwrite = 1'b1;
                regdst = 2'b10; // $31
            end
            6'b010000: begin // COP0
                case (rs)
                    5'b00000: begin // mfc0
                        regwrite = 1'b1;
                        regdst = 2'b00; // rt
                        cp0toreg = 1'b1;
                    end
                    5'b00100: begin // mtc0
                        cp0write = 1'b1;
                    end
                    5'b10000: begin // eret (rs field = CO, funct = 011000)
                        if (funct == 6'b011000) begin
                            eret = 1'b1;
                        end
                    end
                    default: ;
                endcase
            end
            default: begin
                // illegal op: all controls remain deasserted
            end
        endcase
    end
endmodule
