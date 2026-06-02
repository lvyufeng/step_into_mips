`timescale 1ns / 1ps

module top(
    input wire clk100mhz,
    input wire rst,
    input wire uart_rx_i,
    output wire uart_tx_o,
    output wire[15:0] led,

    inout wire[15:0] ddr2_dq,
    inout wire[1:0] ddr2_dqs_n,
    inout wire[1:0] ddr2_dqs_p,
    output wire[12:0] ddr2_addr,
    output wire[2:0] ddr2_ba,
    output wire ddr2_ras_n,
    output wire ddr2_cas_n,
    output wire ddr2_we_n,
    output wire[0:0] ddr2_ck_p,
    output wire[0:0] ddr2_ck_n,
    output wire[0:0] ddr2_cke,
    output wire[0:0] ddr2_cs_n,
    output wire[1:0] ddr2_dm,
    output wire[0:0] ddr2_odt
    );

    // Hold MIG in reset for a short time after FPGA configuration. This keeps
    // the board-level reset behavior deterministic before DDR calibration starts.
    reg[19:0] por_count = 20'd0;
    reg por_rst = 1'b1;

    always @(posedge clk100mhz or posedge rst) begin
        if (rst) begin
            por_count <= 20'd0;
            por_rst <= 1'b1;
        end else if (por_count != 20'hfffff) begin
            por_count <= por_count + 1'b1;
            por_rst <= 1'b1;
        end else begin
            por_rst <= 1'b0;
        end
    end

    wire clk200mhz;
    wire clk200_locked;
    reg clk50mhz;
    wire clk50mhz_buf;

    clk_100_to_200 clkgen(
        .clk100(clk100mhz),
        .rst(rst),
        .clk200(clk200mhz),
        .locked(clk200_locked)
        );

    always @(posedge clk100mhz or posedge por_rst) begin
        if (por_rst) begin
            clk50mhz <= 1'b0;
        end else begin
            clk50mhz <= ~clk50mhz;
        end
    end

    BUFG clk50_buf(
        .I(clk50mhz),
        .O(clk50mhz_buf)
        );

    wire ui_clk;
    wire ui_clk_sync_rst;
    wire ui_addn_clk_0;
    wire ui_addn_clk_1;
    wire ui_addn_clk_2;
    wire ui_addn_clk_3;
    wire ui_addn_clk_4;
    wire mig_mmcm_locked;
    wire mig_aresetn;
    wire init_calib_complete;
    wire app_sr_active;
    wire app_ref_ack;
    wire app_zq_ack;

    wire[0:0] s_axi_awid;
    wire[26:0] s_axi_awaddr;
    wire[7:0] s_axi_awlen;
    wire[2:0] s_axi_awsize;
    wire[1:0] s_axi_awburst;
    wire[0:0] s_axi_awlock;
    wire[3:0] s_axi_awcache;
    wire[2:0] s_axi_awprot;
    wire[3:0] s_axi_awqos;
    wire s_axi_awvalid;
    wire s_axi_awready;
    wire[63:0] s_axi_wdata;
    wire[7:0] s_axi_wstrb;
    wire s_axi_wlast;
    wire s_axi_wvalid;
    wire s_axi_wready;
    wire[0:0] s_axi_bid;
    wire[1:0] s_axi_bresp;
    wire s_axi_bvalid;
    wire s_axi_bready;
    wire[0:0] s_axi_arid;
    wire[26:0] s_axi_araddr;
    wire[7:0] s_axi_arlen;
    wire[2:0] s_axi_arsize;
    wire[1:0] s_axi_arburst;
    wire[0:0] s_axi_arlock;
    wire[3:0] s_axi_arcache;
    wire[2:0] s_axi_arprot;
    wire[3:0] s_axi_arqos;
    wire s_axi_arvalid;
    wire s_axi_arready;
    wire[0:0] s_axi_rid;
    wire[63:0] s_axi_rdata;
    wire[1:0] s_axi_rresp;
    wire s_axi_rlast;
    wire s_axi_rvalid;
    wire s_axi_rready;

    reg[3:0] rst_sync;
    wire soc_rst;
    wire soc_clk = clk50mhz_buf;
    wire bus_clk = ~clk50mhz_buf;
    wire backend_clk = ui_clk;

    always @(posedge soc_clk or posedge por_rst) begin
        if (por_rst) begin
            rst_sync <= 4'hf;
        end else begin
            rst_sync <= {rst_sync[2:0], 1'b0};
        end
    end

    assign soc_rst = rst_sync[3];
    assign mig_aresetn = ~ui_clk_sync_rst;

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
    wire axi_backend_valid;
    wire axi_backend_we;
    wire[3:0] axi_backend_wstrb;
    wire[26:0] axi_backend_addr;
    wire[31:0] axi_backend_wdata;
    wire axi_backend_ready;
    wire axi_backend_resp_valid;
    wire[31:0] axi_backend_resp_rdata;
    wire axi_backend_busy;

    wire[31:0] debug_writedata;
    wire[31:0] debug_dataadr;
    wire debug_memwrite;
    wire uart_tx_ready;
    wire uart_rx_valid;

    soc #(
        .UART_CLKS_PER_BIT(434),
        .TIMER_TICK_CYCLES(32'd50000000)
    ) soc(
        .clk(soc_clk),
        .bus_clk(bus_clk),
        .rst(soc_rst),
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

    ddr_backend_cdc ddr_cdc(
        .bus_clk(bus_clk),
        .bus_rst(soc_rst),
        .bus_valid(ddr_backend_valid),
        .bus_we(ddr_backend_we),
        .bus_wstrb(ddr_backend_wstrb),
        .bus_addr(ddr_backend_addr),
        .bus_wdata(ddr_backend_wdata),
        .bus_ready(ddr_backend_ready),
        .bus_resp_valid(ddr_backend_resp_valid),
        .bus_resp_rdata(ddr_backend_resp_rdata),
        .bus_calib_done(ddr_backend_calib_done),
        .bus_busy(ddr_backend_busy),
        .axi_clk(backend_clk),
        .axi_rst(ui_clk_sync_rst),
        .axi_valid(axi_backend_valid),
        .axi_we(axi_backend_we),
        .axi_wstrb(axi_backend_wstrb),
        .axi_addr(axi_backend_addr),
        .axi_wdata(axi_backend_wdata),
        .axi_ready(axi_backend_ready),
        .axi_resp_valid(axi_backend_resp_valid),
        .axi_resp_rdata(axi_backend_resp_rdata),
        .axi_calib_done(init_calib_complete),
        .axi_busy(axi_backend_busy)
        );

    mig_axi_adapter ddr_axi(
        .clk(backend_clk),
        .rst(ui_clk_sync_rst),
        .backend_valid(axi_backend_valid),
        .backend_we(axi_backend_we),
        .backend_wstrb(axi_backend_wstrb),
        .backend_addr(axi_backend_addr),
        .backend_wdata(axi_backend_wdata),
        .backend_ready(axi_backend_ready),
        .backend_resp_valid(axi_backend_resp_valid),
        .backend_resp_rdata(axi_backend_resp_rdata),
        .init_calib_complete(init_calib_complete),
        .busy(axi_backend_busy),
        .s_axi_awid(s_axi_awid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awsize(s_axi_awsize),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awlock(s_axi_awlock),
        .s_axi_awcache(s_axi_awcache),
        .s_axi_awprot(s_axi_awprot),
        .s_axi_awqos(s_axi_awqos),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wready(s_axi_wready),
        .s_axi_bid(s_axi_bid),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_arid(s_axi_arid),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arlock(s_axi_arlock),
        .s_axi_arcache(s_axi_arcache),
        .s_axi_arprot(s_axi_arprot),
        .s_axi_arqos(s_axi_arqos),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arready(s_axi_arready),
        .s_axi_rid(s_axi_rid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_rready(s_axi_rready)
        );

    lab9_mig u_lab9_mig(
        .ddr2_addr(ddr2_addr),
        .ddr2_ba(ddr2_ba),
        .ddr2_cas_n(ddr2_cas_n),
        .ddr2_ck_n(ddr2_ck_n),
        .ddr2_ck_p(ddr2_ck_p),
        .ddr2_cke(ddr2_cke),
        .ddr2_ras_n(ddr2_ras_n),
        .ddr2_we_n(ddr2_we_n),
        .ddr2_dq(ddr2_dq),
        .ddr2_dqs_n(ddr2_dqs_n),
        .ddr2_dqs_p(ddr2_dqs_p),
        .init_calib_complete(init_calib_complete),
        .ddr2_cs_n(ddr2_cs_n),
        .ddr2_dm(ddr2_dm),
        .ddr2_odt(ddr2_odt),
        .ui_clk(ui_clk),
        .ui_clk_sync_rst(ui_clk_sync_rst),
        .ui_addn_clk_0(ui_addn_clk_0),
        .ui_addn_clk_1(ui_addn_clk_1),
        .ui_addn_clk_2(ui_addn_clk_2),
        .ui_addn_clk_3(ui_addn_clk_3),
        .ui_addn_clk_4(ui_addn_clk_4),
        .mmcm_locked(mig_mmcm_locked),
        .aresetn(mig_aresetn),
        .app_sr_req(1'b0),
        .app_ref_req(1'b0),
        .app_zq_req(1'b0),
        .app_sr_active(app_sr_active),
        .app_ref_ack(app_ref_ack),
        .app_zq_ack(app_zq_ack),
        .s_axi_awid(s_axi_awid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awsize(s_axi_awsize),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awlock(s_axi_awlock),
        .s_axi_awcache(s_axi_awcache),
        .s_axi_awprot(s_axi_awprot),
        .s_axi_awqos(s_axi_awqos),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wready(s_axi_wready),
        .s_axi_bid(s_axi_bid),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_arid(s_axi_arid),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arlock(s_axi_arlock),
        .s_axi_arcache(s_axi_arcache),
        .s_axi_arprot(s_axi_arprot),
        .s_axi_arqos(s_axi_arqos),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arready(s_axi_arready),
        .s_axi_rid(s_axi_rid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_rready(s_axi_rready),
        .sys_clk_i(clk200mhz),
        .sys_rst(~por_rst & clk200_locked)
        );
endmodule
