`timescale 1ns / 1ps

module uart_mmio #(
    parameter CLKS_PER_BIT = 868
)(
    input wire clk,
    input wire rst,
    input wire we,
    input wire re,
    input wire[3:0] addr,
    input wire[31:0] wdata,
    output reg[31:0] rdata,
    input wire uart_rx_i,
    output wire uart_tx_o,
    output wire tx_ready,
    output wire rx_valid
    );

    wire tx_busy;
    reg tx_start;
    reg[7:0] tx_data;

    wire[7:0] rx_data_wire;
    wire rx_valid_wire;
    reg[7:0] rx_data_reg;
    reg rx_valid_reg;

    uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) tx(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(uart_tx_o),
        .tx_busy(tx_busy)
        );

    uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) rx(
        .clk(clk),
        .rst(rst),
        .rx(uart_rx_i),
        .rx_data(rx_data_wire),
        .rx_valid(rx_valid_wire)
        );

    assign tx_ready = ~tx_busy;
    assign rx_valid = rx_valid_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_start <= 1'b0;
            tx_data <= 8'b0;
            rx_data_reg <= 8'b0;
            rx_valid_reg <= 1'b0;
        end else begin
            tx_start <= 1'b0;

            if (rx_valid_wire) begin
                rx_data_reg <= rx_data_wire;
                rx_valid_reg <= 1'b1;
            end

            if (we && addr[3:2] == 2'b00 && ~tx_busy) begin
                tx_data <= wdata[7:0];
                tx_start <= 1'b1;
            end

            if (re && addr[3:2] == 2'b01) begin
                rx_valid_reg <= 1'b0;
            end
        end
    end

    always @(*) begin
        case (addr[3:2])
            2'b00: rdata = {24'b0, tx_data};
            2'b01: rdata = {24'b0, rx_data_reg};
            2'b10: rdata = {30'b0, rx_valid_reg, ~tx_busy};
            default: rdata = 32'b0;
        endcase
    end
endmodule
