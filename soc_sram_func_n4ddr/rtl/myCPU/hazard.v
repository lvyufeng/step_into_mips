`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/22 10:23:13
// Design Name: 
// Module Name: hazard
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


module hazard(
	//decode stage
	input wire[4:0] rsD,rtD,
	output reg[1:0] forwardaD,forwardbD,

	//execute stage
	input wire[4:0] rsE,rtE,rdE,
	input wire stall_divE,
	output reg[1:0] forwardaE,forwardbE,forwardHiLoE,forwardCP0E,

	input wire[4:0] writeregE,
	input wire regwriteE,memtoregE,
	//mem stage
	input wire[4:0] writeregM,
	input wire regwriteM,
	input wire hilo_writeM,cp0_writeM,
	
	//write back stage
	input wire[4:0] writeregW,
	input wire regwriteW,
	input wire hilo_writeW,cp0_writeW,

	output wire stallF,stallD,stallE,stallM,stallW,flushE,flushALL,

	input wire[31:0] excepttype,cp0_epc,
	output reg[31:0] newpc
	
    );

	wire lwstall;
	assign lwstall = memtoregE & (rtE == rsD | rtE == rtD);

	//forwarding sources to D stage (branch equality)

	always @(*) begin
		forwardaD = 2'b00;
		forwardbD = 2'b00;

		if(rsD != 0) begin
			/* code */
			if(rsD == writeregE & regwriteE) begin
				/* code */
				forwardaD = 2'b10;
			end else if(rsD == writeregM & regwriteM & rsD != writeregE) begin
				/* code */
				forwardaD = 2'b01;
			end else if(rsD == writeregW & regwriteW & rsD != writeregM) begin
				/* code */
				forwardaD = 2'b11;
			end
		end
		if(rtD != 0) begin
			/* code */
			if(rtD == writeregE & regwriteE) begin
				/* code */
				forwardbD = 2'b10;
			end else if(rtD == writeregM & regwriteM & rtD != writeregE) begin
				/* code */
				forwardbD = 2'b01;
			end else if(rtD == writeregW & regwriteW & rtD != writeregM) begin
				/* code */
				forwardbD = 2'b11;
			end
		end

	end
	
	//forwarding sources to E stage (ALU)
	always @(*) begin
		forwardaE = 2'b00;
		forwardbE = 2'b00;
		forwardHiLoE = 2'b00;
		forwardCP0E = 2'b00;
		if(rsE != 0) begin
			/* code */
			if(rsE == writeregM & regwriteM) begin
				/* code */
				forwardaE = 2'b10;
			end else if(rsE == writeregW & regwriteW) begin
				/* code */
				forwardaE = 2'b01;
			end
		end
		if(rtE != 0) begin
			/* code */
			if(rtE == writeregM & regwriteM) begin
				/* code */
				forwardbE = 2'b10;
			end else if(rtE == writeregW & regwriteW) begin
				/* code */
				forwardbE = 2'b01;
			end
		end

		if(hilo_writeM) begin
			/* code */
			forwardHiLoE = 2'b10;
		end else if(hilo_writeW) begin
			/* code */
			forwardHiLoE = 2'b01;
		end

		if(rdE == writeregM & cp0_writeM) begin
			/* code */
			forwardCP0E = 2'b10;
		end else if(rdE == writeregW & cp0_writeW) begin
			/* code */
			forwardCP0E = 2'b01;
		end
	end

	//exception
	assign flushALL = |excepttype;
	always @(*) begin
		if(excepttype != 32'b0) begin
			/* code */
			if (excepttype == 32'h0000000e) begin
			  	newpc <= cp0_epc;
			end else begin
			  	newpc <= 32'hBFC00380;
				// newpc <= 32'h00000040;

			end
		end
	
	end	

	assign stallF = stall_divE | lwstall;
	assign stallD = stall_divE | lwstall;
	assign stallE = stall_divE ;
	assign stallM = 1'b0;
	assign stallW = 1'b0;
	assign flushE = lwstall;
endmodule
