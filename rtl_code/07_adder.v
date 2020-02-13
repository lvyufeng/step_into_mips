module adder(
    input  [31:0] a,
    input  [31:0] b,
    input         cin,
    output [31:0] s,
    output        cout
);

assign {cout, s} = a + b + cin;

endmodule

