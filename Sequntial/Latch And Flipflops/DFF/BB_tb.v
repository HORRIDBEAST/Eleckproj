`timescale 1ns / 1ps

module Behavioural_Basic_tb;
    reg d, clk;
    wire q;
    
    // Instantiate the D Flip-Flop module
    Behavioural_Basic uut (.q(q), .d(d), .clk(clk));
    
    // Clock generation
    always #5 clk = ~clk; // Generate a clock with a period of 10ns

    initial begin
        $dumpfile("Behavioural_Basic.vcd");
        $dumpvars(0, Behavioural_Basic_tb);
        
        $monitor("Time=%0t | d=%b, clk=%b -> q=%b", $time, d, clk, q);
        
        // Initialize values
        clk = 0; d = 0;
        
        // Apply test cases
        #10 d = 1;  // Apply d=1, should update on next clock posedge
        #10 d = 0;  // Apply d=0, should update on next clock posedge
        #10 d = 1;  // Apply d=1, should update on next clock posedge
        #10 d = 0;  // Apply d=0, should update on next clock posedge
        #10 d = 1;  // Apply d=1, should update on next clock posedge
        
        #20 $finish; // End simulation
    end
endmodule
