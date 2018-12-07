`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/08/11 07:49:12
// Design Name: 
// Module Name: cp0_reg
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

`include "defines.h"
module cp0_reg(
	input wire clk,
	input wire resetn,

	input wire we_i,
	input[4:0] waddr_i,
	input[4:0] raddr_i,
	input[31:0] data_i,

	input wire[5:0] int_i,

	input wire[31:0] excepttype_i,
	input wire[31:0] current_inst_addr_i,
	input wire is_in_delayslot_i,
	input wire[31:0] bad_addr_i,

	
	output reg[31:0] data_o,status_o,
	output reg[31:0] cause_o,
	output reg[31:0] epc_o,
	
	output reg[31:0] badvaddr,
	output reg timer_int_o
    );

	reg[31:0] count_o,compare_o,config_o,prid_o;

	always @(posedge clk) begin
		if(~resetn) begin
			count_o <= 32'b0;
			compare_o <= 32'b0;
			status_o <= 32'b00010000000000000000000000000000;
			cause_o <= 32'b0;
			epc_o <= 32'b0;
			config_o <= 32'b00000000000000001000000000000000;
			prid_o <= 32'b00000000010011000000000100000010;
			timer_int_o <= 1'b0;
		end else begin
			count_o <= count_o + 1;
			cause_o[15:10] <= int_i;
			if(compare_o != 32'b0 && count_o == compare_o) begin
				/* code */
				timer_int_o <= 1'b1;
			end
			if(we_i == 1'b1) begin
				/* code */
				case (waddr_i)
					`CP0_COUNT:begin 
						count_o <= data_i;
					end
					`CP0_COMPARE:begin 
						compare_o <= data_i;
						timer_int_o <= 1'b0;
					end
					`CP0_STATUS:begin 
						status_o <= data_i;
					end
					`CP0_CAUSE:begin 
						cause_o[9:8] <= data_i[9:8];
						cause_o[23] <= data_i[23];
						cause_o[22] <= data_i[22];
					end
					`CP0_EPC:begin 
						epc_o <= data_i;
					end
					default : /* default */;
				endcase
			end
			case (excepttype_i)
				32'h00000001:begin //interrupt
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b00000;
				end
				32'h00000004:begin //adel
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b00100;
					badvaddr <= bad_addr_i;
				end
				32'h00000005:begin //ades
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b00101;
					badvaddr <= bad_addr_i;
				end
				32'h00000008:begin //syscall
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b01000;
				end
				32'h00000009:begin //break
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b01001;
				end
				32'h0000000a:begin //ri
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b01010;
				end
				32'h0000000c:begin //overflow
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b01100;
				end
				32'h0000000d:begin //
					if(is_in_delayslot_i == 1'b1) begin
						/* code */
						epc_o <= current_inst_addr_i - 4;
						cause_o[31] <= 1'b1;
					end else begin 
						epc_o <= current_inst_addr_i;
						cause_o[31] <= 1'b0;
					end
					status_o[1] <= 1'b1;
					cause_o[6:2] <= 5'b01101;
				end
				32'h0000000e:begin //eret
					status_o[1] <= 1'b0;
				end
				default : /* default */;
			endcase
		end
	end

	always @(*) begin
		if(~resetn) begin
			/* code */
			data_o <= 32'b0;
		end else begin 
			case (raddr_i)
				`CP0_COUNT:begin 
					data_o <= count_o;
				end
				`CP0_COMPARE:begin 
					data_o <= compare_o;
				end
				`CP0_STATUS:begin 
					data_o <= status_o;
				end
				`CP0_CAUSE:begin 
					data_o <= cause_o;
				end
				`CP0_EPC:begin 
					data_o <= epc_o;
				end
				`CP0_PRID:begin 
					data_o <= prid_o;
				end
				`CP0_CONFIG:begin 
					data_o <= config_o;
				end
				`CP0_BADVADDR:begin 
					data_o <= badvaddr;
				end
				default : begin 
					data_o <= 32'b0;
				end
			endcase
		end
	
	end
endmodule
