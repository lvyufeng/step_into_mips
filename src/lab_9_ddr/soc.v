`timescale 1ns / 1ps

module soc #(
    parameter UART_CLKS_PER_BIT = 868,
    parameter TIMER_TICK_CYCLES = 32'd50000000
)(
    input wire clk,
    input wire bus_clk,
    input wire rst,
    input wire uart_rx_i,
    output wire uart_tx_o,
    output wire[15:0] led,

    output wire ddr_backend_valid,
    output wire ddr_backend_we,
    output wire[3:0] ddr_backend_wstrb,
    output wire[26:0] ddr_backend_addr,
    output wire[31:0] ddr_backend_wdata,
    input wire ddr_backend_ready,
    input wire ddr_backend_resp_valid,
    input wire[31:0] ddr_backend_resp_rdata,
    input wire ddr_backend_calib_done,
    input wire ddr_backend_busy,

    output wire[31:0] debug_writedata,
    output wire[31:0] debug_dataadr,
    output wire debug_memwrite,
    output wire uart_tx_ready,
    output wire uart_rx_valid
    );

    wire[31:0] pc;
    wire[31:0] instr;
    wire memvalid;
    wire memready;
    wire memwrite;
    wire[3:0] wstrb;
    wire[31:0] dataadr;
    wire[31:0] writedata;
    wire[31:0] readdata;
    wire[7:0] irq_lines;

    mips mips(
        .clk(clk),
        .rst(rst),
        .pcF(pc),
        .instrF(instr),
        .d_validM(memvalid),
        .d_readyM(memready),
        .memwriteM(memwrite),
        .wstrbM(wstrb),
        .aluoutM(dataadr),
        .writedataM(writedata),
        .readdataM(readdata),
        .irq_lines(irq_lines)
        );

    simple_bus #(
        .UART_CLKS_PER_BIT(UART_CLKS_PER_BIT),
        .TIMER_TICK_CYCLES(TIMER_TICK_CYCLES)
    ) bus(
        .clk(bus_clk),
        .rst(rst),
        .i_addr(pc),
        .i_rdata(instr),
        .d_valid(memvalid),
        .d_ready(memready),
        .d_we(memwrite),
        .d_wstrb(wstrb),
        .d_addr(dataadr),
        .d_wdata(writedata),
        .d_rdata(readdata),
        .ddr_backend_valid(ddr_backend_valid),
        .ddr_backend_we(ddr_backend_we),
        .ddr_backend_wstrb(ddr_backend_wstrb),
        .ddr_backend_addr(ddr_backend_addr),
        .ddr_backend_wdata(ddr_backend_wdata),
        .ddr_backend_ready(ddr_backend_ready),
        .ddr_backend_resp_valid(ddr_backend_resp_valid),
        .ddr_backend_resp_rdata(ddr_backend_resp_rdata),
        .ddr_backend_calib_done(ddr_backend_calib_done),
        .ddr_backend_busy(ddr_backend_busy),
        .uart_rx_i(uart_rx_i),
        .uart_tx_o(uart_tx_o),
        .led(led),
        .uart_tx_ready(uart_tx_ready),
        .uart_rx_valid(uart_rx_valid),
        .irq_lines(irq_lines)
        );

    assign debug_writedata = writedata;
    assign debug_dataadr = dataadr;
    assign debug_memwrite = memwrite;
endmodule
