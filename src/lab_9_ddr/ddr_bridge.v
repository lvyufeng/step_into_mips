`timescale 1ns / 1ps

module ddr_bridge(
    input wire clk,
    input wire rst,

    // CPU-side blocking request. The CPU holds these signals stable while
    // cpu_valid is high and cpu_ready is low. One transaction is outstanding.
    input wire cpu_valid,
    input wire cpu_we,
    input wire[3:0] cpu_wstrb,
    input wire[31:0] cpu_addr,
    input wire[31:0] cpu_wdata,
    output wire cpu_ready,
    output wire[31:0] cpu_rdata,

    output wire calib_done,
    output wire busy,

    // Backend request/response interface. In simulation this connects to
    // ddr_model; in hardware it connects to mig_app_adapter.
    output reg backend_valid,
    output reg backend_we,
    output reg[3:0] backend_wstrb,
    output reg[26:0] backend_addr,
    output reg[31:0] backend_wdata,
    input wire backend_ready,
    input wire backend_resp_valid,
    input wire[31:0] backend_resp_rdata,
    input wire backend_calib_done,
    input wire backend_busy
    );

    localparam S_IDLE = 2'd0;
    localparam S_ISSUE = 2'd1;
    localparam S_WAIT = 2'd2;
    localparam S_DONE = 2'd3;

    reg[1:0] state;
    reg ready_r;
    reg[31:0] rdata_r;

    assign cpu_ready = ready_r;
    assign cpu_rdata = rdata_r;
    assign calib_done = backend_calib_done;
    assign busy = (state != S_IDLE) | backend_busy;

    always @(posedge clk) begin
        if (rst) begin
            state <= S_IDLE;
            ready_r <= 1'b0;
            rdata_r <= 32'b0;
            backend_valid <= 1'b0;
            backend_we <= 1'b0;
            backend_wstrb <= 4'b0;
            backend_addr <= 27'b0;
            backend_wdata <= 32'b0;
        end else begin
            ready_r <= 1'b0;

            case (state)
                S_IDLE: begin
                    backend_valid <= 1'b0;
                    if (cpu_valid & backend_calib_done) begin
                        backend_we <= cpu_we;
                        backend_wstrb <= cpu_wstrb;
                        backend_addr <= cpu_addr[26:0];
                        backend_wdata <= cpu_wdata;
                        backend_valid <= 1'b1;
                        state <= S_ISSUE;
                    end
                end

                S_ISSUE: begin
                    backend_valid <= 1'b1;
                    if (backend_ready) begin
                        backend_valid <= 1'b0;
                        state <= S_WAIT;
                    end
                end

                S_WAIT: begin
                    backend_valid <= 1'b0;
                    if (backend_resp_valid) begin
                        rdata_r <= backend_resp_rdata;
                        ready_r <= 1'b1;
                        state <= S_DONE;
                    end
                end

                S_DONE: begin
                    // ready_r was asserted for one full bus clock cycle. The CPU
                    // advances on the next CPU edge and may present another memory
                    // request afterwards.
                    state <= S_IDLE;
                end

                default: begin
                    state <= S_IDLE;
                    backend_valid <= 1'b0;
                end
            endcase
        end
    end
endmodule
