set_property PACKAGE_PIN V17 [get_ports rst_main_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_main_n]

set_property PACKAGE_PIN V16 [get_ports rst_ped_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_ped_n]

set_property PACKAGE_PIN W5 [get_ports clk_main]
set_property IOSTANDARD LVCMOS33 [get_ports clk_main]
create_clock -add -name sys_clk_pin -period 10.00 [get_ports clk_main]

set_property PACKAGE_PIN U16 [get_ports {traffic_light[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {traffic_light[0]}]

set_property PACKAGE_PIN U19 [get_ports {traffic_light[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {traffic_light[1]}]

set_property PACKAGE_PIN U14 [get_ports walk]
set_property IOSTANDARD LVCMOS33 [get_ports walk]

set_property PACKAGE_PIN V15 [get_ports button]
set_property IOSTANDARD LVCMOS33 [get_ports button]

