`timescale 1ns / 1ps

module dff_PE_ARH_tb;
    reg d, clk, rst;
    wire q;
    
    // Instantiate the D Flip-Flop module
    dff_PE_ARH uut (.q(q), .d(d), .clk(clk), .rst(rst));
    
    // Clock generation (10ns period -> 5ns high, 5ns low)
    always #5 clk = ~clk; 

    initial begin
        $dumpfile("dff_PE_ARH.vcd");
        $dumpvars(0, dff_PE_ARH_tb);
        
        $monitor("Time=%0t | d=%b, clk=%b, rst=%b -> q=%b", $time, d, clk, rst, q);
        
        // Initialize values
        clk = 0; d = 0; rst = 0;
        
        // Apply test cases
        #3  rst = 1;      // Reset asserted before clock edge
        #7  rst = 0;      // Release reset
        #10 d = 1;        // Apply d=1
        #10 d = 0;        // Apply d=0
        #10 rst = 1;      // Reset while d=0
        #5  rst = 0;      // Release reset
        #10 d = 1;        // Apply d=1
        #10 d = 0;        // Apply d=0
        #20 $finish;      // End simulation at 80ns
    end
endmodule
