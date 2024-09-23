# STM32F407_Baremetal
Bare metal drivers for stm32f407 microcontroller.

--Hardware Used --
1. Board - STM32f407 Black Board
2. Debugger - ST-Link/V2

--Software Used --
1. Text Editor - Notepad++
2. Binary Loader - STM32CubeProgrammer
3. Make for windows - https://gnuwin32.sourceforge.net/downlinks/make.php
4. Arm Gcc cross compiler - https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-mingw-w64-i686-arm-none-eabi.exe

--Folder structure --
1. app -> folder contains application codes.
2. driver -> contains diffrent driver related codes.
3. build -> all generated outpul files resides here.(for now please create this folder manually)

--Build Process --
1. open cmd inside project folder.
2. type make all to build project.
3. type make clean to clean generated binaries.
