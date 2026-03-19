`timescale 1ns / 1ps

module SR_LR_tb;
    reg clk, rst, SI;
    wire SO;

    // Instantiate the Shift Register module
    SR_LR uut (.SO(SO), .clk(clk), .rst(rst), .SI(SI));

    // Clock generation (10ns period -> 5ns high, 5ns low)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("SR_LR.vcd");
        $dumpvars(0, SR_LR_tb);
        
        $monitor("Time=%0t | SI=%b, clk=%b, rst=%b -> SR[4]=%b (SO=%b)", 
                  $time, SI, clk, rst, SO, SO);

        // Initialize values
        clk = 0; SI = 0; rst = 0;

        // Apply Reset
        #10 rst = 1;  // Release reset, SR should now accept inputs
        
        // Load data into shift register
        #10 SI = 1;  // Insert 1
        #10 SI = 0;  // Insert 0
        #10 SI = 1;  // Insert 1
        #10 SI = 1;  // Insert 1
        #10 SI = 0;  // Insert 0
        #10 SI = 1;  // Insert 1
        
        // Apply Reset Again
        #10 rst = 0;  // Reset register
        #10 rst = 1;  // Release reset

        #50 $finish;  // End simulation
    end
endmodule
