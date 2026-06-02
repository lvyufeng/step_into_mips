`timescale 1ns / 1ps

module clk_100_to_200(
    input wire clk100,
    input wire rst,
    output wire clk200,
    output wire locked
    );

    wire clkfb;
    wire clkfb_buf;
    wire clk200_unbuf;

    BUFG clkfb_bufg(
        .I(clkfb),
        .O(clkfb_buf)
        );

    BUFG clk200_bufg(
        .I(clk200_unbuf),
        .O(clk200)
        );

    MMCME2_BASE #(
        .CLKIN1_PERIOD(10.000),
        .DIVCLK_DIVIDE(1),
        .CLKFBOUT_MULT_F(10.000),
        .CLKFBOUT_PHASE(0.000),
        .CLKOUT0_DIVIDE_F(5.000),
        .CLKOUT0_PHASE(0.000),
        .CLKOUT0_DUTY_CYCLE(0.500),
        .STARTUP_WAIT("FALSE")
    ) mmcm(
        .CLKIN1(clk100),
        .CLKFBIN(clkfb_buf),
        .RST(rst),
        .PWRDWN(1'b0),
        .CLKFBOUT(clkfb),
        .CLKFBOUTB(),
        .CLKOUT0(clk200_unbuf),
        .CLKOUT0B(),
        .CLKOUT1(),
        .CLKOUT1B(),
        .CLKOUT2(),
        .CLKOUT2B(),
        .CLKOUT3(),
        .CLKOUT3B(),
        .CLKOUT4(),
        .CLKOUT5(),
        .CLKOUT6(),
        .LOCKED(locked)
        );
endmodule
