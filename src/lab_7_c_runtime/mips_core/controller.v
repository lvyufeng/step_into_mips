`timescale 1ns / 1ps

module controller(
    input wire clk,
    input wire rst,
    // decode stage
    input wire[5:0] opD,
    input wire[5:0] functD,
    input wire equalD,
    output wire pcsrcD,
    output wire branchD,
    output wire jumpD,
    output wire jrD,
    output wire jalD,
    output wire[1:0] immsrcD,

    // execute stage
    input wire flushE,
    output wire memtoregE,
    output wire alusrcE,
    output wire[1:0] regdstE,
    output wire regwriteE,
    output wire jalE,
    output wire memwriteE,
    output wire[3:0] alucontrolE,

    // mem stage
    output wire memtoregM,
    output wire memwriteM,
    output wire regwriteM,
    output wire jalM,

    // writeback stage
    output wire memtoregW,
    output wire regwriteW,
    output wire jalW
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
        .memtoreg(memtoregD),
        .memwrite(memwriteD_raw),
        .branch(branchD),
        .branchne(branchneD),
        .alusrc(alusrcD),
        .regdst(regdstD),
        .regwrite(regwriteD_raw),
        .jump(jumpD),
        .jal(jalD),
        .immsrc(immsrcD),
        .aluop(aluopD)
        );

    aludec ad(
        .funct(functD),
        .aluop(aluopD),
        .alucontrol(alucontrolD),
        .jr(jr_from_aluD)
        );

    assign jrD = jr_from_aluD;
    assign pcsrcD = branchD & (branchneD ? ~equalD : equalD);
    assign memwriteD = memwriteD_raw & ~jrD;
    assign regwriteD = regwriteD_raw & ~jrD;

    // E pipeline controls: 1 + 1 + 1 + 2 + 1 + 1 + 4 = 11 bits
    floprc #(11) regE(
        .clk(clk),
        .rst(rst),
        .clear(flushE),
        .d({memtoregD, memwriteD, alusrcD, regdstD, regwriteD, jalD, alucontrolD}),
        .q({memtoregE, memwriteE, alusrcE, regdstE, regwriteE, jalE, alucontrolE})
        );

    // M pipeline controls
    flopr #(4) regM(
        .clk(clk),
        .rst(rst),
        .d({memtoregE, memwriteE, regwriteE, jalE}),
        .q({memtoregM, memwriteM, regwriteM, jalM})
        );

    // W pipeline controls
    flopr #(3) regW(
        .clk(clk),
        .rst(rst),
        .d({memtoregM, regwriteM, jalM}),
        .q({memtoregW, regwriteW, jalW})
        );
endmodule
