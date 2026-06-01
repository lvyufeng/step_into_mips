`timescale 1ns / 1ps

module top(
    input wire clk100mhz,
    input wire rst,
    output wire[15:0] led
    );

    wire[31:0] debug_writedata;
    wire[31:0] debug_dataadr;
    wire debug_memwrite;

    soc soc(
        .clk(clk100mhz),
        .rst(rst),
        .led(led),
        .debug_writedata(debug_writedata),
        .debug_dataadr(debug_dataadr),
        .debug_memwrite(debug_memwrite)
        );
endmodule
