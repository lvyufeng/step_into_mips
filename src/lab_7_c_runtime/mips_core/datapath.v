`timescale 1ns / 1ps

module datapath(
    input wire clk,
    input wire rst,
    // fetch stage
    output wire[31:0] pcF,
    input wire[31:0] instrF,
    // decode stage
    input wire pcsrcD,
    input wire branchD,
    input wire jumpD,
    input wire jrD,
    input wire jalD,
    input wire[1:0] immsrcD,
    output wire equalD,
    output wire[5:0] opD,
    output wire[5:0] functD,
    // execute stage
    input wire memtoregE,
    input wire alusrcE,
    input wire[1:0] regdstE,
    input wire regwriteE,
    input wire jalE,
    input wire memwriteE,
    input wire[3:0] alucontrolE,
    output wire flushE,
    // mem stage
    input wire memtoregM,
    input wire regwriteM,
    input wire jalM,
    input wire memwriteM,
    output wire[31:0] aluoutM,
    output wire[31:0] writedataM,
    output wire[3:0] wstrbM,
    input wire[31:0] readdataM,
    // writeback stage
    input wire memtoregW,
    input wire regwriteW,
    input wire jalW
    );

    // fetch stage
    wire stallF;
    wire[31:0] pcnextFD;
    wire[31:0] pcnextbrFD;
    wire[31:0] pcnextjumpFD;
    wire[31:0] pcplus4F;

    // decode stage
    wire[31:0] pcplus4D;
    wire[31:0] instrD;
    wire[31:0] pcbranchD;
    wire[31:0] jumpaddrD;
    wire forwardaD, forwardbD;
    wire[4:0] rsD, rtD, rdD;
    wire stallD;
    wire flushD;
    wire[31:0] signimmD;
    wire[31:0] zeroimmD;
    wire[31:0] immD;
    wire[31:0] signimmshD;
    wire[31:0] srcaD, srca2D, srcbD, srcb2D;
    wire[4:0] shamtD;

    // execute stage
    wire[1:0] forwardaE, forwardbE;
    wire[4:0] rsE, rtE, rdE;
    wire[4:0] writeregE;
    wire[4:0] shamtE;
    wire[31:0] immE;
    wire[31:0] pcplus4E;
    wire[31:0] srcaE, srca2E, srcbE, srcb2E, srcb3E;
    wire[31:0] aluoutE;
    wire[31:0] linkE;

    // mem stage
    wire[4:0] writeregM;
    wire[31:0] linkM;
    wire[31:0] resultM;

    // writeback stage
    wire[4:0] writeregW;
    wire[31:0] aluoutW;
    wire[31:0] readdataW;
    wire[31:0] linkW;
    wire[31:0] resultW;
    wire[31:0] mem_or_aluW;

    hazard h(
        .stallF(stallF),
        .rsD(rsD),
        .rtD(rtD),
        .branchD(branchD),
        .jrD(jrD),
        .forwardaD(forwardaD),
        .forwardbD(forwardbD),
        .stallD(stallD),
        .rsE(rsE),
        .rtE(rtE),
        .writeregE(writeregE),
        .regwriteE(regwriteE),
        .memtoregE(memtoregE),
        .forwardaE(forwardaE),
        .forwardbE(forwardbE),
        .flushE(flushE),
        .writeregM(writeregM),
        .regwriteM(regwriteM),
        .memtoregM(memtoregM),
        .writeregW(writeregW),
        .regwriteW(regwriteW)
        );

    // next PC logic: branch/jump/jr resolve in D stage. No architectural delay slot.
    mux2 #(32) pcbrmux(pcplus4F, pcbranchD, pcsrcD, pcnextbrFD);
    assign jumpaddrD = {pcplus4D[31:28], instrD[25:0], 2'b00};
    mux2 #(32) pcmux(pcnextbrFD, jumpaddrD, jumpD, pcnextjumpFD);
    mux2 #(32) pcjrmux(pcnextjumpFD, srca2D, jrD, pcnextFD);
    assign flushD = (pcsrcD | jumpD | jrD) & ~stallD;

    // regfile (decode read, writeback write)
    regfile rf(clk, regwriteW, rsD, rtD, writeregW, resultW, srcaD, srcbD);

    // fetch stage
    pc #(32) pcreg(clk, rst, ~stallF, pcnextFD, pcF);
    adder pcadd1(pcF, 32'd4, pcplus4F);

    // decode stage
    flopenr #(32) r1D(clk, rst, ~stallD, pcplus4F, pcplus4D);
    flopenrc #(32) r2D(clk, rst, ~stallD, flushD, instrF, instrD);

    assign signimmD = {{16{instrD[15]}}, instrD[15:0]};
    assign zeroimmD = {16'b0, instrD[15:0]};
    assign immD = (immsrcD == 2'b01) ? zeroimmD :
                  (immsrcD == 2'b10) ? zeroimmD : signimmD;
    assign signimmshD = signimmD << 2;
    adder pcadd2(pcplus4D, signimmshD, pcbranchD);

    mux2 #(32) forwardamux(srcaD, resultM, forwardaD, srca2D);
    mux2 #(32) forwardbmux(srcbD, resultM, forwardbD, srcb2D);
    eqcmp comp(srca2D, srcb2D, equalD);

    assign opD = instrD[31:26];
    assign functD = instrD[5:0];
    assign rsD = instrD[25:21];
    assign rtD = instrD[20:16];
    assign rdD = instrD[15:11];
    assign shamtD = instrD[10:6];

    // execute stage
    floprc #(32) r1E(clk, rst, flushE, srcaD, srcaE);
    floprc #(32) r2E(clk, rst, flushE, srcbD, srcbE);
    floprc #(32) r3E(clk, rst, flushE, immD, immE);
    floprc #(5)  r4E(clk, rst, flushE, rsD, rsE);
    floprc #(5)  r5E(clk, rst, flushE, rtD, rtE);
    floprc #(5)  r6E(clk, rst, flushE, rdD, rdE);
    floprc #(5)  r7E(clk, rst, flushE, shamtD, shamtE);
    floprc #(32) r8E(clk, rst, flushE, pcplus4D, pcplus4E);

    mux3 #(32) forwardaemux(srcaE, resultW, resultM, forwardaE, srca2E);
    mux3 #(32) forwardbemux(srcbE, resultW, resultM, forwardbE, srcb2E);
    mux2 #(32) srcbmux(srcb2E, immE, alusrcE, srcb3E);

    wire alu_overflowE, alu_zeroE;
    alu alu(
        .a(srca2E),
        .b(srcb3E),
        .shamt(shamtE),
        .op(alucontrolE),
        .y(aluoutE),
        .overflow(alu_overflowE),
        .zero(alu_zeroE)
        );

    mux3 #(5) wrmux(rtE, rdE, 5'd31, regdstE, writeregE);
    assign linkE = pcplus4E;

    // mem stage
    flopr #(32) r1M(clk, rst, srcb2E, writedataM);
    flopr #(32) r2M(clk, rst, aluoutE, aluoutM);
    flopr #(5)  r3M(clk, rst, writeregE, writeregM);
    flopr #(32) r4M(clk, rst, linkE, linkM);
    assign resultM = jalM ? linkM : aluoutM;
    assign wstrbM = memwriteM ? 4'b1111 : 4'b0000;

    // writeback stage
    flopr #(32) r1W(clk, rst, aluoutM, aluoutW);
    flopr #(32) r2W(clk, rst, readdataM, readdataW);
    flopr #(5)  r3W(clk, rst, writeregM, writeregW);
    flopr #(32) r4W(clk, rst, linkM, linkW);

    mux2 #(32) resmux(aluoutW, readdataW, memtoregW, mem_or_aluW);
    mux2 #(32) linkmux(mem_or_aluW, linkW, jalW, resultW);
endmodule
