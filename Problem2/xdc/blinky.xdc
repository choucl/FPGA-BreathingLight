create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports clk]
create_generated_clock -name clk_div -divide_by 256 -source [get_ports clk] [get_pins design_1_i/mixer_0/clk_div_o];
create_generated_clock -name clk_fsm -divide_by 976562.5 -source [get_ports design_1_i/breather_0/clk_div_i] [get_pins design_1_i/breather_0/clk_div_o];
