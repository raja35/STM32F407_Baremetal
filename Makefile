
#Defines directory paths: Sets variables for build, application, driver, board support package (BSP), and RTOS directories.
BUILD_DIR = Build
APP_DIR = App
DRIVER_DIR = Driver
BSP_DIR = BSP
RTOS_DIR = xRtos

#Compiler and assembler settings:
#CC: Specifies the compiler.
#CPU: Sets the target CPU architecture.
#CFLAG: Defines flags for compiling C files.
#LDFLAGS: Defines flags for linking.

CC = arm-none-eabi-gcc
CPU = -mcpu=cortex-m4
CFLAG= -c $(CPU) -mthumb -std=gnu11 -Wall -O0 -g
LDFLAGS= -nostdlib -T bb_blink.ld -Wl,-Map=$(BUILD_DIR)/bb_blink.map

#Default target: Specifies the default make target, which is to build the bb_blink.elf executable.
all:$(BUILD_DIR)/bb_blink.elf

#Builds the ELF executable: Links object files to create the final executable bb_blink.elf.
$(BUILD_DIR)/bb_blink.elf:$(BUILD_DIR)/main.o $(BUILD_DIR)/bb_delay.o $(BUILD_DIR)/bb_sysclock.o $(BUILD_DIR)/bb_port.o $(BUILD_DIR)/stm32_startup.o
	$(CC) $(LDFLAGS) -o $@ $^

#Compiles main.c: Compiles main.c into main.o.
$(BUILD_DIR)/main.o:$(APP_DIR)/main.c
	$(CC) $(CFLAG) -o $@ $^
	
#Compiles bb_delay.c: Compiles bb_delay.c into bb_delay.o.
$(BUILD_DIR)/bb_delay.o:$(APP_DIR)/bb_delay.c
	$(CC) $(CFLAG) -o $@ $^
	
#Compiles bb_sysclock.c: Compiles bb_sysclock.c into bb_sysclock.o.
$(BUILD_DIR)/bb_sysclock.o:$(DRIVER_DIR)/bb_sysclock.c
	$(CC) $(CFLAG) -o $@ $^
	
#Compiles bb_port.c: Compiles bb_port.c into bb_port.o.
$(BUILD_DIR)/bb_port.o:$(DRIVER_DIR)/bb_port.c
	$(CC) $(CFLAG) -o $@ $^
	
#Compiles stm32_startup.s: Compiles stm32_startup.s into stm32_startup.o.
$(BUILD_DIR)/stm32_startup.o:stm32_startup.s
	$(CC) $(CFLAG) -o $@ $^
	
#Clean target: Deletes object files, executable, and map file from the build directory.
clean:
	del $(BUILD_DIR)\*.o $(BUILD_DIR)\*.elf $(BUILD_DIR)\*.map