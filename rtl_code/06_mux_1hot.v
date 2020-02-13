module mux5_1hot_8b(
  input  [7:0] in0, in1, in2, in3, in4,
  input  [4:0] sel_v,
  output [7:0] out
);

assign out = ({8{sel_v[0]}} & in0)
           | ({8{sel_v[1]}} & in1)
           | ({8{sel_v[2]}} & in2)
           | ({8{sel_v[3]}} & in3)
           | ({8{sel_v[4]}} & in4);

endmodule
