`timescale 1ns / 1ps

module top(
    input wire clk100mhz,
    input wire rst,
    input wire uart_rx_i,
    output wire uart_tx_o,
    output wire[15:0] led
    );

    // Hold the SoC in reset for a short time after FPGA configuration.  The
    // teaching CPU uses a mixture of synchronous and asynchronous reset
    // registers, so relying only on a human button press can leave pipeline
    // registers in an implementation-dependent state immediately after
    // programming.
    reg[19:0] por_count = 20'd0;
    reg por_rst = 1'b1;

    always @(posedge clk100mhz or posedge rst) begin
        if (rst) begin
            por_count <= 20'd0;
            por_rst <= 1'b1;
        end else if (por_count != 20'hfffff) begin
            por_count <= por_count + 1'b1;
            por_rst <= 1'b1;
        end else begin
            por_rst <= 1'b0;
        end
    end

    reg clk50mhz;
    wire clk50mhz_buf;
    reg[3:0] rst_sync;
    wire soc_rst;

    always @(posedge clk100mhz or posedge por_rst) begin
        if (por_rst) begin
            clk50mhz <= 1'b0;
        end else begin
            clk50mhz <= ~clk50mhz;
        end
    end

    BUFG clk_buf(
        .I(clk50mhz),
        .O(clk50mhz_buf)
        );

    always @(posedge clk50mhz_buf or posedge por_rst) begin
        if (por_rst) begin
            rst_sync <= 4'hf;
        end else begin
            rst_sync <= {rst_sync[2:0], 1'b0};
        end
    end

    assign soc_rst = rst_sync[3];

    wire[31:0] debug_writedata;
    wire[31:0] debug_dataadr;
    wire debug_memwrite;
    wire uart_tx_ready;
    wire uart_rx_valid;

    soc #(.UART_CLKS_PER_BIT(434)) soc(
        .clk(clk50mhz_buf),
        .rst(soc_rst),
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
