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
    input wire eretD,
    input wire cp0toregD,
    input wire cp0writeD,
    input wire[1:0] immsrcD,
    output wire equalD,
    output wire[5:0] opD,
    output wire[4:0] rsD,
    output wire[5:0] functD,
    // execute stage
    input wire memtoregE,
    input wire alusrcE,
    input wire[1:0] regdstE,
    input wire regwriteE,
    input wire jalE,
    input wire cp0toregE,
    input wire cp0writeE,
    input wire memwriteE,
    input wire[3:0] alucontrolE,
    output wire flushE,
    // mem stage
    input wire memtoregM,
    input wire regwriteM,
    input wire jalM,
    input wire cp0toregM,
    input wire cp0writeM,
    input wire memwriteM,
    input wire memstallM,
    output wire[31:0] aluoutM,
    output wire[31:0] writedataM,
    output wire[3:0] wstrbM,
    input wire[31:0] readdataM,
    // writeback stage
    input wire memtoregW,
    input wire regwriteW,
    input wire jalW,
    input wire cp0toregW,
    // interrupts
    input wire[7:0] irq_lines,
    output wire takeinterruptD
    );

    localparam EXCEPTION_VECTOR = 32'h00000180;

    // fetch stage
    wire stallF;
    wire[31:0] pcnextFD;
    wire[31:0] pcnextbrFD;
    wire[31:0] pcnextjumpFD;
    wire[31:0] pcnextjrFD;
    wire[31:0] pcnextEretFD;
    wire[31:0] pcplus4F;

    // decode stage
    wire[31:0] pcplus4D;
    wire[31:0] instrD;
    wire[31:0] pcbranchD;
    wire[31:0] jumpaddrD;
    wire forwardaD, forwardbD;
    wire[4:0] rtD, rdD;
    wire stallD;
    wire flushD;
    wire validD;
    wire hazardFlushE;
    wire[31:0] signimmD;
    wire[31:0] zeroimmD;
    wire[31:0] immD;
    wire[31:0] signimmshD;
    wire[31:0] srcaD, srca2D, srcbD, srcb2D;
    wire[4:0] shamtD;
    wire[31:0] cp0rdataD;
    wire[31:0] cp0epcD;
    wire cp0irqActiveD;
    wire eretTakeD;
    wire[31:0] interruptEpcD;

    // execute stage
    wire[1:0] forwardaE, forwardbE;
    wire[4:0] rsE, rtE, rdE;
    wire[4:0] writeregE;
    wire[4:0] shamtE;
    wire[4:0] cp0addrE;
    wire[31:0] immE;
    wire[31:0] pcplus4E;
    wire[31:0] cp0rdataE;
    wire[31:0] srcaE, srca2E, srcbE, srcb2E, srcb3E;
    wire[31:0] aluoutE;
    wire[31:0] linkE;

    // mem stage
    wire[4:0] writeregM;
    wire[4:0] cp0addrM;
    wire[31:0] linkM;
    wire[31:0] cp0rdataM;
    wire[31:0] resultM;
    wire[31:0] alu_or_cp0M;

    // writeback stage
    wire[4:0] writeregW;
    wire[31:0] aluoutW;
    wire[31:0] readdataW;
    wire[31:0] linkW;
    wire[31:0] cp0rdataW;
    wire[31:0] resultW;
    wire[31:0] mem_or_aluW;
    wire[31:0] cp0_or_memaluW;

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
        .flushE(hazardFlushE),
        .writeregM(writeregM),
        .regwriteM(regwriteM),
        .memtoregM(memtoregM),
        .writeregW(writeregW),
        .regwriteW(regwriteW)
        );

    // CP0 and interrupt entry. Interrupts are accepted at the decode boundary.
    // A slow memory transaction in M is older than the D-stage instruction, so
    // exception entry waits until the memory request has completed.
    assign eretTakeD = eretD & validD & ~stallD & ~memstallM;
    assign takeinterruptD = cp0irqActiveD & validD & ~stallD & ~eretD & ~memstallM;
    assign interruptEpcD = pcplus4D - 32'd4;

    cp0 cp0(
        .clk(clk),
        .rst(rst),
        .raddr(rdD),
        .rdata(cp0rdataD),
        .mtc0we(cp0writeM),
        .waddr(cp0addrM),
        .wdata(writedataM),
        .hwirq(irq_lines),
        .exc_take(takeinterruptD),
        .exc_epc(interruptEpcD),
        .eret(eretTakeD),
        .epc(cp0epcD),
        .irq_active(cp0irqActiveD)
        );

    // next PC logic: branch/jump/jr/eret/interrupt resolve in D stage.
    // No architectural delay slot. Interrupt has highest priority.
    mux2 #(32) pcbrmux(pcplus4F, pcbranchD, pcsrcD, pcnextbrFD);
    assign jumpaddrD = {pcplus4D[31:28], instrD[25:0], 2'b00};
    mux2 #(32) pcmux(pcnextbrFD, jumpaddrD, jumpD, pcnextjumpFD);
    mux2 #(32) pcjrmux(pcnextjumpFD, srca2D, jrD, pcnextjrFD);
    mux2 #(32) pceretmux(pcnextjrFD, cp0epcD, eretTakeD, pcnextEretFD);
    mux2 #(32) pcirqmux(pcnextEretFD, EXCEPTION_VECTOR, takeinterruptD, pcnextFD);
    assign flushD = (pcsrcD | jumpD | jrD | eretTakeD | takeinterruptD) & ~stallD & ~memstallM;
    assign flushE = (hazardFlushE | eretTakeD | takeinterruptD) & ~memstallM;

    // regfile (decode read, writeback write)
    regfile rf(clk, regwriteW, rsD, rtD, writeregW, resultW, srcaD, srcbD);

    // fetch stage
    pc #(32) pcreg(clk, rst, ~stallF & ~memstallM, pcnextFD, pcF);
    adder pcadd1(pcF, 32'd4, pcplus4F);

    // decode stage
    flopenr #(32) r1D(clk, rst, ~stallD & ~memstallM, pcplus4F, pcplus4D);
    flopenrc #(32) r2D(clk, rst, ~stallD & ~memstallM, flushD, instrF, instrD);
    flopenrc #(1)  r3D(clk, rst, ~stallD & ~memstallM, flushD, 1'b1, validD);

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
    flopenrc #(32) r1E(clk, rst, ~memstallM, flushE, srcaD, srcaE);
    flopenrc #(32) r2E(clk, rst, ~memstallM, flushE, srcbD, srcbE);
    flopenrc #(32) r3E(clk, rst, ~memstallM, flushE, immD, immE);
    flopenrc #(5)  r4E(clk, rst, ~memstallM, flushE, rsD, rsE);
    flopenrc #(5)  r5E(clk, rst, ~memstallM, flushE, rtD, rtE);
    flopenrc #(5)  r6E(clk, rst, ~memstallM, flushE, rdD, rdE);
    flopenrc #(5)  r7E(clk, rst, ~memstallM, flushE, shamtD, shamtE);
    flopenrc #(32) r8E(clk, rst, ~memstallM, flushE, pcplus4D, pcplus4E);
    flopenrc #(32) r9E(clk, rst, ~memstallM, flushE, cp0rdataD, cp0rdataE);
    flopenrc #(5)  r10E(clk, rst, ~memstallM, flushE, rdD, cp0addrE);

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
    flopenr #(32) r1M(clk, rst, ~memstallM, srcb2E, writedataM);
    flopenr #(32) r2M(clk, rst, ~memstallM, aluoutE, aluoutM);
    flopenr #(5)  r3M(clk, rst, ~memstallM, writeregE, writeregM);
    flopenr #(32) r4M(clk, rst, ~memstallM, linkE, linkM);
    flopenr #(32) r5M(clk, rst, ~memstallM, cp0rdataE, cp0rdataM);
    flopenr #(5)  r6M(clk, rst, ~memstallM, cp0addrE, cp0addrM);
    mux2 #(32) cp0forwardmux(aluoutM, cp0rdataM, cp0toregM, alu_or_cp0M);
    mux2 #(32) linkforwardmux(alu_or_cp0M, linkM, jalM, resultM);
    assign wstrbM = memwriteM ? 4'b1111 : 4'b0000;

    // writeback stage
    flopenr #(32) r1W(clk, rst, ~memstallM, aluoutM, aluoutW);
    flopenr #(32) r2W(clk, rst, ~memstallM, readdataM, readdataW);
    flopenr #(5)  r3W(clk, rst, ~memstallM, writeregM, writeregW);
    flopenr #(32) r4W(clk, rst, ~memstallM, linkM, linkW);
    flopenr #(32) r5W(clk, rst, ~memstallM, cp0rdataM, cp0rdataW);

    mux2 #(32) resmux(aluoutW, readdataW, memtoregW, mem_or_aluW);
    mux2 #(32) cp0resmux(mem_or_aluW, cp0rdataW, cp0toregW, cp0_or_memaluW);
    mux2 #(32) linkmux(cp0_or_memaluW, linkW, jalW, resultW);
endmodule
