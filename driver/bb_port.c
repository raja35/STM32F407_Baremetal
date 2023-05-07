

#include "bb_port.h"




void port_clkcfg(void)
{
	/*turn on porta clock*/
	RCC_AHB1ENR |= (1<<0);
}


void port_config(void)
{
	/*set porta pin6 mode output*/
	GPIOA_MODER &= ~(1<<13);
	GPIOA_MODER |= (1<<12);
}
 
void toggle_pin(void)
{
	GPIOA_ODR ^= (1<<6);
}