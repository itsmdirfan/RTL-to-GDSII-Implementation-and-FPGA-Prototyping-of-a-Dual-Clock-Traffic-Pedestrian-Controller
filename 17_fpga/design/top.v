`timescale 1ns / 1ps

module top (clk_main, rst_main_n, rst_ped_n, button, traffic_light, walk);

    input clk_main;
    //input clk_ped;
    input rst_main_n;
    input rst_ped_n;
    input button;               // button provided in ped domain (we assume connected to ped domain)
    output [1:0] traffic_light;
    output walk;
    
    wire clk_main_div;
    wire clk_ped_div;
    
    clock_gen U_CLK (
        .clk_in(clk_main),   // 100MHz FPGA input clock (Basys 3)
        .rst_n(rst_main_n), // active-low reset
        .clk_main_div(clk_main_div),
        .clk_ped_div(clk_ped_div)
    );

    // internal wires
    wire [1:0] traffic_light_wire;
    wire traffic_red;           // true when traffic_light is RED (in main domain)
    wire hold_red;              // hold signal to traffic_fsm (driven by main domain logic)

    // Ped <-> Main handshake signals (toggles)
    wire req_toggle_main_sync;  // request toggle synchronized into main domain
    wire ack_toggle_main_sync;  // ack toggle synchronized into main domain
    wire grant_toggle_ped_sync; // grant toggle synchronized into ped domain

    // signals crossing from ped to main: req_toggle and ack_toggle (generated in ped)
    wire req_toggle_ped;        // from ped_fsm (ped domain)
    wire ack_toggle_ped;        // from ped_fsm (ped domain)

    // grant toggle generated in main domain and sent to ped (will be synchronized)
    reg grant_toggle_main;      // toggled in main domain to grant walk
    reg prev_req_main;          // previous sampled req toggle in main domain
    reg prev_ack_main;          // previous sampled ack toggle in main domain
    reg pending_request;        // pending request in main domain
    reg granted;                // granted flag in main domain

    // instantiate traffic FSM (main domain)
    traffic_fsm U_TRAFFIC (
        .clk_main(clk_main_div),
        .rst_main_n(rst_main_n),
        .hold_red(hold_red),
        .traffic_light(traffic_light_wire)
    );

    assign traffic_light = traffic_light_wire;
    assign traffic_red = (traffic_light_wire == 2'b10);

    // Synchronize req_toggle_ped into main domain
    // req_toggle_ped is produced in ped domain (see ped_fsm), so sync into main domain
    sync U_sync_req_to_main (
        .clk(clk_main_div),
        .rst_n(rst_main_n),
        .async_in(req_toggle_ped),
        .sync_out(req_toggle_main_sync)
    );

    // Synchronize ack_toggle_ped into main domain
    sync U_sync_ack_to_main (
        .clk(clk_main_div),
        .rst_n(rst_main_n),
        .async_in(ack_toggle_ped),
        .sync_out(ack_toggle_main_sync)
    );

    //Synchronize grant_toggle_main into ped domain
    sync U_sync_grant_to_ped (
        .clk(clk_ped_div),
        .rst_n(rst_ped_n),
        .async_in(grant_toggle_main),
        .sync_out(grant_toggle_ped_sync)
    );

    // main-domain handshake & control logic (edge-detect req/ack, issue grant when red)
    always @(posedge clk_main_div or negedge rst_main_n) begin
        if (!rst_main_n) begin
            prev_req_main <= 1'b0;
            prev_ack_main <= 1'b0;
            pending_request <= 1'b0;
            grant_toggle_main <= 1'b0;
            granted <= 1'b0;
        end else begin
            // edge detect request toggle (req_toggle_main_sync != prev_req_main)
            if (req_toggle_main_sync != prev_req_main) begin
                pending_request <= 1'b1;
            end
            prev_req_main <= req_toggle_main_sync;

            // edge detect ack toggle: if ack arrived, clear pending/granted
            if (ack_toggle_main_sync != prev_ack_main) begin
                // ack from ped: clear pending and granted
                pending_request <= 1'b0;
                granted <= 1'b0;
            end
            prev_ack_main <= ack_toggle_main_sync;

            // if traffic is RED and there is a pending request and haven't granted already,
            // issue grant by toggling grant_toggle_main and set granted flag.
            if ((traffic_light_wire == 2'b10) && (pending_request == 1'b1) && (granted == 1'b0)) begin
                grant_toggle_main <= ~grant_toggle_main; // issue grant
                granted <= 1'b1;
            end
        end
    end

    // hold_red should be asserted whenever granted==1 (main has granted walk), so traffic stays RED.
    // Also, keep hold_red high if traffic_light is already being forced to RED (we simply use granted)
    assign hold_red = granted;

    // instantiate pedestrian_fsm in ped domain
    pedestrian_fsm U_PED (
        .clk_ped(clk_ped_div),
        .rst_ped_n(rst_ped_n),
        .button(button),                 // button in ped domain
        .grant_sync(grant_toggle_ped_sync), // grant toggle synchronized into ped
        .req_toggle_out(req_toggle_ped), // toggle out -> will be synced to main
        .ack_toggle_out(ack_toggle_ped), // ack toggle out -> will be synced to main
        .walk(walk)
    );
    
endmodule
