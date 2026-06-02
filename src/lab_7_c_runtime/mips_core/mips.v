`timescale 1ns / 1ps

module mips(
    input wire clk,
    input wire rst,
    output wire[31:0] pcF,
    input wire[31:0] instrF,
    output wire memwriteM,
    output wire[3:0] wstrbM,
    output wire[31:0] aluoutM,
    output wire[31:0] writedataM,
    input wire[31:0] readdataM
    );

    wire[5:0] opD, functD;
    wire pcsrcD, branchD, jumpD, jrD, jalD;
    wire[1:0] immsrcD;
    wire memtoregE, alusrcE, regwriteE, jalE, memwriteE;
    wire memtoregM, regwriteM, jalM;
    wire memtoregW, regwriteW, jalW;
    wire[1:0] regdstE;
    wire[3:0] alucontrolE;
    wire flushE, equalD;

    controller c(
        .clk(clk),
        .rst(rst),
        .opD(opD),
        .functD(functD),
        .equalD(equalD),
        .pcsrcD(pcsrcD),
        .branchD(branchD),
        .jumpD(jumpD),
        .jrD(jrD),
        .jalD(jalD),
        .immsrcD(immsrcD),
        .flushE(flushE),
        .memtoregE(memtoregE),
        .alusrcE(alusrcE),
        .regdstE(regdstE),
        .regwriteE(regwriteE),
        .jalE(jalE),
        .memwriteE(memwriteE),
        .alucontrolE(alucontrolE),
        .memtoregM(memtoregM),
        .memwriteM(memwriteM),
        .regwriteM(regwriteM),
        .jalM(jalM),
        .memtoregW(memtoregW),
        .regwriteW(regwriteW),
        .jalW(jalW)
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
        .immsrcD(immsrcD),
        .equalD(equalD),
        .opD(opD),
        .functD(functD),
        .memtoregE(memtoregE),
        .alusrcE(alusrcE),
        .regdstE(regdstE),
        .regwriteE(regwriteE),
        .jalE(jalE),
        .memwriteE(memwriteE),
        .alucontrolE(alucontrolE),
        .flushE(flushE),
        .memtoregM(memtoregM),
        .regwriteM(regwriteM),
        .jalM(jalM),
        .memwriteM(memwriteM),
        .aluoutM(aluoutM),
        .writedataM(writedataM),
        .wstrbM(wstrbM),
        .readdataM(readdataM),
        .memtoregW(memtoregW),
        .regwriteW(regwriteW),
        .jalW(jalW)
        );
endmodule
