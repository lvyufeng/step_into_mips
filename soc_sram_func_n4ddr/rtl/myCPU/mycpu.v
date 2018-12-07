`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/02 16:06:17
// Design Name: 
// Module Name: mycpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mycpu(
	input wire clk,resetn,
	input wire[5:0] int,
	
	//cpu inst sram
	output wire        inst_sram_en,
	output wire [3 :0] inst_sram_wen,
	output wire [31:0] inst_sram_addr,
	output wire [31:0] inst_sram_wdata,
	input wire [31:0] inst_sram_rdata,
	//cpu data sram
	output wire        data_sram_en,
	output wire [3 :0] data_sram_wen,
	output wire [31:0] data_sram_addr,
	output wire [31:0] data_sram_wdata,
	input wire [31:0] data_sram_rdata,

	//debug signals
	output wire [31:0] debug_wb_pc,
	output wire [3 :0] debug_wb_rf_wen,
	output wire [4 :0] debug_wb_rf_wnum,
	output wire [31:0] debug_wb_rf_wdata

    );


	//fetch stage signal
	wire [31:0] pcF,pc_nextF,newpcF;
	wire stallF;
	

	//decode stage signal
	wire[12:0] controlsD;
	wire[4:0] rsD,rtD,rdD,saD,alucontrolD;
	wire[31:0] rf_outaD,rf_outbD;
	wire[31:0] srcaD,srcbD,extend_immD,pcD,jr_srcD;
	wire stallD;
	wire branchD;
	wire[5:0] opD;
		//forward
	wire[1:0] forwardaD,forwardbD;
	
	wire [7:0] exception_codeD;
	wire is_in_slotD;

	//exe stage signal
	wire[31:0] pcE,aluoutE,badaddrE;
	wire[4:0] writeregE,rsE,rtE,rdE;
	wire [1:0] controlsE;
	wire[5:0] opE;
	wire flushE,data_sram_enE;
	wire [7:0] exception_codeE;
	wire is_in_slotE;

		//forward
	wire[1:0] forwardaE,forwardbE,forwardHiLoE,forwardCP0E;
	wire[63:0] hiloE;
	wire hilo_writeE,cp0_writeE;
		//div
	wire[63:0] div_resultE;
	wire div_readyE,start_divE,signed_divE,stall_divE;
    wire[31:0] div_srcaE,div_srcbE;
	wire stallE;
		//cp0
	wire[31:0] cp0_srcE;

	//mem stage signal
	wire[31:0] pcM,resultM,excepttypeM,badaddrM;
	wire[4:0] writeregM;
	wire controlsM;
	wire[63:0] hiloM;
	wire hilo_writeM,cp0_writeM;
	wire stallM;
	wire[31:0] cp0_statusE,cp0_causeE,cp0_epcM;
	wire is_in_slotM;


	//wb stage signal
	wire[31:0] resultW;
	wire[4:0] writeregW;
	wire regwriteW;
	wire[63:0] hiloW;
	wire hilo_writeW,cp0_writeW;

	wire [63:0] hiloReg;
	wire stallW;

	wire flushALL;
	//next PC logic (operates in fetch an decode)
	pc_next pc_next(
   		.pc(pcF), //from fetch stage
		.inst(inst_sram_rdata), //from decode stage
    	.signal({branchD,controlsD[6],controlsD[4]}),//wait to finish
		.jr_src(jr_srcD),
    	.pc_next(pc_nextF) // to fetch stage
    );

	//fetch stage logic
	fetch_stage fetch_stage(
		.clk(clk),
		.resetn(resetn),
		.stall(stallF),
		.flush(flushALL),
		.pc_next(pc_nextF),
		.newpc(newpcF),

		.inst_sram_addr(inst_sram_addr),//pc_next if not stall and flush
		.inst_sram_en(inst_sram_en),
		.pc(pcF)
	);
		//iram control
	// assign inst_sram_en = 1'b1;
	assign inst_sram_wen = 4'b0000;
	assign inst_sram_wdata = 32'b0;

	//decode stage logic

	decode_stage decode_stage(
    	.clk(clk),
		.resetn(resetn),
		.stall(stallD),
		.flush(flushALL),
		.inst_sram_en(inst_sram_en),
		.pc(pcF),
		.instr(inst_sram_rdata),
		.controls(controlsD),
		.alucontrol(alucontrolD),
		.rs(rsD),
		.rt(rtD),
		.rd(rdD),
		.sa(saD),
		.op(opD),
		.pc_next(pcD),
		.rf_outa(rf_outaD),
		.rf_outb(rf_outbD),
		.srca(srcaD),
		.srcb(srcbD),
		.extend_imm(extend_immD),
		.jr_src(jr_srcD),
		.branch(branchD),

		//forward
		.forwardaD(forwardaD),
		.forwardbD(forwardbD),
		.aluoutE(aluoutE),
		.resultM(resultM),
		.resultW(resultW),

		//exception
		.exception_code(exception_codeD),

		//delay slot
		.is_in_slot(controlsD[1]),
		.is_in_slot_next(is_in_slotD)

    );

	// exe stage
	exe_stage exe_stage(
    	.clk(clk),
		.resetn(resetn),
		.stall(stallE),
		.flush(flushE | flushALL),
    	.pc(pcD),
		.srca(srcaD),
		.srcb(srcbD),
		.extend_imm(extend_immD),
		.controls({controlsD[3],controlsD[4],controlsD[5],controlsD[12:10],controlsD[8:7],controlsD[2]}),//5
		.alucontrol(alucontrolD),
   		.rs(rsD),
		.rt(rtD),
		.rd(rdD),
		.sa(saD),

		//forward
    	.forwardaE(forwardaE),
		.forwardbE(forwardbE),
    	.resultM(resultM),
		.resultW(resultW),

    	.aluout(aluoutE),
    	.writereg(writeregE),
		.rs_next(rsE),
		.rt_next(rtE),
		.pc_next(pcE),
		.controls_next(controlsE),

		.hilo(hiloReg),
		.hiloM(hiloM),
		.hiloW(hiloW),
		.forwardhilo(forwardHiLoE),
		.hilo_write(hilo_writeE),
		.hilo_next(hiloE),

		//div
    	.div_result(div_resultE),
		.div_ready(div_readyE),
		.start_div(start_divE),
		.signed_div(signed_divE),
		.stall_div(stall_divE),
		.div_srca(div_srcaE),
		.div_srcb(div_srcbE),

		//mem
		.op(opD),
		.addr(data_sram_addr),
		.en(data_sram_enE),
		.writedata(data_sram_wdata),
    	.sel(data_sram_wen),
		.opE(opE),

		//cp0
		.cp0_src(cp0_srcE),
    	.forwardCP0(forwardCP0E),
    	.cp0_write(cp0_writeE),
		.rd_next(rdE),

		//exception
		.exception_code(exception_codeD),
		.exception_code_next(exception_codeE),
		.badaddr(badaddrE),

		.cp0_status(cp0_statusE),
		.cp0_cause(cp0_causeE),

		//delay slot
		.is_in_slot(is_in_slotD),
		.is_in_slot_next(is_in_slotE)
    );

	assign data_sram_en = data_sram_enE & ~flushALL;

	div div(
    	.clk(clk),
		.resetn(resetn),
	
		.signed_div_i(signed_divE),
		.opdata1_i(div_srcaE),
		.opdata2_i(div_srcbE),
		.start_i(start_divE),
		.annul_i(flushALL),
	
		.result_o(div_resultE),
		.ready_o(div_readyE)
);
	
	//mem stage
	mem_stage mem_stage(
		.clk(clk),
		.resetn(resetn),
		.stall(stallM),
		.flush(flushALL),
		.op(opE),
		.pc(pcE),
    	.mem_read(data_sram_rdata),
		.aluout(aluoutE),
   		.writereg(writeregE),
		.controls(controlsE),
		.pc_next(pcM),
    	.result(resultM),
    	.writereg_next(writeregM),
		.controls_next(controlsM),

		.hilo_write(hilo_writeE),
		.hilo(hiloE),
		.hilo_write_next(hilo_writeM),
		.hilo_next(hiloM),

		//cp0
		.cp0_write(cp0_writeE),
		.cp0_write_next(cp0_writeM),
		//exception
		.exception_code(exception_codeE),
		.excepttype(excepttypeM),
		.badaddr(badaddrE),
		.badaddr_next(badaddrM),

		//delay slot
		.is_in_slot(is_in_slotE),
		.is_in_slot_next(is_in_slotM)

		
    );

	//writeback stage
	wb_stage wb_stage(
		.clk(clk),
		.resetn(resetn),
		.stall(stallW),
		.flush(flushALL),
   		.pc(pcM),
	   	.result(resultM),
		.writereg(writeregM),
		.controls(controlsM),
		.pc_next(debug_wb_pc),
		.result_next(resultW),
		.writereg_next(writeregW),
		.regwrite(regwriteW),

		.hilo_write(hilo_writeM),
		.hilo(hiloM),
		.hilo_write_next(hilo_writeW),
		.hilo_next(hiloW),

		//cp0
		.cp0_write(cp0_writeM),
		.cp0_write_next(cp0_writeW)
    );

	assign debug_wb_rf_wdata = resultW;
	// assign debug_wb_rf_wen = {4{regwriteW}};
	assign debug_wb_rf_wnum = writeregW;
	
	// hazard module
	hazard hazard(
		//decode stage
		.rsD(rsD),
		.rtD(rtD),
		.forwardaD(forwardaD),
		.forwardbD(forwardbD),
	//execute stage
		.rsE(rsE),
		.rtE(rtE),
		.rdE(rdE),
		.stall_divE(stall_divE),
		.forwardaE(forwardaE),
		.forwardbE(forwardbE),
		.forwardHiLoE(forwardHiLoE),
		.forwardCP0E(forwardCP0E),

		.writeregE(writeregE),
		.regwriteE(controlsE[1]),
		.memtoregE(controlsE[0]),
	//mem stage
		.writeregM(writeregM),
		.regwriteM(controlsM),
		.hilo_writeM(hilo_writeM),
		.cp0_writeM(cp0_writeM),
	
	//write back stage
		.writeregW(writeregW),
		.regwriteW(regwriteW),
		.hilo_writeW(hilo_writeW),
		.cp0_writeW(cp0_writeW),

		.stallF(stallF),
		.stallD(stallD),
		.stallE(stallE),
		.stallM(stallM),
		.stallW(stallW),
		.flushE(flushE),
		.flushALL(flushALL),

		.excepttype(excepttypeM),
		.cp0_epc(cp0_epcM),
		.newpc(newpcF)
	
    );


	// regfile
	regfile regfile(
		.clk(clk),
		.we3(regwriteW), //regwrite
		.ra1(inst_sram_rdata[25:21]), // rs
		.ra2(inst_sram_rdata[20:16]), // rt
		.wa3(writeregW),	//
		.wd3(resultW),	//
		.rd1(rf_outaD),	//
		.rd2(rf_outbD)	//
    );
	
	//hilo reg
	hilo_reg hilo_reg(
		.clk(clk),
		.resetn(resetn),
		.we(hilo_writeW),
		.hi(hiloW[63:32]),
		.lo(hiloW[31:0]),
		.hi_o(hiloReg[63:32]),
		.lo_o(hiloReg[31:0])
    );

	//cp0 reg
	cp0_reg cp0_reg(
		.clk(clk),
		.resetn(resetn),

		.we_i(cp0_writeW),
		.waddr_i(writeregW),
		.raddr_i(rdE),
		.data_i(resultW),

		.int_i(int),

		.excepttype_i(excepttypeM),
		.current_inst_addr_i(pcM),
		.is_in_delayslot_i(is_in_slotM),
		.bad_addr_i(badaddrM),

	
		.data_o(cp0_srcE),
		.status_o(cp0_statusE),
		.cause_o(cp0_causeE),
		.epc_o(cp0_epcM),
	
		.badvaddr(),
		.timer_int_o()
    );

endmodule
