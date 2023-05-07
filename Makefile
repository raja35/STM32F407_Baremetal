CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc -x assembler-with-cpp
CPU = -mcpu=cortex-m4
CFLAG= -c $(CPU) -mthumb -std=gnu11 -Wall -O0
LDFLAGS= -nostdlib -T bb_blink.ld -Wl,-Map=bb_blink.map

all:bb_blink.elf

main.o:main.c
	$(CC) $(CFLAG) -o $@ $^
	
bb_sysclock.o:bb_sysclock.c
	$(CC) $(CFLAG) -o $@ $^
	
bb_port.o:bb_port.c
	$(CC) $(CFLAG) -o $@ $^
	
bb_delay.o:bb_delay.c
	$(CC) $(CFLAG) -o $@ $^
	
stm32_startup.o:stm32_startup.s
	$(CC) $(CFLAG) -o $@ $^
	
bb_blink.elf:main.o bb_sysclock.o bb_port.o bb_delay.o stm32_startup.o
	$(CC) $(LDFLAGS) -o $@ $^
	
clean:
	del *.o *.elf *.map