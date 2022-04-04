# FPGA-BreathingLight

> 2022 Spring NCKU FPGA Course
>
> Homework 2
>
> E24076239 E24076297 E24076750

## Problem 1: Breathing Light

### Introduction

This project uses **PYNQ-Z2** to implement an RGB breathing light circuit.

### Specification

| Switch | RGB LED 4 | RGB LED 5               | Hex Triplet(RGB) |
| ------ | --------- | ----------------------- | ---------------- |
| 00     | Purple    | Purple Breathing Light  | #7F1FFF          |
| 01     | Cyan      | Cyan Breathing Light    | #00FFFF          |
| 10     | Yellow    | Yellow Breathing Light  | #FFFF00          |
| 11     | Crimson   | Crimson Breathing Light | #FF00FF          |

A **reset** signal is required between mode switches.

### Modules

1. **mixer**

   The mixer generates a divided clock and the **PWM** signal of output color.

   The output color of LEDs is indicated by input port `color_i[2:0]`, in problem 1, it is connected to the **switch**. In `def.v` , we give each four colors in problem 1 a unique code, ranging from 1 to 4, to meet the specification of switch input. Even though there are only four colors in problem 1, we use 3 bits to represent the color code to make the module **reusable for problem 2**.

   Taking an output color with a hexadecimal color code (7F1FFF) as an example, every 256 input clock cycles, the red, green, and blue pins of the LED are pulled high for 127, 31, and 255 cycles, respectively. The same method is used for other output colors.

   The frequency of the divided clock signal is 256 times less than the input clock, which is also the life cycle of the RGB PWM signal.

2. **breather**

   Separating the life cycle of breathing light into 32 phases, each phase has a brightness level(`brightness`).

   The input clock of breather(`clk_div_i`) is the output divided clock of mixer. A counter(`brightness_cnt`) is accumulated at each positive edge of `clk_div_i`, while `brightness_cnt` is larger than or equal to `brightness`, the LED(`rgb4_o[2:0]`) will be turned on. 
   
   By increasing and decreasing `brightness` between phases, we can make the output LED color(`rgb4_o[2:0]`) getting lighter and dimer.
   
   The output signal `clk_div_o` is not used in problem 1.

### Schematic

<img src="images/problem1.png" alt="p1" style="zoom:80%;" />

## Problem 2: Rainbow Breathing Light

### Introduction

This project uses **PYNQ-Z2** to implement an RGB rainbow breathing light circuit.

### Specification

#### Order

Dark&rarr;**Red**&rarr;Dark&rarr;**Orange**&rarr;Dark&rarr;**Yellow**&rarr;Dark&rarr;**Green**&rarr;Dark&rarr;**Blue**&rarr;Dark&rarr;**Purple**&rarr;Dark&rarr;**Red**...

#### Color

| Color           | Red     | Orange  | Yellow  | Green   | Blue    | Purple  |
| --------------- | ------- | ------- | ------- | ------- | ------- | ------- |
| **Hex triplet** | #FF0000 | #FF6100 | #FFFF00 | #00FF00 | #0000FF | #7F1FFF |

### Modules

1. **fsm**

   A finite state machine for the transitions of rainbow colors.

   The output port `color_o[2:0]` outputs the code of LED color which controls the output color of rainbow breathing light.

2. **mixer**

   Reusing the module in problem 1.

   In problem 2, the input port `color_i[2:0]` is connected to the output port of fsm(`color_o[2:0]`)  instead of the switch in problem 1. 

   The codes and PWM values of rainbow colors are also defined in `def.v`.

3. **breather**

   Reusing the module in problem 1.
   
   `clk_div_o` is now connected to the input of fsm(`clk_div_i`), indicating that the fsm module has completed a breath for the current LED color, and it can output the next color code.

### Schematic

<img src="images/problem2.png" alt="p2" style="zoom:80%;" />
