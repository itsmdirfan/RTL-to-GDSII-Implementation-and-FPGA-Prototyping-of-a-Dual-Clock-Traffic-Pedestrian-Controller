`timescale 1ns / 1ps

module sync (clk, rst_n, async_in, sync_out);

    input clk;
    input rst_n;
    input async_in;
    output reg sync_out;

    reg sync1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sync1 <= 1'b0;
            sync_out <= 1'b0;
        end else begin
            sync1 <= async_in;
            sync_out <= sync1;
        end
    end

endmodule