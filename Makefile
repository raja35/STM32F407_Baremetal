
BUILD_DIR = build

CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc -x assembler-with-cpp
CPU = -mcpu=cortex-m4
CFLAG= -c $(CPU) -mthumb -std=gnu11 -Wall -O0
LDFLAGS= -nostdlib -T bb_blink.ld -Wl,-Map=$(BUILD_DIR)/bb_blink.map

all:$(BUILD_DIR)/bb_blink.elf

$(BUILD_DIR)/main.o:app/main.c
	$(CC) $(CFLAG) -o $@ $^
	
$(BUILD_DIR)/bb_delay.o:app/bb_delay.c
	$(CC) $(CFLAG) -o $@ $^
	
$(BUILD_DIR)/bb_sysclock.o:driver/bb_sysclock.c
	$(CC) $(CFLAG) -o $@ $^
	
$(BUILD_DIR)/bb_port.o:driver/bb_port.c
	$(CC) $(CFLAG) -o $@ $^
	
$(BUILD_DIR)/stm32_startup.o:stm32_startup.s
	$(CC) $(CFLAG) -o $@ $^
	
$(BUILD_DIR)/bb_blink.elf:$(BUILD_DIR)/main.o $(BUILD_DIR)/bb_delay.o $(BUILD_DIR)/bb_sysclock.o $(BUILD_DIR)/bb_port.o $(BUILD_DIR)/stm32_startup.o
	$(CC) $(LDFLAGS) -o $@ $^
	
clean:
	del $(BUILD_DIR)\*.o $(BUILD_DIR)\*.elf $(BUILD_DIR)\*.map