`timescale 1ns / 1ps

module soc #(
    parameter UART_CLKS_PER_BIT = 868
)(
    input wire clk,
    input wire rst,
    input wire uart_rx_i,
    output wire uart_tx_o,
    output wire[15:0] led,
    output wire[31:0] debug_writedata,
    output wire[31:0] debug_dataadr,
    output wire debug_memwrite,
    output wire uart_tx_ready,
    output wire uart_rx_valid
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

    simple_bus #(.UART_CLKS_PER_BIT(UART_CLKS_PER_BIT)) bus(
        .clk(~clk),
        .rst(rst),
        .i_addr(pc),
        .i_rdata(instr),
        .d_we(memwrite),
        .d_addr(dataadr),
        .d_wdata(writedata),
        .d_rdata(readdata),
        .uart_rx_i(uart_rx_i),
        .uart_tx_o(uart_tx_o),
        .led(led),
        .uart_tx_ready(uart_tx_ready),
        .uart_rx_valid(uart_rx_valid)
        );

    assign debug_writedata = writedata;
    assign debug_dataadr = dataadr;
    assign debug_memwrite = memwrite;
endmodule
