// 带复位的D寄存器，推荐写法一
module Dflipflop_r(
    input      clk,
    input      rst,
    input      din,
    output reg q
);

always @(posedge clk) begin
    if      (rst) q <= 1’b0;
    else if (en)  q <= din;
end

endmodule


module Dflipflop_r(
    input      clk,
    input      rst,
    input      din,
    output reg q
);

always @(posedge clk) begin
    q <= rst ? 1'b0 :
         en  ? din  : q;
end

endmodule

