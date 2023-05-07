#include "bb_sysclock.h"


void system_clock(void)
{
	/*select HSI as system clock*/
	RCC_CR |= (1<<0);
	
	/*wait for HSI to be ready*/
	while(!(RCC_CR & 2));

	/*set AHB prescaler*/
	RCC_CFGR &= ~(1<<7);
	
	/*select which oscillator as System clock*/
	RCC_CFGR &= ~(1<<1 | 1<<0);
	
	/*check if selected system clock is correct*/
	while((RCC_CFGR & 12));
}