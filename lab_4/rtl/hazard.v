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
	//fetch stage
	output wire stallF,
	//decode stage
	input wire[4:0] rsD,rtD,
	input wire branchD,
	output wire forwardaD,forwardbD,
	output wire stallD,
	//execute stage
	input wire[4:0] rsE,rtE,
	input wire[4:0] writeregE,
	input wire regwriteE,
	input wire memtoregE,
	output reg[1:0] forwardaE,forwardbE,
	output wire flushE,
	//mem stage
	input wire[4:0] writeregM,
	input wire regwriteM,
	input wire memtoregM,

	//write back stage
	input wire[4:0] writeregW,
	input wire regwriteW
    );

	wire lwstallD,branchstallD;

	//forwarding sources to D stage (branch equality)
	assign forwardaD = (rsD != 0 & rsD == writeregM & regwriteM);
	assign forwardbD = (rtD != 0 & rtD == writeregM & regwriteM);
	
	//forwarding sources to E stage (ALU)

	always @(*) begin
		forwardaE = 2'b00;
		forwardbE = 2'b00;
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
	end

	//stalls
	assign #1 lwstallD = memtoregE & (rtE == rsD | rtE == rtD);
	assign #1 branchstallD = branchD &
				(regwriteE & 
				(writeregE == rsD | writeregE == rtD) |
				memtoregM &
				(writeregM == rsD | writeregM == rtD));
	assign #1 stallD = lwstallD | branchstallD;
	assign #1 stallF = stallD;
		//stalling D stalls all previous stages
	assign #1 flushE = stallD;
		//stalling D flushes next stage
	// Note: not necessary to stall D stage on store
  	//       if source comes from load;
  	//       instead, another bypass network could
  	//       be added from W to M
endmodule
