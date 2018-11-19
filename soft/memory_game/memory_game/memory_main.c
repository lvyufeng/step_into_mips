/*
 * main.c for the MIPSfpga core running on the Nexys4 DDR
 * FPGA target board.
 *
 * Lab 04: Memory Game. 
 *
 * This program:
 * 1. Waits for the user to press any key (pushbutton).
 * 2. Creates some random LED flashes on the three right-most.
 * 3. Detects the user keypresses on the left, center, and right 
 *    pushbuttons (BTNL, BTNC, and BTNR).
 * 4. Computes the number of correct user entries and lights up that 
 *    number of LEDs.
 * 5. Repeats
 *
 * Note that "random" patterns can be hard-coded in if the student 
 * programmer doesn't yet know about the rand() library call.
 */

#include <cpu_cde.h>

#define NUMLIGHTS 8
#define LEFT 4
#define MIDDLE 2
#define RIGHT 1

void delay(int reps);
int  getUserPress();
void getUserRelease();
void generateRandomPattern(int *pattern);
void displayPattern(int *pattern);
void detectKeyPresses(int *keys);
void displayScore(int *pattern, int *keys);

int my_rand();
void my_srand(unsigned seed);
static unsigned long rand_next=1;
//------------------
// main()
//------------------
int memory_game() {
  int pattern[15];
  int keys[15];

  SOC_LED = 0xffff;
  my_srand(get_count());
  while (1) {
    getUserPress();
    generateRandomPattern(pattern);
    displayPattern(pattern);
    detectKeyPresses(keys);
    displayScore(pattern, keys);
  }
  return 0;
}


//delay (reps) ms
void delay(int reps) {
  volatile unsigned int i;

  SOC_TIMER = 0;
  while(get_us()<1000*reps)    //1ms*reps
    ;	// delay 
}

int getUserPress() {
  volatile int pb;
  int pb_tmp;
  int pb_0;
  int pb_1;
  int pb_2;
  int pb_3;

  do {
    pb = (SOC_BTN_KEY & 0x0000f000)>>12;
  } while (pb == 0);
  
  pb_tmp = pb;
  pb_0 = (pb_tmp >>3)&1;
  pb_1 = ((pb_tmp >>2)&1)<<1;
  pb_2 = ((pb_tmp >>1)&1)<<2;
  pb_3 = ((pb_tmp)&1)<<3;
  pb_tmp = pb_0 | pb_1 | pb_2 | pb_3;
  return pb_tmp;
}

void getUserRelease() {
  volatile int pb;

  do {
    pb = (SOC_BTN_KEY & 0xf000)>>12;
  } while (pb != 0);
}

void generateRandomPattern(int *pattern) {
  volatile int i, val;

  for (i = 0; i < NUMLIGHTS; i++) {
    val = my_rand() % 4;
    val = (1 << val);
    pattern[i] = val;
  }
}

void displayPattern(int *pattern) {
  volatile int i;

  SOC_LED = 0xffff;
  delay(1000);

  for (i = 0; i < NUMLIGHTS; i++) {
    SOC_LED = ~pattern[i];
    delay(800);
    SOC_LED = 0xffff;
    delay(400);
  }
  SOC_LED = 0xffff;
}

void detectKeyPresses(int *keys) {
  volatile int pb, i;
  volatile int numGuesses = 0;

  for (i=0; i < NUMLIGHTS; i++) {
    pb = getUserPress();
    keys[i] = pb;
    SOC_LED = ~pb; 
    delay(400);
    getUserRelease();
    SOC_LED = 0xffff; 
    numGuesses++;
    SOC_NUM = numGuesses<<24;
  }
  delay(1200);
}

void displayScore(int *pattern, int *keys) {
  volatile int i, score = 0;

  SOC_LED = 0;
  delay(500);
  SOC_LED = 0xffff;
  for (i=0; i < NUMLIGHTS; i++) {
    if (pattern[i] == keys[i])
      score++; 
  }
  SOC_NUM = SOC_NUM | score;
  SOC_LED_RG0 = 1;
  if(score==NUMLIGHTS){
      SOC_LED_RG1 = 1;
  }
  else{
      SOC_LED_RG1 = 2;
  }
  
}

int my_rand(void){
    rand_next = rand_next*1103515245 + 12345;
    return ((unsigned)(rand_next/65536)%32768);
}

void my_srand(unsigned seed){
    rand_next = seed;
}
