`timescale 1ns / 1ps

module lab_6_uart_boot_tb();
    reg clk;
    reg rst;
    reg uart_rx_i;

    wire uart_tx_o;
    wire[15:0] led;
    wire[31:0] debug_writedata;
    wire[31:0] debug_dataadr;
    wire debug_memwrite;
    wire uart_tx_ready;
    wire uart_rx_valid;

    localparam integer CLKS_PER_BIT = 16;
    localparam integer BIT_NS = CLKS_PER_BIT * 10;

    integer out_idx;
    integer cycle_count;
    reg[8*64-1:0] received;
    reg[7:0] rx_byte;

    soc #(.UART_CLKS_PER_BIT(CLKS_PER_BIT)) dut(
        .clk(clk),
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

    initial begin
        clk <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        rst <= 1'b1;
        uart_rx_i <= 1'b1;
        out_idx <= 0;
        received <= {64{8'h00}};
        cycle_count <= 0;
        #100;
        rst <= 1'b0;
    end

    always @(posedge clk) begin
        if (!rst) begin
            cycle_count <= cycle_count + 1;
            if (cycle_count > 200000) begin
                $display("Simulation Failed: timeout");
                $finish;
            end
        end
    end

    always begin
        wait (rst == 1'b0);
        wait (uart_tx_o == 1'b0);
        #(BIT_NS + BIT_NS/2);
        rx_byte[0] = uart_tx_o;
        #BIT_NS; rx_byte[1] = uart_tx_o;
        #BIT_NS; rx_byte[2] = uart_tx_o;
        #BIT_NS; rx_byte[3] = uart_tx_o;
        #BIT_NS; rx_byte[4] = uart_tx_o;
        #BIT_NS; rx_byte[5] = uart_tx_o;
        #BIT_NS; rx_byte[6] = uart_tx_o;
        #BIT_NS; rx_byte[7] = uart_tx_o;
        #BIT_NS;

        received[out_idx*8 +: 8] = rx_byte;
        out_idx = out_idx + 1;

        if (out_idx == 31) begin
            if (received[0*8 +: 8]  == "s" &&
                received[1*8 +: 8]  == "t" &&
                received[2*8 +: 8]  == "e" &&
                received[3*8 +: 8]  == "p" &&
                received[4*8 +: 8]  == "_" &&
                received[5*8 +: 8]  == "i" &&
                received[6*8 +: 8]  == "n" &&
                received[7*8 +: 8]  == "t" &&
                received[8*8 +: 8]  == "o" &&
                received[9*8 +: 8]  == "_" &&
                received[10*8 +: 8] == "m" &&
                received[11*8 +: 8] == "i" &&
                received[12*8 +: 8] == "p" &&
                received[13*8 +: 8] == "s" &&
                received[14*8 +: 8] == " " &&
                received[15*8 +: 8] == "b" &&
                received[16*8 +: 8] == "o" &&
                received[17*8 +: 8] == "o" &&
                received[18*8 +: 8] == "t" &&
                received[19*8 +: 8] == " " &&
                received[20*8 +: 8] == "m" &&
                received[21*8 +: 8] == "o" &&
                received[22*8 +: 8] == "n" &&
                received[23*8 +: 8] == "i" &&
                received[24*8 +: 8] == "t" &&
                received[25*8 +: 8] == "o" &&
                received[26*8 +: 8] == "r" &&
                received[27*8 +: 8] == 8'h0d &&
                received[28*8 +: 8] == 8'h0a &&
                received[29*8 +: 8] == ">" &&
                received[30*8 +: 8] == " ") begin
                $display("Simulation succeeded: lab_6 UART banner received");
                $finish;
            end else begin
                $display("Simulation Failed: wrong UART banner");
                $display("received[0]=%h received[1]=%h", received[0*8 +: 8], received[1*8 +: 8]);
                $finish;
            end
        end
    end
endmodule
