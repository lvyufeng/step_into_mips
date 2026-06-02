`timescale 1ns / 1ps

module mips(
    input wire clk,
    input wire rst,
    output wire[31:0] pcF,
    input wire[31:0] instrF,
    output wire d_validM,
    input wire d_readyM,
    output wire memwriteM,
    output wire[3:0] wstrbM,
    output wire[31:0] aluoutM,
    output wire[31:0] writedataM,
    input wire[31:0] readdataM,
    input wire[7:0] irq_lines
    );

    wire[5:0] opD, functD;
    wire[4:0] rsD;
    wire pcsrcD, branchD, jumpD, jrD, jalD;
    wire eretD, cp0toregD, cp0writeD;
    wire[1:0] immsrcD;
    wire memtoregE, alusrcE, regwriteE, jalE, memwriteE, cp0toregE, cp0writeE;
    wire memtoregM, regwriteM, jalM, cp0toregM, cp0writeM;
    wire memtoregW, regwriteW, jalW, cp0toregW;
    wire[1:0] regdstE;
    wire[3:0] alucontrolE;
    wire flushE, equalD;
    wire takeinterruptD;
    wire memstallM;

    assign d_validM = memtoregM | memwriteM;
    assign memstallM = d_validM & ~d_readyM;

    controller c(
        .clk(clk),
        .rst(rst),
        .opD(opD),
        .rsD(rsD),
        .functD(functD),
        .equalD(equalD),
        .pcsrcD(pcsrcD),
        .branchD(branchD),
        .jumpD(jumpD),
        .jrD(jrD),
        .jalD(jalD),
        .eretD(eretD),
        .cp0toregD(cp0toregD),
        .cp0writeD(cp0writeD),
        .immsrcD(immsrcD),
        .flushE(flushE),
        .memstallM(memstallM),
        .memtoregE(memtoregE),
        .alusrcE(alusrcE),
        .regdstE(regdstE),
        .regwriteE(regwriteE),
        .jalE(jalE),
        .cp0toregE(cp0toregE),
        .cp0writeE(cp0writeE),
        .memwriteE(memwriteE),
        .alucontrolE(alucontrolE),
        .memtoregM(memtoregM),
        .memwriteM(memwriteM),
        .regwriteM(regwriteM),
        .jalM(jalM),
        .cp0toregM(cp0toregM),
        .cp0writeM(cp0writeM),
        .memtoregW(memtoregW),
        .regwriteW(regwriteW),
        .jalW(jalW),
        .cp0toregW(cp0toregW)
        );

    datapath dp(
        .clk(clk),
        .rst(rst),
        .pcF(pcF),
        .instrF(instrF),
        .pcsrcD(pcsrcD),
        .branchD(branchD),
        .jumpD(jumpD),
        .jrD(jrD),
        .jalD(jalD),
        .eretD(eretD),
        .cp0toregD(cp0toregD),
        .cp0writeD(cp0writeD),
        .immsrcD(immsrcD),
        .equalD(equalD),
        .opD(opD),
        .rsD(rsD),
        .functD(functD),
        .memtoregE(memtoregE),
        .alusrcE(alusrcE),
        .regdstE(regdstE),
        .regwriteE(regwriteE),
        .jalE(jalE),
        .cp0toregE(cp0toregE),
        .cp0writeE(cp0writeE),
        .memwriteE(memwriteE),
        .alucontrolE(alucontrolE),
        .flushE(flushE),
        .memtoregM(memtoregM),
        .regwriteM(regwriteM),
        .jalM(jalM),
        .cp0toregM(cp0toregM),
        .cp0writeM(cp0writeM),
        .memwriteM(memwriteM),
        .memstallM(memstallM),
        .aluoutM(aluoutM),
        .writedataM(writedataM),
        .wstrbM(wstrbM),
        .readdataM(readdataM),
        .memtoregW(memtoregW),
        .regwriteW(regwriteW),
        .jalW(jalW),
        .cp0toregW(cp0toregW),
        .irq_lines(irq_lines),
        .takeinterruptD(takeinterruptD)
        );
endmodule
