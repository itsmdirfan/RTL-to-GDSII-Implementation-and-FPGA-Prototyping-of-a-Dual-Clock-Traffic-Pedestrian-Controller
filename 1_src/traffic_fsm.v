`timescale 1ns / 1ps

module traffic_fsm (clk_main, rst_main_n, hold_red, traffic_light);

    input clk_main;
    input rst_main_n;
    input hold_red;
    output reg [1:0] traffic_light; // 00=Green, 01=Yellow, 10=Red

    reg [1:0] next_state;

    // state register (holds current traffic_light)
    always @(posedge clk_main or negedge rst_main_n) begin
        if (!rst_main_n)
            traffic_light <= 2'b00; // start at Green
        else
            traffic_light <= next_state;
    end

    // next state logic (simple cycle, hold_red forces RED)
    always @(*) begin
        if (hold_red == 1'b1)
            next_state = 2'b10; // RED
        else begin
            case (traffic_light)
                2'b00: next_state = 2'b01; // Green -> Yellow
                2'b01: next_state = 2'b10; // Yellow -> Red
                2'b10: next_state = 2'b00; // Red -> Green
                default: next_state = 2'b00;
            endcase
        end
    end

endmodule
