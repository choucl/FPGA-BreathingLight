create_clock -period 2048.000 -name clk_div -waveform {0.000 1024.000} -add [get_ports clk_div_i]
create_generated_clock -name clk_fsm -divide_by 976562.5 -source [get_ports clk_div_i] [get_pins clk_div_o_reg/Q];
