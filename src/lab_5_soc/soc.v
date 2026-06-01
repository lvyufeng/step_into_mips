`timescale 1ns / 1ps

module soc(
    input wire clk,
    input wire rst,
    output wire[15:0] led,
    output wire[31:0] debug_writedata,
    output wire[31:0] debug_dataadr,
    output wire debug_memwrite
    );

    wire[31:0] pc;
    wire[31:0] instr;
    wire memwrite;
    wire[31:0] dataadr;
    wire[31:0] writedata;
    wire[31:0] readdata;

    mips mips(
        .clk(clk),
        .rst(rst),
        .pcF(pc),
        .instrF(instr),
        .memwriteM(memwrite),
        .aluoutM(dataadr),
        .writedataM(writedata),
        .readdataM(readdata)
        );

    simple_bus bus(
        .clk(~clk),
        .rst(rst),
        .i_addr(pc),
        .i_rdata(instr),
        .d_we(memwrite),
        .d_addr(dataadr),
        .d_wdata(writedata),
        .d_rdata(readdata),
        .led(led)
        );

    assign debug_writedata = writedata;
    assign debug_dataadr = dataadr;
    assign debug_memwrite = memwrite;
endmodule
