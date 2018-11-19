//soc confreg
#define CONFREG_NULL            0xbfaf8ffc

#define CONFREG_CR0             0xbfaf8000
#define CONFREG_CR1             0xbfaf8004
#define CONFREG_CR2             0xbfaf8008
#define CONFREG_CR3             0xbfaf800c
#define CONFREG_CR4             0xbfaf8010
#define CONFREG_CR5             0xbfaf8014
#define CONFREG_CR6             0xbfaf8018
#define CONFREG_CR7             0xbfaf801c

#define UART_ADDR               0xbfaffff0
#define SIMU_FLAG_ADDR          0xbfaffff4
#define OPEN_TRACE_ADDR         0xbfaffff8
#define NUM_MONITOR_ADDR        0xbfaffffc
#define LED_ADDR                0xbfaff000
#define LED_RG0_ADDR            0xbfaff004
#define LED_RG1_ADDR            0xbfaff008
#define NUM_ADDR                0xbfaff010
#define SWITCH_ADDR             0xbfaff020
#define BTN_KEY_ADDR            0xbfaff024
#define BTN_STEP_ADDR           0xbfaff028
#define TIMER_ADDR              0xbfafe000

#define SOC_LED            (* (volatile unsigned *)  LED_ADDR      )
#define SOC_LED_RG0        (* (volatile unsigned *)  LED_RG0_ADDR  )
#define SOC_LED_RG1        (* (volatile unsigned *)  LED_RG1_ADDR  )
#define SOC_NUM            (* (volatile unsigned *)  NUM_ADDR      )
#define SOC_SWITCHE        (* (volatile unsigned *)  SWITCH_ADDR   )
#define SOC_BTN_KEY        (* (volatile unsigned *)  BTN_KEY_ADDR  )
#define SOC_BTN_STEP       (* (volatile unsigned *)  BTN_STEP_ADDR )
#define SOC_TIMER          (* (volatile unsigned *)  TIMER_ADDR    )
//#define disable_trace_cmp  *((volatile int *)OPEN_TRACE_ADDR) = 0; \
//                           *((volatile int *)CONFREG_NULL   ) = 0; \
//                           *((volatile int *)CONFREG_NULL   ) = 0
//#define enable_trace_cmp   *((volatile int *)OPEN_TRACE_ADDR) = 1; \
//                           *((volatile int *)CONFREG_NULL   ) = 0; \
                           *((volatile int *)CONFREG_NULL   ) = 0
#define trace_cmp_flag     (*((volatile int *)OPEN_TRACE_ADDR))
#define disable_trace_cmp  asm volatile( \
                               ".set noreorder;" \
                               "lui $25,0xbfb0\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "sw $0,-0x8($25)\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "lw $0,-0x7004($25)\n\t" \
                               "lw $25,-0x8($25)\n\t" \
                               ".set reorder" \
                               :::"$25" \
                               )
#define disable_trace_cmp_s    .set noreorder;  \
                               lui k1,0xbfb0;  \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x8(k1); \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x7004(k1); \
                               lw $0,-0x7004(k1); \
                               lw k1,-0x8(k1); \
                               .set reorder; \

#define disable_num_monitor_s  .set noreorder;  \
                               lui k1,0xbfb0;  \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x4(k1); \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x7004(k1); \
                               lw $0,-0x7004(k1); \
                               lw k1,-0x4(k1); \
                               .set reorder; \

#define enable_trace_cmp  asm volatile( \
                               ".set noreorder;" \
                               "lui $25,0xbfb0\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "sw $25,-8($25)\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "sw $0,-0x7004($25)\n\t" \
                               "lw $0,-0x7004($25)\n\t" \
                               "lw $25,-0x8($25)\n\t" \
                               ".set reorder" \
                               :::"$25" \
                               )

#define enable_trace_cmp_s     .set noreorder; \
                               lui k1,0xbfb0; \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x7004(k1); \
                               sw k1,-8(k1); \
                               sw $0,-0x7004(k1); \
                               sw $0,-0x7004(k1); \
                               lw $0,-0x7004(k1); \
                               lw k1,-0x8(k1); \
                               .set reorder; \
                               
#define write_confreg_cr(num,data) *((volatile int *)(CONFREG_CR0+4*num)) = data
#define read_confreg_cr(num,data) data=*((volatile int *)(CONFREG_CR0+4*num))
#define NOP  addu zero, zero, zero
#define LI(reg, imm) \
    li reg, imm
