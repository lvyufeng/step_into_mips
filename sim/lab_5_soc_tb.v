`timescale 1ns / 1ps

module lab_5_soc_tb();
    reg clk;
    reg rst;

    wire[15:0] led;
    wire[31:0] debug_writedata;
    wire[31:0] debug_dataadr;
    wire debug_memwrite;

    integer gpio_writes;

    soc dut(
        .clk(clk),
        .rst(rst),
        .led(led),
        .debug_writedata(debug_writedata),
        .debug_dataadr(debug_dataadr),
        .debug_memwrite(debug_memwrite)
        );

    initial begin
        clk <= 1'b0;
        forever #5 clk <= ~clk;
    end

    initial begin
        gpio_writes <= 0;
        rst <= 1'b1;
        #100;
        rst <= 1'b0;
        #1000000;
        $display("Simulation Failed: timeout");
        $finish;
    end

    always @(negedge clk) begin
        if (!rst && debug_memwrite && debug_dataadr === 32'h0000_0000) begin
            gpio_writes <= gpio_writes + 1;
            if (debug_writedata === 32'h0000_0001) begin
                $display("Simulation succeeded");
                $finish;
            end else begin
                $display("Simulation Failed: first GPIO write was %h", debug_writedata);
                $finish;
            end
        end
    end
endmodule
