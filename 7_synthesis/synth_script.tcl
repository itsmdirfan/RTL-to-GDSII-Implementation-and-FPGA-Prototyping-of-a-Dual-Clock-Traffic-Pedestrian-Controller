#!/usr/bin/tclsh
# ====================== Library Setup ======================
set_attribute init_lib_search_path /home/vlsi12/Downloads/scl_pdk/stdlib/fs120/liberty/lib_flow_ss
set_attribute library tsl18fs120_scl_ss.lib
set_attribute init_hdl_search_path /home/vlsi12/Desktop/EC1062/irfan_tra_ped_ctrl/1_src
set_attribute information_level 6

# ====================== Design Variables ======================
set myfiles "top.v traffic_fsm.v pedestrian_fsm.v sync.v"
set basename "top"
set runname "synth_report"

# ====================== Read & Elaborate Design ======================
read_hdl -sv $myfiles
elaborate $basename

# ====================== CLOCK CONSTRAINTS ======================
# Define both clocks (periods in ps)
define_clock -name clk_main -period 5000 [get_ports clk_main]
define_clock -name clk_ped  -period 10000 [get_ports clk_ped]

# Optional transition (slew)
set_clock_transition 0.1 [get_clocks clk_main]
set_clock_transition 0.1 [get_clocks clk_ped]

# ====================== IO DELAYS ======================
# Input delay (except clocks and resets)
set_input_delay 1 -clock clk_main [remove_from_collection [all_inputs] [list [get_ports clk_main] [get_ports clk_ped] [get_ports rst_main_n] [get_ports rst_ped_n]]]

# Output delay
set_output_delay 1 -clock clk_main [all_outputs]

# ====================== Synthesis Effort ======================
set_attribute syn_generic_effort high
set_attribute syn_map_effort high
set_attribute syn_opt_effort high

# ====================== Pre-Synthesis Checks ======================
check_design -unresolved
report timing -lint

# ====================== Synthesis Flow ======================
syn_gen
syn_map
syn_opt

# ====================== OUTPUT FILES ======================
write_hdl -mapped > ${basename}_netlist.v
write_sdc > ${basename}.sdc
write_sdf > ${basename}.sdf

# ====================== REPORTS ======================
report_timing > ${runname}_timing.rpt
report_gates > ${runname}_area.rpt
report_power > ${runname}_power.rpt
report_clock > ${runname}_clock.rpt

puts "Synthesis completed successfully."

