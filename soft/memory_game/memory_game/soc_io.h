#define LED_ADDR                0xbfd0f000
#define LED_RG0_ADDR            0xbfd0f004
#define LED_RG1_ADDR            0xbfd0f008
#define NUM_ADDR                0xbfd0f010
#define SWITCH_ADDR             0xbfd0f020
#define BTN_KEY_ADDR            0xbfd0f024
#define BTN_STEP_ADDR           0xbfd0f028

#define SOC_LED            (* (volatile unsigned *)  LED_ADDR      )
#define SOC_LED_RG0        (* (volatile unsigned *)  LED_RG0_ADDR  )
#define SOC_LED_RG1        (* (volatile unsigned *)  LED_RG1_ADDR  )
#define SOC_NUM            (* (volatile unsigned *)  NUM_ADDR      )
#define SOC_SWITCHE        (* (volatile unsigned *)  SWITCH_ADDR   )
#define SOC_BTN_KEY        (* (volatile unsigned *)  BTN_KEY_ADDR  )
#define SOC_BTN_STEP       (* (volatile unsigned *)  BTN_STEP_ADDR )
