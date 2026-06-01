`timescale 1ns / 1ps

module simple_bus #(
    parameter UART_CLKS_PER_BIT = 868
)(
    input wire clk,
    input wire rst,

    input wire[31:0] i_addr,
    output wire[31:0] i_rdata,

    input wire d_we,
    input wire[31:0] d_addr,
    input wire[31:0] d_wdata,
    output wire[31:0] d_rdata,

    input wire uart_rx_i,
    output wire uart_tx_o,
    output wire[15:0] led,

    output wire uart_tx_ready,
    output wire uart_rx_valid
    );

    wire boot_sel_i = (i_addr[31:10] == 22'h000000);
    wire boot_sel_d = (d_addr[31:10] == 22'h000000) && (d_addr[15:12] != 4'h1);
    wire ram_sel_d  = (d_addr[31:16] == 16'h0001);
    wire gpio_sel_d = (d_addr[31:8] == 24'h100000) || (d_addr == 32'h00000000);
    wire uart_sel_d = (d_addr[31:8] == 24'h100010) ||
                      (d_addr[31:12] == 20'h00001);

    wire d_re = ~d_we;

    wire[31:0] boot_i_rdata;
    wire[31:0] boot_d_rdata;
    wire[31:0] ram_rdata;
    wire[31:0] gpio_rdata;
    wire[31:0] uart_rdata;

    boot_rom iboot(
        .clk(clk),
        .a(i_addr[9:2]),
        .spo(boot_i_rdata)
        );

    boot_rom dboot(
        .clk(clk),
        .a(d_addr[9:2]),
        .spo(boot_d_rdata)
        );

    bram_ram #(.ADDR_WIDTH(10)) ram(
        .clk(clk),
        .we(d_we & ram_sel_d),
        .word_addr(d_addr[11:2]),
        .wdata(d_wdata),
        .rdata(ram_rdata)
        );

    gpio_mmio gpio(
        .clk(clk),
        .rst(rst),
        .we(d_we & gpio_sel_d),
        .wdata(d_wdata),
        .rdata(gpio_rdata),
        .led(led)
        );

    uart_mmio #(.CLKS_PER_BIT(UART_CLKS_PER_BIT)) uart(
        .clk(clk),
        .rst(rst),
        .we(d_we & uart_sel_d),
        .re(d_re & uart_sel_d),
        .addr(d_addr[3:0]),
        .wdata(d_wdata),
        .rdata(uart_rdata),
        .uart_rx_i(uart_rx_i),
        .uart_tx_o(uart_tx_o),
        .tx_ready(uart_tx_ready),
        .rx_valid(uart_rx_valid)
        );

    assign i_rdata = boot_sel_i ? boot_i_rdata : 32'b0;
    assign d_rdata = boot_sel_d ? boot_d_rdata :
                     ram_sel_d  ? ram_rdata :
                     gpio_sel_d ? gpio_rdata :
                     uart_sel_d ? uart_rdata : 32'b0;
endmodule
