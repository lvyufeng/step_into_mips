module regfile(
    input         clk,
    // READ PORT 1
    input  [ 4:0] raddr1,
    output [31:0] rdata1,
    // READ PORT 2
    input  [ 4:0] raddr2,
    output [31:0] rdata2,
    // WRITE PORT
    input         we,       //write enable, HIGH valid
    input  [ 4:0] waddr,
    input  [31:0] wdata
);
reg [31:0] rf[31:0];

//WRITE
always @(posedge clk) begin
    if (we) rf[waddr]<= wdata;
end

//READ OUT 1
assign rdata1 = (raddr1==5'b0) ? 32'b0 : rf[raddr1];

//READ OUT 2
assign rdata2 = (raddr2==5'b0) ? 32'b0 : rf[raddr2];

endmodule



module regfile(
    input         clk,
    // READ PORT 1
    input  [ 4:0] raddr1,
    output [31:0] rdata1,
    // READ PORT 2
    input  [ 4:0] raddr2,
    output [31:0] rdata2,
    // WRITE PORT
    input         we,       //write enable, HIGH valid
    input  [ 4:0] waddr,
    input  [31:0] wdata
);

reg  [31:0] rf[31:0];
wire [31:0] waddr_dec, raddr1_dec, raddr2_dec;

//WRITE
decoder_5_32 U0(.in(waddr ), .out(waddr_dec));

always @(posedge clk) begin
    if (we & waddr_dec[ 0]) rf[ 0] <= wdata;
    if (we & waddr_dec[ 1]) rf[ 1] <= wdata;
    if (we & waddr_dec[ 2]) rf[ 2] <= wdata;
    if (we & waddr_dec[ 3]) rf[ 3] <= wdata;
    if (we & waddr_dec[ 4]) rf[ 4] <= wdata;
    if (we & waddr_dec[ 5]) rf[ 5] <= wdata;
    if (we & waddr_dec[ 6]) rf[ 6] <= wdata;
    if (we & waddr_dec[ 7]) rf[ 7] <= wdata;
    if (we & waddr_dec[ 8]) rf[ 8] <= wdata;
    if (we & waddr_dec[ 9]) rf[ 9] <= wdata;
    if (we & waddr_dec[10]) rf[10] <= wdata;
    if (we & waddr_dec[11]) rf[11] <= wdata;
    if (we & waddr_dec[12]) rf[12] <= wdata;
    if (we & waddr_dec[13]) rf[13] <= wdata;
    if (we & waddr_dec[14]) rf[14] <= wdata;
    if (we & waddr_dec[15]) rf[15] <= wdata;
    if (we & waddr_dec[16]) rf[16] <= wdata;
    if (we & waddr_dec[17]) rf[17] <= wdata;
    if (we & waddr_dec[18]) rf[18] <= wdata;
    if (we & waddr_dec[19]) rf[19] <= wdata;
    if (we & waddr_dec[20]) rf[20] <= wdata;
    if (we & waddr_dec[21]) rf[21] <= wdata;
    if (we & waddr_dec[22]) rf[22] <= wdata;
    if (we & waddr_dec[23]) rf[23] <= wdata;
    if (we & waddr_dec[24]) rf[24] <= wdata;
    if (we & waddr_dec[25]) rf[25] <= wdata;
    if (we & waddr_dec[26]) rf[26] <= wdata;
    if (we & waddr_dec[27]) rf[27] <= wdata;
    if (we & waddr_dec[28]) rf[28] <= wdata;
    if (we & waddr_dec[29]) rf[29] <= wdata;
    if (we & waddr_dec[30]) rf[30] <= wdata;
    if (we & waddr_dec[31]) rf[31] <= wdata;
end

//READ OUT 1
decoder_5_32 U1(.in(raddr1), .out(raddr1_dec));

assign rdata1 = ({32{raddr1_dec[ 1]}} & rf[ 1]) //NOTE: we omit No. 0 entry because GR[0] always be zero.
              | ({32{raddr1_dec[ 2]}} & rf[ 2])
              | ({32{raddr1_dec[ 3]}} & rf[ 3])
              | ({32{raddr1_dec[ 4]}} & rf[ 4])
              | ({32{raddr1_dec[ 5]}} & rf[ 5])
              | ({32{raddr1_dec[ 6]}} & rf[ 6])
              | ({32{raddr1_dec[ 7]}} & rf[ 7])
              | ({32{raddr1_dec[ 8]}} & rf[ 8])
              | ({32{raddr1_dec[ 9]}} & rf[ 9])
              | ({32{raddr1_dec[10]}} & rf[10])
              | ({32{raddr1_dec[11]}} & rf[11])
              | ({32{raddr1_dec[12]}} & rf[12])
              | ({32{raddr1_dec[13]}} & rf[13])
              | ({32{raddr1_dec[14]}} & rf[14])
              | ({32{raddr1_dec[15]}} & rf[15])
              | ({32{raddr1_dec[16]}} & rf[16])
              | ({32{raddr1_dec[17]}} & rf[17])
              | ({32{raddr1_dec[18]}} & rf[18])
              | ({32{raddr1_dec[19]}} & rf[19])
              | ({32{raddr1_dec[20]}} & rf[20])
              | ({32{raddr1_dec[21]}} & rf[21])
              | ({32{raddr1_dec[22]}} & rf[22])
              | ({32{raddr1_dec[23]}} & rf[23])
              | ({32{raddr1_dec[24]}} & rf[24])
              | ({32{raddr1_dec[25]}} & rf[25])
              | ({32{raddr1_dec[26]}} & rf[26])
              | ({32{raddr1_dec[27]}} & rf[27])
              | ({32{raddr1_dec[28]}} & rf[28])
              | ({32{raddr1_dec[29]}} & rf[29])
              | ({32{raddr1_dec[30]}} & rf[30])
              | ({32{raddr1_dec[31]}} & rf[31]);

//READ OUT 2
decoder_5_32 U2(.in(raddr2), .out(raddr2_dec));

assign rdata2 = ({32{raddr2_dec[ 1]}} & rf[ 1])
              | ({32{raddr2_dec[ 2]}} & rf[ 2])
              | ({32{raddr2_dec[ 3]}} & rf[ 3])
              | ({32{raddr2_dec[ 4]}} & rf[ 4])
              | ({32{raddr2_dec[ 5]}} & rf[ 5])
              | ({32{raddr2_dec[ 6]}} & rf[ 6])
              | ({32{raddr2_dec[ 7]}} & rf[ 7])
              | ({32{raddr2_dec[ 8]}} & rf[ 8])
              | ({32{raddr2_dec[ 9]}} & rf[ 9])
              | ({32{raddr2_dec[10]}} & rf[10])
              | ({32{raddr2_dec[11]}} & rf[11])
              | ({32{raddr2_dec[12]}} & rf[12])
              | ({32{raddr2_dec[13]}} & rf[13])
              | ({32{raddr2_dec[14]}} & rf[14])
              | ({32{raddr2_dec[15]}} & rf[15])
              | ({32{raddr2_dec[16]}} & rf[16])
              | ({32{raddr2_dec[17]}} & rf[17])
              | ({32{raddr2_dec[18]}} & rf[18])
              | ({32{raddr2_dec[19]}} & rf[19])
              | ({32{raddr2_dec[20]}} & rf[20])
              | ({32{raddr2_dec[21]}} & rf[21])
              | ({32{raddr2_dec[22]}} & rf[22])
              | ({32{raddr2_dec[23]}} & rf[23])
              | ({32{raddr2_dec[24]}} & rf[24])
              | ({32{raddr2_dec[25]}} & rf[25])
              | ({32{raddr2_dec[26]}} & rf[26])
              | ({32{raddr2_dec[27]}} & rf[27])
              | ({32{raddr2_dec[28]}} & rf[28])
              | ({32{raddr2_dec[29]}} & rf[29])
              | ({32{raddr2_dec[30]}} & rf[30])
              | ({32{raddr2_dec[31]}} & rf[31]);

endmodule

