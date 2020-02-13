module bit_logic(
    input  [31:0] a,  
    input  [31:0] b,
    output [31:0] y1,
    output [31:0] y2,
    output [31:0] y3,
    output [31:0] y4,
    output [31:0] y5,
    output [31:0] y6,
    output [31:0] y7
);

assign y1 = a & b;     //与
assign y2 = a | b;     //或
assign y3 = ~a;        //非
assign y4 = ~(a & b);  //与非
assign y5 = ~(a | b);  //或非
assign y6 = a ^ b;     //异或
assign y7 = a ~^ b;    //同或

endmodule

//ALU
