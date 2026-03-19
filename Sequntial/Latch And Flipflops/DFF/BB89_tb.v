`timescale 1ns / 1ps

module dff_PE_SRL_tb;
    reg d, clk, rst;
    wire q;
    
    // Instantiate the D Flip-Flop module
    dff_PE_SRL uut (.q(q), .d(d), .clk(clk), .rst(rst));
    
    // Clock generation (10ns period -> 5ns high, 5ns low)
    always #5 clk = ~clk; 

    initial begin
        $dumpfile("dff_PE_SRL.vcd");
        $dumpvars(0, dff_PE_SRL_tb);
        
        $monitor("Time=%0t | d=%b, clk=%b, rst=%b -> q=%b", $time, d, clk, rst, q);
        
        // Initialize values
        clk = 0; d = 0; rst = 1;  // Start with reset deactivated (since active LOW)

        // Test case 1: Normal operation without reset
        #10 d = 1;  // d=1, should latch on posedge clk
        #10 d = 0;  // d=0, should latch on posedge clk

        // Test case 2: Apply synchronous reset (rst = 0)
        #10 rst = 0;  // Reset asserted (should take effect on next posedge clk)
        #10 rst = 1;  // Release reset

        // Test case 3: Check normal operation after reset
        #10 d = 1;
        #10 d = 0;

        // Test case 4: Check reset in between operation
        #10 rst = 0; d = 1;  // Reset while d=1 (should reset on next clk posedge)
        #10 rst = 1; d = 0;  // Release reset

        // Test case 5: Check normal behavior again
        #10 d = 1;
        #10 d = 0;
        
        #50 $finish;  // End simulation
    end
endmodule
//