
#include "main.h"
#include "bb_delay.h"



int main(void)
{
	/*select system clock*/
	system_clock();
	/*turn on porta clock*/
	port_clkcfg();
	/*set porta pin6 mode output*/
	port_config();
	/*blink logic*/
	while(1)
	{
		toggle_pin();
		Delay(1000);
	}		
}

