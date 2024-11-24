/*Syntax and CPU settings: Specifies the syntax to be unified, 
sets the target CPU to Cortex-M4, and enables Thumb mode instructions.*/
  .syntax unified
  .cpu cortex-m4
  .thumb

/*Global symbols: Declares g_pfnVectors and Default_Handler as global 
symbols, making them accessible from other files.*/
.global  g_pfnVectors
.global  Default_Handler

/*Section and type: Defines a new section .text.Reset_Handler with 
executable and allocated attributes, and declares Reset_Handler as a function.*/
  .section  .text.Reset_Handler,"ax",%progbits
  .type  Reset_Handler, %function

/*Reset Handler*/
Reset_Handler:
  /*Loads the stack pointer with the address of _estack.*/
  ldr   sp, =_estack     /* set stack pointer */

/*Initialize data segment: Loads the start and end addresses 
of the data segment and the source initialization data address 
into registers, then jumps to the loop LoopCopyDataInit. */  
  ldr r0, =_sdata
  ldr r1, =_edata
  ldr r2, =_sidata
  movs r3, #0
  b LoopCopyDataInit

/*Copy data: Loads a word from the source address in flash, 
stores it in the data segment in SRAM, and increments the offset.*/
CopyDataInit:
  ldr r4, [r2, r3]
  str r4, [r0, r3]
  adds r3, r3, #4

/*Loop to copy data: Compares the current address with the end 
address of the data segment, and if less, continues copying.*/
LoopCopyDataInit:
  adds r4, r0, r3
  cmp r4, r1
  bcc CopyDataInit
  
/* Initialize BSS segment: Loads the start and end addresses
 of the BSS segment into registers, sets a zero value in a register, 
 and jumps to the loop LoopFillZerobss. */
  ldr r2, =_sbss
  ldr r4, =_ebss
  movs r3, #0
  b LoopFillZerobss

/*Zero fill BSS: Stores zero at the current BSS address and increments 
the address.*/
FillZerobss:
  str  r3, [r2]
  adds r2, r2, #4

/*Loop to zero fill BSS: Compares the current address with the 
end address of the BSS segment, and if less, continues zero filling.*/
LoopFillZerobss:
  cmp r2, r4
  bcc FillZerobss
  
  /*Select system clock: Branches with link to system_clock to set up the system clock.*/
  bl  system_clock
  
  /*Turn on port A clock: Branches with link to port_clkcfg to enable the clock for port A.*/
  bl  port_clkcfg

  /*Call main fun: Branches with link to the main fun, then calculates the size of Reset_Handler.*/
  bl  main    
.size  Reset_Handler, .-Reset_Handler

/*Section and type: Defines a new section .text.Default_Handler with executable and 
allocated attributes, and declares Default_Handler as a function.*/
    .section  .text.Default_Handler,"ax",%progbits
	.type  Default_Handler, %function
	
/*Default Handler: Defines a default interrupt handler that enters an infinite 
loop and calculates the size of Default_Handler.*/
Default_Handler:
Infinite_Loop:
  b  Infinite_Loop
  .size  Default_Handler, .-Default_Handler

/*ISR vector section: Defines the interrupt vector table section 
with allocated attributes and declares g_pfnVectors as an object.*/
  .section  .isr_vector,"a",%progbits
  .type  g_pfnVectors, %object
    
/*Vector table: Defines the interrupt vector table with initial stack 
pointer and handlers of reset, NMI, HardFault, MemManage, BusFault, 
and UsageFault interrupts, then calculates its size.*/
g_pfnVectors:
  .word  _estack
  .word  Reset_Handler
  .word  NMI_Handler
  .word  HardFault_Handler
  .word  MemManage_Handler
  .word  BusFault_Handler
  .word  UsageFault_Handler
.size  g_pfnVectors, .-g_pfnVectors
  
/*Weak aliases: Declares weak aliases for various exception handlers, defaulting them to Default_Handler.*/
   .weak  Reset_Handler
	
   .weak      NMI_Handler
   .thumb_set NMI_Handler,Default_Handler
  
   .weak      HardFault_Handler
   .thumb_set HardFault_Handler,Default_Handler
  
   .weak      MemManage_Handler
   .thumb_set MemManage_Handler,Default_Handler
  
   .weak      BusFault_Handler
   .thumb_set BusFault_Handler,Default_Handler

   .weak      UsageFault_Handler
   .thumb_set UsageFault_Handler,Default_Handler

