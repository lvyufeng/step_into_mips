`timescale 1ns / 1ps

module timer_mmio #(
    parameter DEFAULT_COMPARE = 32'd50000000
)(
    input wire clk,
    input wire rst,
    input wire we,
    input wire re,
    input wire[3:0] wstrb,
    input wire[3:0] addr,
    input wire[31:0] wdata,
    output reg[31:0] rdata,
    output wire irq
    );

    reg[31:0] counter;
    reg[31:0] compare;
    reg[31:0] control;
    reg pending;

    wire enable = control[0];
    wire irq_enable = control[1];
    wire auto_reload = control[2];

    assign irq = pending & irq_enable;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 32'b0;
            compare <= DEFAULT_COMPARE;
            control <= 32'b0;
            pending <= 1'b0;
        end else begin
            if (enable) begin
                if (counter >= compare) begin
                    pending <= 1'b1;
                    if (auto_reload) begin
                        counter <= 32'b0;
                    end else begin
                        counter <= counter;
                    end
                end else begin
                    counter <= counter + 32'd1;
                end
            end

            if (we && |wstrb) begin
                case (addr[3:2])
                    2'b00: counter <= wdata;
                    2'b01: begin
                        compare <= wdata;
                        if (counter >= wdata) begin
                            counter <= 32'b0;
                        end
                    end
                    2'b10: control <= wdata;
                    2'b11: begin
                        // write 1 to bit 0 to clear pending
                        if (wdata[0]) begin
                            pending <= 1'b0;
                        end
                    end
                    default: ;
                endcase
            end
        end
    end

    always @(*) begin
        case (addr[3:2])
            2'b00: rdata = counter;
            2'b01: rdata = compare;
            2'b10: rdata = control;
            2'b11: rdata = {31'b0, pending};
            default: rdata = 32'b0;
        endcase
    end
endmodule
