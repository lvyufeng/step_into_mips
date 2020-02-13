// 带使能端的D寄存器，推荐写法一
module Dflipflop_en(
    input      clk,
    input      en,
    input      din,
    output reg q
);

always @(posedge clk) begin
    if (en) q <= din;
end

endmodule


module Dflipflop_en(
    input      clk,
    input      en,
    input      din,
    output reg q
);

always @(posedge clk) begin
    q <= en ? din : q;
end

endmodule

