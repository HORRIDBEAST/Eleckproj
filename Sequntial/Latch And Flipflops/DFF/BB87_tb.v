`timescale 1ns / 1ps

module dff_PE_ARL_AHS_tb;
    reg d, clk, rst, set;
    wire q;
    
    // Instantiate the D Flip-Flop module
    dff_PE_ARL_AHS uut (.q(q), .d(d), .clk(clk), .rst(rst), .set(set));
    
    // Clock generation (10ns period -> 5ns high, 5ns low)
    always #5 clk = ~clk; 

    initial begin
        $dumpfile("dff_PE_ARL_AHS.vcd");
        $dumpvars(0, dff_PE_ARL_AHS_tb);
        
        $monitor("Time=%0t | d=%b, clk=%b, rst=%b, set=%b -> q=%b", $time, d, clk, rst, set, q);
        
        // Initialize values
        clk = 0; d = 0; rst = 1; set = 0;  // Start with reset deactivated

        // Test case 1: Apply active low reset
        #3  rst = 0;      // Assert reset (q should become 0)
        #7  rst = 1;      // Release reset

        // Test case 2: Normal flip-flop operation
        #10 d = 1;        // Apply d=1
        #10 d = 0;        // Apply d=0

        // Test case 3: Apply asynchronous set
        #10 set = 1;      // Set q=1 immediately
        #5  set = 0;      // Release set
        
        // Test case 4: Check normal operation after set
        #10 d = 1;
        #10 d = 0;

        // Test case 5: Apply reset while set is high (reset has priority)
        #10 rst = 0; set = 1;  // Reset should override set, q=0
        #5  rst = 1; set = 0;  // Release both

        // Test case 6: Check normal operation again
        #10 d = 1;
        #10 d = 0;
        
        #50 $finish;      // End simulation
    end
endmodule
