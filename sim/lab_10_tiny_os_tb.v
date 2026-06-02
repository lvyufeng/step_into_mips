`timescale 1ns / 1ps

module lab_10_tiny_os_tb();
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
    localparam integer TIMER_TICK_CYCLES = 50000;

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
            if (cycle_count > 4000000) begin
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
            #(BIT_NS * 8);
            uart_rx_i = 1'b0;
            #BIT_NS;
            uart_rx_i = data[0]; #BIT_NS;
            uart_rx_i = data[1]; #BIT_NS;
            uart_rx_i = data[2]; #BIT_NS;
            uart_rx_i = data[3]; #BIT_NS;
            uart_rx_i = data[4]; #BIT_NS;
            uart_rx_i = data[5]; #BIT_NS;
            uart_rx_i = data[6]; #BIT_NS;
            uart_rx_i = data[7]; #BIT_NS;
            uart_rx_i = 1'b1;
            #(BIT_NS * 2);
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

    task expect_string;
        input [8*80-1:0] text;
        integer i;
        integer len;
        reg[7:0] ch;
        begin
            len = 0;
            for (i = 79; i >= 0; i = i - 1) begin
                ch = text[i*8 +: 8];
                if (ch != 8'h00) begin
                    len = i + 1;
                    i = -1;
                end
            end
            for (i = len - 1; i >= 0; i = i - 1) begin
                expect_byte(text[i*8 +: 8]);
            end
        end
    endtask

    task send_string;
        input [8*32-1:0] text;
        integer i;
        integer len;
        reg[7:0] ch;
        begin
            len = 0;
            for (i = 31; i >= 0; i = i - 1) begin
                ch = text[i*8 +: 8];
                if (ch != 8'h00) begin
                    len = i + 1;
                    i = -1;
                end
            end
            for (i = len - 1; i >= 0; i = i - 1) begin
                uart_send_byte(text[i*8 +: 8]);
                #(BIT_NS * 300);
            end
        end
    endtask

    task expect_crlf;
        begin
            expect_byte(8'h0d);
            expect_byte(8'h0a);
        end
    endtask

    task expect_line;
        input [8*80-1:0] text;
        begin
            expect_string(text);
            expect_crlf();
        end
    endtask

    task send_line;
        input [8*32-1:0] text;
        begin
            send_string(text);
            uart_send_byte(8'h0d);
        end
    endtask

    initial begin
        wait (rst == 1'b0);
        expect_line("step_into_mips lab10 tiny os");
        expect_line("DDR CAL OK");
        expect_line("DDR TEST OK");
        expect_line("OS INIT OK");
        expect_line("SCHED READY");
        expect_string("step-os> ");

        send_line("help");
        expect_line("help ps mem led run");
        expect_string("step-os> ");

        send_line("ps");
        expect_line("task0 shell");
        expect_line("task1 demo");
        expect_string("step-os> ");

        send_line("mem");
        expect_line("DDR CAL OK");
        expect_line("DDR TEST OK");
        expect_string("step-os> ");

        send_line("led 1");
        expect_line("OK");
        expect_string("step-os> ");

        if (led[0] !== 1'b1) begin
            $display("Simulation Failed: led[0] expected 1 after led command, got %h", led);
            $finish;
        end

        send_line("run demo");
        expect_line("demo started");
        expect_string("step-os> ");

        repeat (TIMER_TICK_CYCLES * 4) @(posedge clk);
        if (dut.bus.ram.ram[131] == 32'b0) begin
            $display("Simulation Failed: demo task run count did not advance");
            $finish;
        end

        $display("Simulation succeeded: lab_10 StepOS shell and scheduler verified");
        $finish;
    end
endmodule
