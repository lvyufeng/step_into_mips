本目录提供大赛功能测试包。


更新日志
--v0.01：20180710
         1.第一次发布。
--v0.02：20180718
         1.更新文档“功能测试说明.pdf”为v0.02，修改功能分计算规则和提交说明。
         2.其余文件未修改。
--v0.03：20180811
         1.更新文档“功能测试说明.pdf”为v0.03，修正发现的错别字、标点符号。
         2.更新SoC里的Confreg分配地址：从0x0xffff_0000~0xffff_ffff更新至0xbfaf_0000~0xbfaf_ffff。
         3.更新SoC里的Testbench：不再使用negedge clk来比对Trace，更新检测finish的情况。
         4.更新Soft：更新n75取指地址错例外测试，使其测试更全面；
                     更新disable trace机制，使更健壮；
                     更新start.S，0xbfc00100处增加向模拟串口写入0xff表示结束运行。
         5.以上更新，允许myCPU不使用Trace对比机制，将myCPU顶层的debug_wb_rf_wen恒接零即可关闭testbecnh里的Trace比对；
                     允许myCPU顶层的debug_wb_pc恒接零，仿真时依然可以正确finish。
         
目录结构：
   +--cpu132_gettrace/   : gs132生成golden_trace的环境，架构为SoC_SRAM_Lite，默认已生产golden_trace.txt
   |        
   |--soc_axi_func/      : AXI接口的CPU运行环境，架构为SoC_AXI_Lite
   |        
   |--soc_sram_func/     : SRAM接口的CPU运行环境，架构为SoC_SRAM_Lite
   |        
   |--soft/              : 89个功能点测试程序和记忆游戏测试程序，默认已包含编译好的结果
   |        
   |--功能测试说明.pdf   : 功能测试说明文档
   |        
   |--Readme_First.txt   : 本文档