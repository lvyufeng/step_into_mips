//最普通的上跳沿触发的D寄存器
module Dflipflop(
    input      clk,
    input      din,
    output reg q
);

always @(posedge clk) begin
    q <= din;
end

endmodule
