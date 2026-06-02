`timescale 1ns / 1ps

module lab_8_interrupt_tb();
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
    localparam integer TIMER_TICK_CYCLES = 5000;

    integer cycle_count;
    reg[7:0] rx_byte;

    soc #(
        .UART_CLKS_PER_BIT(CLKS_PER_BIT),
        .TIMER_TICK_CYCLES(TIMER_TICK_CYCLES)
    ) dut(
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
        cycle_count <= 0;
        #100;
        rst <= 1'b0;
    end

    always @(posedge clk) begin
        if (!rst) begin
            cycle_count <= cycle_count + 1;
            if (cycle_count > 2000000) begin
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

    task expect_lab8_banner;
        begin
            expect_byte("s"); expect_byte("t"); expect_byte("e"); expect_byte("p");
            expect_byte("_"); expect_byte("i"); expect_byte("n"); expect_byte("t");
            expect_byte("o"); expect_byte("_"); expect_byte("m"); expect_byte("i");
            expect_byte("p"); expect_byte("s"); expect_byte(" "); expect_byte("l");
            expect_byte("a"); expect_byte("b"); expect_byte("8"); expect_byte(" ");
            expect_byte("i"); expect_byte("n"); expect_byte("t"); expect_byte("e");
            expect_byte("r"); expect_byte("r"); expect_byte("u"); expect_byte("p");
            expect_byte("t"); expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    task expect_irq_ready;
        begin
            expect_byte("I"); expect_byte("R"); expect_byte("Q"); expect_byte(" ");
            expect_byte("R"); expect_byte("E"); expect_byte("A"); expect_byte("D");
            expect_byte("Y"); expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    task expect_tick;
        begin
            expect_byte("t"); expect_byte("i"); expect_byte("c"); expect_byte("k");
            expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    initial begin
        wait (rst == 1'b0);
        expect_lab8_banner();
        expect_irq_ready();

        expect_tick();
        if (led == 16'd0) begin
            $display("Simulation Failed: LED did not increment after first tick");
            $finish;
        end

        expect_tick();
        if (led < 16'd2) begin
            $display("Simulation Failed: LED expected at least 2 after second tick, got %h", led);
            $finish;
        end

        $display("Simulation succeeded: lab_8 timer interrupt ticks verified");
        $finish;
    end
endmodule
