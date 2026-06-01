`timescale 1ns / 1ps

module top(
    input wire clk100mhz,
    input wire rst,
    input wire uart_rx_i,
    output wire uart_tx_o,
    output wire[15:0] led
    );

    reg clk50mhz;
    wire clk50mhz_buf;
    wire[31:0] debug_writedata;
    wire[31:0] debug_dataadr;
    wire debug_memwrite;
    wire uart_tx_ready;
    wire uart_rx_valid;

    always @(posedge clk100mhz or posedge rst) begin
        if (rst) begin
            clk50mhz <= 1'b0;
        end else begin
            clk50mhz <= ~clk50mhz;
        end
    end

    BUFG clk_buf(
        .I(clk50mhz),
        .O(clk50mhz_buf)
        );

    soc #(.UART_CLKS_PER_BIT(434)) soc(
        .clk(clk50mhz_buf),
        .rst(rst),
        .uart_rx_i(uart_rx_i),
        .uart_tx_o(uart_tx_o),
        .led(led),
        .debug_writedata(debug_writedata),
        .debug_dataadr(debug_dataadr),
        .debug_memwrite(debug_memwrite),
        .uart_tx_ready(uart_tx_ready),
        .uart_rx_valid(uart_rx_valid)
        );
endmodule
