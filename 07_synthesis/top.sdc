# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Wed Oct 08 15:16:36 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design top

create_clock -name "clk_main" -period 5.0 -waveform {0.0 2.5} [get_ports clk_main]
create_clock -name "clk_ped" -period 10.0 -waveform {0.0 5.0} [get_ports clk_ped]
set_clock_transition 0.1 [get_clocks clk_main]
set_clock_transition 0.1 [get_clocks clk_ped]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk_main] -add_delay 1.0 [get_ports button]
set_output_delay -clock [get_clocks clk_main] -add_delay 1.0 [get_ports {traffic_light[1]}]
set_output_delay -clock [get_clocks clk_main] -add_delay 1.0 [get_ports {traffic_light[0]}]
set_output_delay -clock [get_clocks clk_main] -add_delay 1.0 [get_ports walk]
set_wire_load_mode "enclosed"
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb2]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb1]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb4]
