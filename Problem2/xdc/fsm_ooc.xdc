create_clock -period 2000000000.000 -name clk_fsm -waveform {0.000 1000000000.000} -add [get_ports clk_div_i]
