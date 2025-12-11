`timescale 1ns / 1ps

module pedestrian_fsm (clk_ped, rst_ped_n, button, grant_sync, req_toggle_out, ack_toggle_out, walk);

    input clk_ped;
    input rst_ped_n;
    input button;           // input button in ped domain
    input grant_sync;       // grant toggle synced into ped domain (from main)
    output reg req_toggle_out; // toggle to request, fed to main (will be sync'd there)
    output reg ack_toggle_out; // toggle to acknowledge grant, fed to main (will be sync'd there)
    output reg walk;        // 1-cycle walk pulse in ped domain

    reg btn_ff;             // for edge detect of button
    reg prev_grant;         // for edge detect of grant_sync

    // initialize registers
    always @(posedge clk_ped or negedge rst_ped_n) begin
        if (!rst_ped_n) begin
            btn_ff <= 1'b0;
            req_toggle_out <= 1'b0;
            ack_toggle_out <= 1'b0;
            prev_grant <= 1'b0;
            walk <= 1'b0;
        end else begin
            // detect rising edge of button -> toggle req_toggle_out
            if (button && !btn_ff) begin
                req_toggle_out <= ~req_toggle_out;
            end
            btn_ff <= button;

            // detect change (edge) in grant_sync -> produce walk for 1 ped cycle and toggle ack
            walk <= 1'b0; // default off
            if (grant_sync != prev_grant) begin
                // grant received -> produce one-cycle walk and send ack toggle
                walk <= 1'b1;
                ack_toggle_out <= ~ack_toggle_out;
            end
            prev_grant <= grant_sync;
        end
    end

endmodule
