/*Defines the entry point of the program: Specifies that the reset handler is the entry point of the application.*/
ENTRY(Reset_Handler)

/* Defines the end of the stack: Sets the stack pointer to the end of the SRAM. */
_estack = ORIGIN(SRAM) + LENGTH(SRAM);    /* end of RAM */

/*Defines memory regions: Specifies the memory regions and their properties:*/
MEMORY
{
	SRAM (xrw)      : ORIGIN = 0x20000000, LENGTH = 128K
	FLASH (rx)      : ORIGIN = 0x8000000, LENGTH = 512K
}

SECTIONS
{
	 /* The startup code goes first into FLASH */
	 /*.isr_vector section: Aligns the section to 4 bytes and ensures the 
	 startup code (interrupt vector) is kept in the flash memory.*/
	.isr_vector :
	  {
	  . = ALIGN(4);
	  KEEP(*(.isr_vector))
	  . = ALIGN(4);
	} >FLASH
	
	/*.text.Reset_Handler section: ALIGN(4): Aligns the section to a 4-byte boundary. 
	KEEP(*(.text.Reset_Handler)): Ensures that the Reset_Handler section is included 
	in the output file and is not removed by the linker even if it appears to be unused.
	The section is placed in the FLASH memory region.*/
	.text.Reset_Handler :
	  {
	  . = ALIGN(4);
	  KEEP(*(.text.Reset_Handler))
	  . = ALIGN(4);
	} >FLASH
	
	
	/*.text.Default_Handler section: ALIGN(4): Aligns the section to a 4-byte boundary. 
	KEEP(*(.text.Default_Handler)): Ensures that the Default_Handler section is included 
	in the output file and is not removed by the linker. The section is placed in the FLASH memory region.*/
	.text.Default_Handler :
	  {
	  . = ALIGN(4);
	  KEEP(*(.text.Default_Handler))
	  . = ALIGN(4);
	} >FLASH

	/*.text section: Aligns the section to 4 bytes, includes all the .text 
	and .rodata (read-only data) sections, and sets the _etext marker at the 
	end of the section. This section is placed in the flash memory.*/
	.text :
	{
	  . = ALIGN(4);
	  *(*.text)
	  *(.text*) 
	  *(.rodata)
	  . = ALIGN(4);
	  _etext = .;
	}> FLASH
	
	/*.data section: Aligns the section to 4 bytes, includes all the .data 
	sections, sets markers _sdata at the start and _edata at the end of the 
	section, and places it in SRAM, but loaded from flash.*/
	_sidata = LOADADDR(.data);
	.data :
	{
	  . = ALIGN(4);
	  _sdata = .;
	  *(.data)
	  . = ALIGN(4);
	  _edata = .;
	}> SRAM AT> FLASH
	
	/*.bss section: Aligns the section to 4 bytes, includes all the .bss 
	sections (uninitialized data), sets markers _sbss at the start and _ebss 
	at the end of the section, and places it in SRAM.*/
	.bss :
	{
	  . = ALIGN(4);
	  _sbss = .;
	  *(.bss)
	  . = ALIGN(4);
	  _ebss = .;
	}> SRAM
}