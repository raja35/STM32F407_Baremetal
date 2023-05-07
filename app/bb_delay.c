
#include <stdint.h>
#include "bb_delay.h"


void Delay(uint32_t timeVar)
{
	uint32_t i = 0;
	for(i=0; i<timeVar*1000; i++);
}