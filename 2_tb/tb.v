`timescale 1ns / 1ps

module tb;

    reg clk_main;
    reg clk_ped;
    reg rst_main_n;
    reg rst_ped_n;
    reg button;
    wire [1:0] traffic_light;
    wire walk;

    top DUT (
        .clk_main(clk_main),
        .clk_ped(clk_ped),
        .rst_main_n(rst_main_n),
        .rst_ped_n(rst_ped_n),
        .button(button),
        .traffic_light(traffic_light),
        .walk(walk)
    );

    // Main clock (10 ns)
    initial begin
        clk_main = 0;
        forever #5 clk_main = ~clk_main;
    end
    
    always begin
    
        clk_ped = 0; #7;
        clk_ped = 1; #3;
    
    end

    initial begin
        // initialize
        rst_main_n = 0;
        rst_ped_n  = 0;
        button = 0;
        #30;
        rst_main_n = 1;
        rst_ped_n  = 1;

        // Wait a few main cycles to let traffic cycle to RED eventually
        #200;

        // CASE 1: press button while traffic not RED yet (request will be registered and granted when RED appears)
        button = 1; #10; button = 0;

        // Wait to observe handshake and walk
        #200;

        // CASE 2: press button while traffic already RED (immediate grant should occur quickly)
        // Wait until next RED and press there
        button = 1; #10; button = 0;

        #200;
        
    
                button = 1; #10; button = 0;
        
                #200;
        
                        button = 1; #10; button = 0;
                
                        #200;

        $stop;
    end

endmodule
