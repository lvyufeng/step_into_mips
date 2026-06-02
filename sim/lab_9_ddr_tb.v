`timescale 1ns / 1ps

module lab_9_ddr_tb();
    reg clk;
    reg rst;
    reg uart_rx_i;

    wire uart_tx_o;
    wire[15:0] led;
    wire bus_clk;
    wire[31:0] debug_writedata;
    wire[31:0] debug_dataadr;
    wire debug_memwrite;
    wire uart_tx_ready;
    wire uart_rx_valid;

    wire ddr_backend_valid;
    wire ddr_backend_we;
    wire[3:0] ddr_backend_wstrb;
    wire[26:0] ddr_backend_addr;
    wire[31:0] ddr_backend_wdata;
    wire ddr_backend_ready;
    wire ddr_backend_resp_valid;
    wire[31:0] ddr_backend_resp_rdata;
    wire ddr_backend_calib_done;
    wire ddr_backend_busy;

    localparam integer CLKS_PER_BIT = 16;
    localparam integer BIT_NS = CLKS_PER_BIT * 10;
    localparam integer TIMER_TICK_CYCLES = 5000;

    assign bus_clk = ~clk;

    integer cycle_count;
    reg[7:0] rx_byte;

    soc #(
        .UART_CLKS_PER_BIT(CLKS_PER_BIT),
        .TIMER_TICK_CYCLES(TIMER_TICK_CYCLES)
    ) dut(
        .clk(clk),
        .bus_clk(bus_clk),
        .rst(rst),
        .uart_rx_i(uart_rx_i),
        .uart_tx_o(uart_tx_o),
        .led(led),
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
        .debug_writedata(debug_writedata),
        .debug_dataadr(debug_dataadr),
        .debug_memwrite(debug_memwrite),
        .uart_tx_ready(uart_tx_ready),
        .uart_rx_valid(uart_rx_valid)
        );

    ddr_model #(
        .ADDR_WIDTH(12),
        .CALIB_CYCLES(32),
        .READ_LATENCY(7),
        .WRITE_LATENCY(5)
    ) ddr_backend(
        .clk(~clk),
        .rst(rst),
        .req_valid(ddr_backend_valid),
        .req_we(ddr_backend_we),
        .req_wstrb(ddr_backend_wstrb),
        .req_addr(ddr_backend_addr),
        .req_wdata(ddr_backend_wdata),
        .req_ready(ddr_backend_ready),
        .resp_valid(ddr_backend_resp_valid),
        .resp_rdata(ddr_backend_resp_rdata),
        .init_calib_complete(ddr_backend_calib_done),
        .busy(ddr_backend_busy)
        );

    initial begin
        clk <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        rst <= 1'b1;
        uart_rx_i <= 1'b1;
        cycle_count <= 0;
        #100;
        rst <= 1'b0;
    end

    always @(posedge clk) begin
        if (!rst) begin
            cycle_count <= cycle_count + 1;
            if (cycle_count > 3000000) begin
                $display("Simulation Failed: timeout");
                $finish;
            end
        end
    end

    task uart_recv_byte;
        output [7:0] data;
        begin
            wait (uart_tx_o == 1'b0);
            #(BIT_NS + BIT_NS/2);
            data[0] = uart_tx_o;
            #BIT_NS; data[1] = uart_tx_o;
            #BIT_NS; data[2] = uart_tx_o;
            #BIT_NS; data[3] = uart_tx_o;
            #BIT_NS; data[4] = uart_tx_o;
            #BIT_NS; data[5] = uart_tx_o;
            #BIT_NS; data[6] = uart_tx_o;
            #BIT_NS; data[7] = uart_tx_o;
            #BIT_NS;
        end
    endtask

    task expect_byte;
        input [7:0] expected;
        begin
            uart_recv_byte(rx_byte);
            if (rx_byte !== expected) begin
                $display("\nSimulation Failed: expected byte %h (%c), got %h (%c)", expected, expected, rx_byte, rx_byte);
                $finish;
            end
        end
    endtask

    task expect_lab9_banner;
        begin
            expect_byte("s"); expect_byte("t"); expect_byte("e"); expect_byte("p");
            expect_byte("_"); expect_byte("i"); expect_byte("n"); expect_byte("t");
            expect_byte("o"); expect_byte("_"); expect_byte("m"); expect_byte("i");
            expect_byte("p"); expect_byte("s"); expect_byte(" "); expect_byte("l");
            expect_byte("a"); expect_byte("b"); expect_byte("9"); expect_byte(" ");
            expect_byte("d"); expect_byte("d"); expect_byte("r");
            expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    task expect_ddr_cal_ok;
        begin
            expect_byte("D"); expect_byte("D"); expect_byte("R"); expect_byte(" ");
            expect_byte("C"); expect_byte("A"); expect_byte("L"); expect_byte(" ");
            expect_byte("O"); expect_byte("K"); expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    task expect_ddr_pass;
        begin
            expect_byte("D"); expect_byte("D"); expect_byte("R"); expect_byte(" ");
            expect_byte("P"); expect_byte("A"); expect_byte("S"); expect_byte("S");
            expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    initial begin
        wait (rst == 1'b0);
        expect_lab9_banner();
        expect_ddr_cal_ok();
        expect_ddr_pass();

        if (led !== 16'h005a) begin
            $display("Simulation Failed: LED expected 0x005a after DDR PASS, got %h", led);
            $finish;
        end

        $display("Simulation succeeded: lab_9 DDR calibration and pattern test verified");
        $finish;
    end
endmodule
