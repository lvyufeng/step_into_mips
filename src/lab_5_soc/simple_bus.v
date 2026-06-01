`timescale 1ns / 1ps

module simple_bus(
    input wire clk,
    input wire rst,

    input wire[31:0] i_addr,
    output wire[31:0] i_rdata,

    input wire d_we,
    input wire[31:0] d_addr,
    input wire[31:0] d_wdata,
    output wire[31:0] d_rdata,

    output wire[15:0] led
    );

    wire boot_sel_i = (i_addr[31:8] == 24'h000000);
    wire boot_sel_d = (d_addr[31:8] == 24'h000000);
    wire ram_sel_d  = (d_addr[31:16] == 16'h0001);
    wire gpio_sel_d = (d_addr[31:8] == 24'h100000) || (d_addr == 32'h00000000);

    wire[31:0] boot_i_rdata;
    wire[31:0] boot_d_rdata;
    wire[31:0] ram_rdata;
    wire[31:0] gpio_rdata;

    boot_rom iboot(
        .clk(clk),
        .a(i_addr[7:2]),
        .spo(boot_i_rdata)
        );

    boot_rom dboot(
        .clk(clk),
        .a(d_addr[7:2]),
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

    assign i_rdata = boot_sel_i ? boot_i_rdata : 32'b0;
    assign d_rdata = boot_sel_d ? boot_d_rdata :
                     ram_sel_d  ? ram_rdata :
                     gpio_sel_d ? gpio_rdata : 32'b0;
endmodule
