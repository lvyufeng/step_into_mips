// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
// Date        : Sun Nov 18 15:45:49 2018
// Host        : LV-1701 running 64-bit Ubuntu 16.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/lv/VivadoProjects/CST31101_lab/soc_sram_func_n4ddr/rtl/xilinx_ip/clk_pll/clk_pll_stub.v
// Design      : clk_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_pll(cpu_clk, timer_clk, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="cpu_clk,timer_clk,clk_in1" */;
  output cpu_clk;
  output timer_clk;
  input clk_in1;
endmodule
