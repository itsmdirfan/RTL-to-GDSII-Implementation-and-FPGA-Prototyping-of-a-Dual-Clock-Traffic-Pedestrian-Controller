
//input ports
add mapped point clk_main clk_main -type PI PI
add mapped point clk_ped clk_ped -type PI PI
add mapped point rst_main_n rst_main_n -type PI PI
add mapped point rst_ped_n rst_ped_n -type PI PI
add mapped point button button -type PI PI

//output ports
add mapped point traffic_light[1] traffic_light[1] -type PO PO
add mapped point traffic_light[0] traffic_light[0] -type PO PO
add mapped point walk walk -type PO PO

//inout ports




//Sequential Pins
add mapped point pending_request/q pending_request_reg/Q -type DFF DFF
add mapped point granted/q granted_reg/Q -type DFF DFF
add mapped point U_PED/ack_toggle_out/q U_PED_ack_toggle_out_reg/Q -type DFF DFF
add mapped point U_PED/walk/q U_PED_walk_reg/Q -type DFF DFF
add mapped point grant_toggle_main/q grant_toggle_main_reg/Q -type DFF DFF
add mapped point U_PED/req_toggle_out/q U_PED_req_toggle_out_reg/Q -type DFF DFF
add mapped point prev_ack_main/q prev_ack_main_reg/QN -type DFF DFF
add mapped point prev_req_main/q prev_req_main_reg/Q -type DFF DFF
add mapped point U_TRAFFIC/traffic_light[1]/q U_TRAFFIC_traffic_light_reg[1]/Q -type DFF DFF
add mapped point U_TRAFFIC/traffic_light[0]/q U_TRAFFIC_traffic_light_reg[0]/Q -type DFF DFF
add mapped point U_sync_grant_to_ped/sync_out/q U_sync_grant_to_ped_sync_out_reg/QN -type DFF DFF
add mapped point U_sync_ack_to_main/sync_out/q U_sync_ack_to_main_sync_out_reg/QN -type DFF DFF
add mapped point U_sync_req_to_main/sync_out/q U_sync_req_to_main_sync_out_reg/QN -type DFF DFF
add mapped point U_sync_req_to_main/sync1/q U_sync_req_to_main_sync1_reg/Q -type DFF DFF
add mapped point U_PED/btn_ff/q U_PED_btn_ff_reg/QN -type DFF DFF
add mapped point U_sync_ack_to_main/sync1/q U_sync_ack_to_main_sync1_reg/Q -type DFF DFF
add mapped point U_sync_grant_to_ped/sync1/q U_sync_grant_to_ped_sync1_reg/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
