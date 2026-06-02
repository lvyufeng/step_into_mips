`timescale 1ns / 1ps

module controller(
    input wire clk,
    input wire rst,
    // decode stage
    input wire[5:0] opD,
    input wire[4:0] rsD,
    input wire[5:0] functD,
    input wire equalD,
    output wire pcsrcD,
    output wire branchD,
    output wire jumpD,
    output wire jrD,
    output wire jalD,
    output wire eretD,
    output wire cp0toregD,
    output wire cp0writeD,
    output wire[1:0] immsrcD,

    // execute stage
    input wire flushE,
    output wire memtoregE,
    output wire alusrcE,
    output wire[1:0] regdstE,
    output wire regwriteE,
    output wire jalE,
    output wire cp0toregE,
    output wire cp0writeE,
    output wire memwriteE,
    output wire[3:0] alucontrolE,

    // mem stage
    output wire memtoregM,
    output wire memwriteM,
    output wire regwriteM,
    output wire jalM,
    output wire cp0toregM,
    output wire cp0writeM,

    // writeback stage
    output wire memtoregW,
    output wire regwriteW,
    output wire jalW,
    output wire cp0toregW
    );

    wire memtoregD;
    wire memwriteD_raw;
    wire alusrcD;
    wire[1:0] regdstD;
    wire regwriteD_raw;
    wire branchneD;
    wire[2:0] aluopD;
    wire[3:0] alucontrolD;
    wire jr_from_aluD;

    wire memwriteD;
    wire regwriteD;

    maindec md(
        .op(opD),
        .rs(rsD),
        .funct(functD),
        .memtoreg(memtoregD),
        .memwrite(memwriteD_raw),
        .branch(branchD),
        .branchne(branchneD),
        .alusrc(alusrcD),
        .regdst(regdstD),
        .regwrite(regwriteD_raw),
        .jump(jumpD),
        .jal(jalD),
        .eret(eretD),
        .cp0toreg(cp0toregD),
        .cp0write(cp0writeD),
        .immsrc(immsrcD),
        .aluop(aluopD)
        );

    aludec ad(
        .funct(functD),
        .aluop(aluopD),
        .alucontrol(alucontrolD),
        .jr(jr_from_aluD)
        );

    assign jrD = jr_from_aluD & ~eretD;
    assign pcsrcD = branchD & (branchneD ? ~equalD : equalD);
    assign memwriteD = memwriteD_raw & ~jrD & ~eretD;
    assign regwriteD = regwriteD_raw & ~jrD & ~eretD;

    // E pipeline controls: 1+1+1+2+1+1+1+1+4 = 13 bits
    floprc #(13) regE(
        .clk(clk),
        .rst(rst),
        .clear(flushE),
        .d({memtoregD, memwriteD, alusrcD, regdstD, regwriteD, jalD, cp0toregD, cp0writeD, alucontrolD}),
        .q({memtoregE, memwriteE, alusrcE, regdstE, regwriteE, jalE, cp0toregE, cp0writeE, alucontrolE})
        );

    // M pipeline controls
    flopr #(6) regM(
        .clk(clk),
        .rst(rst),
        .d({memtoregE, memwriteE, regwriteE, jalE, cp0toregE, cp0writeE}),
        .q({memtoregM, memwriteM, regwriteM, jalM, cp0toregM, cp0writeM})
        );

    // W pipeline controls
    flopr #(4) regW(
        .clk(clk),
        .rst(rst),
        .d({memtoregM, regwriteM, jalM, cp0toregM}),
        .q({memtoregW, regwriteW, jalW, cp0toregW})
        );
endmodule
