`timescale 1ns / 1ps

module ddr_model #(
    parameter ADDR_WIDTH = 12,
    parameter CALIB_CYCLES = 32,
    parameter READ_LATENCY = 7,
    parameter WRITE_LATENCY = 5
)(
    input wire clk,
    input wire rst,

    input wire req_valid,
    input wire req_we,
    input wire[3:0] req_wstrb,
    input wire[26:0] req_addr,
    input wire[31:0] req_wdata,
    output wire req_ready,

    output reg resp_valid,
    output reg[31:0] resp_rdata,
    output reg init_calib_complete,
    output wire busy
    );

    localparam S_IDLE = 2'd0;
    localparam S_WAIT = 2'd1;
    localparam S_RESP = 2'd2;

    reg[1:0] state;
    reg[15:0] calib_count;
    reg[15:0] latency_count;
    reg req_we_r;
    reg[ADDR_WIDTH-1:0] word_addr_r;
    reg[31:0] rdata_hold;

    reg[31:0] mem[0:(1 << ADDR_WIDTH)-1];

    assign req_ready = init_calib_complete & (state == S_IDLE);
    assign busy = (state != S_IDLE) | ~init_calib_complete;

    integer i;
    initial begin
        for (i = 0; i < (1 << ADDR_WIDTH); i = i + 1) begin
            mem[i] = 32'b0;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= S_IDLE;
            calib_count <= 16'b0;
            latency_count <= 16'b0;
            resp_valid <= 1'b0;
            resp_rdata <= 32'b0;
            rdata_hold <= 32'b0;
            req_we_r <= 1'b0;
            word_addr_r <= {ADDR_WIDTH{1'b0}};
            init_calib_complete <= 1'b0;
        end else begin
            resp_valid <= 1'b0;

            if (!init_calib_complete) begin
                if (calib_count == CALIB_CYCLES[15:0]) begin
                    init_calib_complete <= 1'b1;
                end else begin
                    calib_count <= calib_count + 1'b1;
                end
            end

            case (state)
                S_IDLE: begin
                    if (req_valid & req_ready) begin
                        req_we_r <= req_we;
                        word_addr_r <= req_addr[ADDR_WIDTH+1:2];
                        if (req_we) begin
                            if (req_wstrb[0]) mem[req_addr[ADDR_WIDTH+1:2]][7:0]   <= req_wdata[7:0];
                            if (req_wstrb[1]) mem[req_addr[ADDR_WIDTH+1:2]][15:8]  <= req_wdata[15:8];
                            if (req_wstrb[2]) mem[req_addr[ADDR_WIDTH+1:2]][23:16] <= req_wdata[23:16];
                            if (req_wstrb[3]) mem[req_addr[ADDR_WIDTH+1:2]][31:24] <= req_wdata[31:24];
                            latency_count <= WRITE_LATENCY[15:0];
                        end else begin
                            rdata_hold <= mem[req_addr[ADDR_WIDTH+1:2]];
                            latency_count <= READ_LATENCY[15:0];
                        end
                        state <= S_WAIT;
                    end
                end

                S_WAIT: begin
                    if (latency_count == 16'd0) begin
                        state <= S_RESP;
                    end else begin
                        latency_count <= latency_count - 1'b1;
                    end
                end

                S_RESP: begin
                    resp_valid <= 1'b1;
                    resp_rdata <= req_we_r ? 32'b0 : rdata_hold;
                    state <= S_IDLE;
                end

                default: begin
                    state <= S_IDLE;
                end
            endcase
        end
    end
endmodule
