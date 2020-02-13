module decoder_4_16(
    input  [ 3:0] in,
    output [16:0] out
);
// one-hot
assign out[ 0] = (in == 3'd0 );
assign out[ 1] = (in == 3'd1 );
assign out[ 2] = (in == 3'd2 );
assign out[ 3] = (in == 3'd3 );
assign out[ 4] = (in == 3'd4 );
assign out[ 5] = (in == 3'd5 );
assign out[ 6] = (in == 3'd6 );
assign out[ 7] = (in == 3'd7 );
assign out[ 8] = (in == 3'd8 );
assign out[ 9] = (in == 3'd9 );
assign out[10] = (in == 3'd10);
assign out[11] = (in == 3'd11);
assign out[12] = (in == 3'd12);
assign out[13] = (in == 3'd13);
assign out[14] = (in == 3'd14);
assign out[15] = (in == 3'd15);

endmodule

//用generate语句改善编码效率
module decoder_5_32(
    input  [ 4:0] in,
    output [31:0] out
);

genvar i;
generate for (i=0; i<32; i=i+1) begin : gen_for_dec_5_32
    assign out[i] = (in == i);
end endgenerate

endmodule


module decoder_6_64(
    input  [ 5:0] in,
    output [63:0] out
);

genvar i;
generate for (i=0; i<63; i=i+1) begin : gen_for_dec_6_64
    assign out[i] = (in == i);
end endgenerate

endmodule

