`timescale 1ns / 1ps

module lab_7_c_runtime_tb();
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

    integer cycle_count;
    reg[7:0] rx_byte;
    reg[7:0] echo_byte;

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
        cycle_count <= 0;
        #100;
        rst <= 1'b0;
    end

    always @(posedge clk) begin
        if (!rst) begin
            cycle_count <= cycle_count + 1;
            if (cycle_count > 1000000) begin
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

    task uart_send_byte;
        input [7:0] data;
        begin
            uart_rx_i = 1'b1;
            #BIT_NS;
            uart_rx_i = 1'b0; // start
            #BIT_NS;
            uart_rx_i = data[0]; #BIT_NS;
            uart_rx_i = data[1]; #BIT_NS;
            uart_rx_i = data[2]; #BIT_NS;
            uart_rx_i = data[3]; #BIT_NS;
            uart_rx_i = data[4]; #BIT_NS;
            uart_rx_i = data[5]; #BIT_NS;
            uart_rx_i = data[6]; #BIT_NS;
            uart_rx_i = data[7]; #BIT_NS;
            uart_rx_i = 1'b1; // stop
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

    task expect_lab7_banner;
        begin
            expect_byte("s"); expect_byte("t"); expect_byte("e"); expect_byte("p");
            expect_byte("_"); expect_byte("i"); expect_byte("n"); expect_byte("t");
            expect_byte("o"); expect_byte("_"); expect_byte("m"); expect_byte("i");
            expect_byte("p"); expect_byte("s"); expect_byte(" "); expect_byte("l");
            expect_byte("a"); expect_byte("b"); expect_byte("7"); expect_byte(" ");
            expect_byte("c"); expect_byte("-"); expect_byte("r"); expect_byte("u");
            expect_byte("n"); expect_byte("t"); expect_byte("i"); expect_byte("m");
            expect_byte("e"); expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    task expect_isa_pass;
        begin
            expect_byte("I"); expect_byte("S"); expect_byte("A"); expect_byte(" ");
            expect_byte("P"); expect_byte("A"); expect_byte("S"); expect_byte("S");
            expect_byte(8'h0d); expect_byte(8'h0a);
        end
    endtask

    task expect_prompt;
        begin
            expect_byte(">"); expect_byte(" ");
        end
    endtask

    initial begin
        wait (rst == 1'b0);
        expect_lab7_banner();
        expect_isa_pass();
        expect_prompt();

        uart_send_byte("A");
        uart_recv_byte(echo_byte);
        if (echo_byte !== "A") begin
            $display("Simulation Failed: echo expected A, got %h", echo_byte);
            $finish;
        end

        uart_send_byte("z");
        uart_recv_byte(echo_byte);
        if (echo_byte !== "z") begin
            $display("Simulation Failed: echo expected z, got %h", echo_byte);
            $finish;
        end

        $display("Simulation succeeded: lab_7 ISA PASS and UART echo verified");
        $finish;
    end
endmodule
