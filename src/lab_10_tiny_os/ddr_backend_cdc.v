`timescale 1ns / 1ps

module ddr_backend_cdc(
    input wire bus_clk,
    input wire bus_rst,

    input wire bus_valid,
    input wire bus_we,
    input wire[3:0] bus_wstrb,
    input wire[26:0] bus_addr,
    input wire[31:0] bus_wdata,
    output wire bus_ready,
    output reg bus_resp_valid,
    output reg[31:0] bus_resp_rdata,
    output wire bus_calib_done,
    output wire bus_busy,

    input wire axi_clk,
    input wire axi_rst,

    output reg axi_valid,
    output reg axi_we,
    output reg[3:0] axi_wstrb,
    output reg[26:0] axi_addr,
    output reg[31:0] axi_wdata,
    input wire axi_ready,
    input wire axi_resp_valid,
    input wire[31:0] axi_resp_rdata,
    input wire axi_calib_done,
    input wire axi_busy
    );

    reg bus_req_toggle;
    reg bus_inflight;
    reg bus_req_we;
    reg[3:0] bus_req_wstrb;
    reg[26:0] bus_req_addr;
    reg[31:0] bus_req_wdata;
    reg resp_toggle_bus_meta;
    reg resp_toggle_bus_sync;
    reg resp_toggle_bus_seen;
    reg[1:0] calib_done_bus_sync;
    reg[1:0] axi_busy_bus_sync;

    reg req_toggle_axi_meta;
    reg req_toggle_axi_sync;
    reg req_toggle_axi_seen;
    reg axi_request_active;
    reg axi_resp_toggle;
    reg[31:0] axi_resp_hold;

    assign bus_calib_done = calib_done_bus_sync[1];
    assign bus_ready = bus_calib_done & ~bus_inflight;
    assign bus_busy = ~bus_calib_done | bus_inflight | axi_busy_bus_sync[1];

    always @(posedge bus_clk) begin
        if (bus_rst) begin
            bus_req_toggle <= 1'b0;
            bus_inflight <= 1'b0;
            bus_req_we <= 1'b0;
            bus_req_wstrb <= 4'b0;
            bus_req_addr <= 27'b0;
            bus_req_wdata <= 32'b0;
            bus_resp_valid <= 1'b0;
            bus_resp_rdata <= 32'b0;
            resp_toggle_bus_meta <= 1'b0;
            resp_toggle_bus_sync <= 1'b0;
            resp_toggle_bus_seen <= 1'b0;
            calib_done_bus_sync <= 2'b0;
            axi_busy_bus_sync <= 2'b0;
        end else begin
            bus_resp_valid <= 1'b0;
            calib_done_bus_sync <= {calib_done_bus_sync[0], axi_calib_done};
            axi_busy_bus_sync <= {axi_busy_bus_sync[0], axi_busy};
            resp_toggle_bus_meta <= axi_resp_toggle;
            resp_toggle_bus_sync <= resp_toggle_bus_meta;

            if (bus_valid & bus_ready) begin
                bus_req_we <= bus_we;
                bus_req_wstrb <= bus_wstrb;
                bus_req_addr <= bus_addr;
                bus_req_wdata <= bus_wdata;
                bus_req_toggle <= ~bus_req_toggle;
                bus_inflight <= 1'b1;
            end

            if (bus_inflight && (resp_toggle_bus_sync != resp_toggle_bus_seen)) begin
                resp_toggle_bus_seen <= resp_toggle_bus_sync;
                bus_resp_rdata <= axi_resp_hold;
                bus_resp_valid <= 1'b1;
                bus_inflight <= 1'b0;
            end
        end
    end

    always @(posedge axi_clk) begin
        if (axi_rst) begin
            req_toggle_axi_meta <= 1'b0;
            req_toggle_axi_sync <= 1'b0;
            req_toggle_axi_seen <= 1'b0;
            axi_request_active <= 1'b0;
            axi_valid <= 1'b0;
            axi_we <= 1'b0;
            axi_wstrb <= 4'b0;
            axi_addr <= 27'b0;
            axi_wdata <= 32'b0;
            axi_resp_toggle <= 1'b0;
            axi_resp_hold <= 32'b0;
        end else begin
            req_toggle_axi_meta <= bus_req_toggle;
            req_toggle_axi_sync <= req_toggle_axi_meta;

            if (!axi_request_active && (req_toggle_axi_sync != req_toggle_axi_seen)) begin
                req_toggle_axi_seen <= req_toggle_axi_sync;
                axi_we <= bus_req_we;
                axi_wstrb <= bus_req_wstrb;
                axi_addr <= bus_req_addr;
                axi_wdata <= bus_req_wdata;
                axi_valid <= 1'b1;
                axi_request_active <= 1'b1;
            end else if (axi_valid & axi_ready) begin
                axi_valid <= 1'b0;
            end

            if (axi_request_active && axi_resp_valid) begin
                axi_resp_hold <= axi_resp_rdata;
                axi_resp_toggle <= ~axi_resp_toggle;
                axi_request_active <= 1'b0;
            end
        end
    end
endmodule
