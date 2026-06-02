`timescale 1ns / 1ps

module mig_axi_adapter(
    input wire clk,
    input wire rst,

    input wire backend_valid,
    input wire backend_we,
    input wire[3:0] backend_wstrb,
    input wire[26:0] backend_addr,
    input wire[31:0] backend_wdata,
    output wire backend_ready,
    output reg backend_resp_valid,
    output reg[31:0] backend_resp_rdata,
    input wire init_calib_complete,
    output wire busy,

    output wire[0:0] s_axi_awid,
    output reg[26:0] s_axi_awaddr,
    output wire[7:0] s_axi_awlen,
    output wire[2:0] s_axi_awsize,
    output wire[1:0] s_axi_awburst,
    output wire[0:0] s_axi_awlock,
    output wire[3:0] s_axi_awcache,
    output wire[2:0] s_axi_awprot,
    output wire[3:0] s_axi_awqos,
    output reg s_axi_awvalid,
    input wire s_axi_awready,

    output reg[63:0] s_axi_wdata,
    output reg[7:0] s_axi_wstrb,
    output wire s_axi_wlast,
    output reg s_axi_wvalid,
    input wire s_axi_wready,

    input wire[0:0] s_axi_bid,
    input wire[1:0] s_axi_bresp,
    input wire s_axi_bvalid,
    output reg s_axi_bready,

    output wire[0:0] s_axi_arid,
    output reg[26:0] s_axi_araddr,
    output wire[7:0] s_axi_arlen,
    output wire[2:0] s_axi_arsize,
    output wire[1:0] s_axi_arburst,
    output wire[0:0] s_axi_arlock,
    output wire[3:0] s_axi_arcache,
    output wire[2:0] s_axi_arprot,
    output wire[3:0] s_axi_arqos,
    output reg s_axi_arvalid,
    input wire s_axi_arready,

    input wire[0:0] s_axi_rid,
    input wire[63:0] s_axi_rdata,
    input wire[1:0] s_axi_rresp,
    input wire s_axi_rlast,
    input wire s_axi_rvalid,
    output reg s_axi_rready
    );

    localparam S_IDLE = 2'd0;
    localparam S_WRITE = 2'd1;
    localparam S_READ = 2'd2;
    localparam S_RESP = 2'd3;

    reg[1:0] state;
    reg read_high_word;

    assign backend_ready = init_calib_complete & (state == S_IDLE);
    assign busy = (state != S_IDLE) | ~init_calib_complete;

    assign s_axi_awid = 1'b0;
    assign s_axi_awlen = 8'd0;
    assign s_axi_awsize = 3'b011;
    assign s_axi_awburst = 2'b01;
    assign s_axi_awlock = 1'b0;
    assign s_axi_awcache = 4'b0011;
    assign s_axi_awprot = 3'b000;
    assign s_axi_awqos = 4'b0000;

    assign s_axi_wlast = 1'b1;

    assign s_axi_arid = 1'b0;
    assign s_axi_arlen = 8'd0;
    assign s_axi_arsize = 3'b011;
    assign s_axi_arburst = 2'b01;
    assign s_axi_arlock = 1'b0;
    assign s_axi_arcache = 4'b0011;
    assign s_axi_arprot = 3'b000;
    assign s_axi_arqos = 4'b0000;

    always @(posedge clk) begin
        if (rst) begin
            state <= S_IDLE;
            read_high_word <= 1'b0;
            backend_resp_valid <= 1'b0;
            backend_resp_rdata <= 32'b0;
            s_axi_awaddr <= 27'b0;
            s_axi_awvalid <= 1'b0;
            s_axi_wdata <= 64'b0;
            s_axi_wstrb <= 8'b0;
            s_axi_wvalid <= 1'b0;
            s_axi_bready <= 1'b0;
            s_axi_araddr <= 27'b0;
            s_axi_arvalid <= 1'b0;
            s_axi_rready <= 1'b0;
        end else begin
            backend_resp_valid <= 1'b0;

            case (state)
                S_IDLE: begin
                    s_axi_awvalid <= 1'b0;
                    s_axi_wvalid <= 1'b0;
                    s_axi_bready <= 1'b0;
                    s_axi_arvalid <= 1'b0;
                    s_axi_rready <= 1'b0;

                    if (backend_valid & backend_ready) begin
                        if (backend_we) begin
                            s_axi_awaddr <= {backend_addr[26:3], 3'b000};
                            s_axi_wdata <= backend_addr[2] ? {backend_wdata, 32'b0} : {32'b0, backend_wdata};
                            s_axi_wstrb <= backend_addr[2] ? {backend_wstrb, 4'b0000} : {4'b0000, backend_wstrb};
                            s_axi_awvalid <= 1'b1;
                            s_axi_wvalid <= 1'b1;
                            s_axi_bready <= 1'b1;
                            state <= S_WRITE;
                        end else begin
                            s_axi_araddr <= {backend_addr[26:3], 3'b000};
                            read_high_word <= backend_addr[2];
                            s_axi_arvalid <= 1'b1;
                            s_axi_rready <= 1'b1;
                            state <= S_READ;
                        end
                    end
                end

                S_WRITE: begin
                    if (s_axi_awvalid & s_axi_awready) begin
                        s_axi_awvalid <= 1'b0;
                    end
                    if (s_axi_wvalid & s_axi_wready) begin
                        s_axi_wvalid <= 1'b0;
                    end
                    if (s_axi_bvalid & s_axi_bready) begin
                        s_axi_bready <= 1'b0;
                        backend_resp_rdata <= 32'b0;
                        state <= S_RESP;
                    end
                end

                S_READ: begin
                    if (s_axi_arvalid & s_axi_arready) begin
                        s_axi_arvalid <= 1'b0;
                    end
                    if (s_axi_rvalid & s_axi_rready) begin
                        s_axi_rready <= 1'b0;
                        backend_resp_rdata <= read_high_word ? s_axi_rdata[63:32] : s_axi_rdata[31:0];
                        state <= S_RESP;
                    end
                end

                S_RESP: begin
                    backend_resp_valid <= 1'b1;
                    state <= S_IDLE;
                end

                default: begin
                    state <= S_IDLE;
                end
            endcase
        end
    end
endmodule
