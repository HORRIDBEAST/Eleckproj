`timescale 1ns / 1ps
module Behavioural_Async_Reset_tb;
    reg d, en, rst;
    wire q;
    
    // Instantiate the D Latch module with async reset
    Behavioural_Async_Reset uut (.q(q), .d(d), .en(en), .rst(rst));
    
    initial begin
        $dumpfile("Behavioural_Async_Reset.vcd");
        $dumpvars(0, Behavioural_Async_Reset_tb);
        
        $monitor("Time=%0t | d=%b, en=%b, rst=%b -> q=%b", $time, d, en, rst, q);
        
        // Test cases
        #0  d = 0; en = 0; rst = 0; // Initial state
        #10 d = 1; en = 0; rst = 0; // Latch should hold previous value (undefined initially)
        #10 d = 1; en = 1; rst = 0; // Q should update to 1
        #10 d = 0; en = 1; rst = 0; // Q should update to 0
        #10 d = 1; en = 1; rst = 0; // Q should update to 1
        #10 d = 0; en = 0; rst = 0; // Q should hold previous value (1)
        #10 d = 1; en = 0; rst = 1; // Reset active, Q should be 0
        #10 d = 0; en = 1; rst = 1; // Reset active, Q should remain 0
        #10 d = 1; en = 1; rst = 0; // Q should update to 1
        #10 d = 0; en = 0; rst = 0; // Q should hold previous value (1)
        
        #10 $finish;
    end
endmodule
