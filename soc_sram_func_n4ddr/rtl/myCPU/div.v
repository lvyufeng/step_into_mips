`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/03 20:07:28
// Design Name: 
// Module Name: div
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


module div(
    input wire clk,
	input wire resetn,
	
	input wire signed_div_i,
	input wire[31:0] opdata1_i,
	input wire[31:0] opdata2_i,
	input wire start_i,
	input wire annul_i,
	
	output reg[63:0] result_o,
	output reg ready_o
);

	wire[32:0] div_temp;
	reg[5:0] cnt;
	reg[64:0] dividend;
	reg[1:0] state;
	reg[31:0] divisor;	 
	reg[31:0] temp_op1;
	reg[31:0] temp_op2;
	reg[31:0] opdata1,opdata2;
	
	assign div_temp = {1'b0,dividend[63:32]} - {1'b0,divisor};

	always @ (posedge clk) begin
		if (~resetn) begin
			state <= 2'b00;
			ready_o <= 1'b0;
			result_o <= 64'b0;
		end else begin
		    case (state)
		  	    2'b00:begin               //DivFree״̬
		  		    if(start_i == 1'b1 && annul_i == 1'b0) begin
		  			    if(opdata2_i == 32'b0) begin
		  				    state <= 2'b01;
		  			    end else begin
		  				    state <= 2'b10;
		  				    cnt <= 6'b000000;
							opdata1 <= opdata1_i;
							opdata2 <= opdata2_i;
		  				    if(signed_div_i == 1'b1 && opdata1_i[31] == 1'b1 ) begin
		  					    temp_op1 = ~opdata1_i + 1;
		  				    end else begin
		  					    temp_op1 = opdata1_i;
		  				    end
		  				    if(signed_div_i == 1'b1 && opdata2_i[31] == 1'b1 ) begin
		  					    temp_op2 = ~opdata2_i + 1;
		  				    end else begin
		  					    temp_op2 = opdata2_i;
		  				    end
		  				    dividend <= 64'b0;
                            dividend[32:1] <= temp_op1;
                            divisor <= temp_op2;
                        end
                    end else begin
						ready_o <= 1'b0;
						result_o <= 64'b0;
				    end          	
		  	    end
		  	    2'b01:begin               //DivByZero
         	        dividend <= 64'b0;
                    state <= 2'b11;		 		
		  	    end
		  	    2'b10:begin               //DivOn
		  		    if(annul_i == 1'b0) begin
		  			    if(cnt != 6'b100000) begin
                            if(div_temp[32] == 1'b1) begin
                                dividend <= {dividend[63:0] , 1'b0};
                            end else begin
                                dividend <= {div_temp[31:0] , dividend[31:0] , 1'b1};
                            end
                            cnt <= cnt + 1;
                        end else begin
                            if((signed_div_i == 1'b1) && ((opdata1[31] ^ opdata2[31]) == 1'b1)) begin
                                dividend[31:0] <= (~dividend[31:0] + 1);
                            end
                            if((signed_div_i == 1'b1) && ((opdata1[31] ^ dividend[64]) == 1'b1)) begin              
                                dividend[64:33] <= (~dividend[64:33] + 1);
                            end
                            state <= 2'b11;
                            cnt <= 6'b000000;            	
                        end
		  		    end else begin
		  			    state <= 2'b00;
		  		    end	
		  	    end
		        2'b11:begin               //DivEnd
        	        result_o <= {dividend[64:33], dividend[31:0]};  
                    ready_o <= 1'b1;
                    if(start_i == 1'b0) begin
          	            state <= 2'b00;
						ready_o <= 1'b0;
						result_o <= 64'b0;       	
                    end		  	
		  	    end
		    endcase
		end
	end

endmodule
