create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports clk_i]
create_generated_clock -name clk_div -divide_by 256 -source [get_ports clk_i] [get_pins clk_div_o_reg/Q] 
