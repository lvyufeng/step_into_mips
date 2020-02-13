module top;

wire [15:0] btm_a;
wire [ 7:0] btm_b;
wire [ 3:0] btm_c;
wire [ 3:0] btm_y;
wire        btm_z;

bottom #(
    .A_WIDTH (16),
    .B_WIDTH ( 7),
    .Y_WIDTH ( 3)
    )
    inst_btm(
    .a   (btm_a),  //I
    .b   (btm_b),  //I
    .c   (btm_c),  //I
    .y   (btm_y),  //O
    .z   (btm_z)   //O
    );

endmodule

module bottom #
(
    parameter A_WIDTH = 8,
    parameter B_WIDTH = 4,
    parameter Y_WIDTH = 2
)
(
    input   wire [A_WIDTH-1:0] a,
    input   wire [B_WIDTH-1:0] b,
    input   wire [        3:0] c,
    output  wire [Y_WIDTH-1:0] y,
    output  reg                z
);

// internal logic

endmodule

