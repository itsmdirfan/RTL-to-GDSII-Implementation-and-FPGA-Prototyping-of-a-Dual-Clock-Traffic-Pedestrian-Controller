`timescale 1ns / 1ps

module clock_gen(
    input clk_in,           // 100 MHz input from Basys 3
    input rst_n,            // Active-low reset
    output reg clk_main_div, // Divided clock for traffic FSM
    output reg clk_ped_div   // Divided clock for pedestrian FSM
    );

    // --- Clock division counters ---
    reg [26:0] main_counter; // for clk_main_div
    reg [26:0] ped_counter;  // for clk_ped_div

    // Division ratios (tunable)
    parameter MAIN_DIV = 27'd50_000_000; // ~1 Hz: 100MHz / 50M
    parameter PED_DIV  = 27'd100_000_000; // ~0.5 Hz: 100MHz / 100M

    // Main divided clock
    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            main_counter <= 0;
            clk_main_div <= 0;
        end else begin
            if (main_counter >= (MAIN_DIV-1)) begin
                main_counter <= 0;
                clk_main_div <= ~clk_main_div;
            end else
                main_counter <= main_counter + 1;
        end
    end

    // Pedestrian divided clock
    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            ped_counter <= 0;
            clk_ped_div <= 0;
        end else begin
            if (ped_counter >= (PED_DIV-1)) begin
                ped_counter <= 0;
                clk_ped_div <= ~clk_ped_div;
            end else
                ped_counter <= ped_counter + 1;
        end
    end

endmodule

