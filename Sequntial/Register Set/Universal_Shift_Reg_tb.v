`timescale 1ns / 1ps

module USR_tb;
    reg clk, rst, SI;
    reg [1:0] sel;
    reg [4:0] PI;
    wire [4:0] PO;
    wire SO;

    // Instantiate the Universal Shift Register (USR)
    USR uut (.PO(PO), .SO(SO), .PI(PI), .sel(sel), .clk(clk), .rst(rst), .SI(SI));

    // Clock generation (10ns period -> 5ns high, 5ns low)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("USR_tb.vcd");
        $dumpvars(0, USR_tb);
        $monitor("Time=%0t | sel=%b, SI=%b, PI=%b | PO=%b, SO=%b", 
                 $time, sel, SI, PI, PO, SO);

        // Initialize signals
        clk = 0; rst = 0; SI = 0; sel = 2'b00; PI = 5'b10101;
        
        // Apply reset
        #5 rst = 1; 
        #5 rst = 0; // Reset deactivated
        
        // Test parallel load
        #10 sel = 2'b11; // Load PI into PO
        #10 sel = 2'b00; // Hold state (no change)
        
        // Test shift left
        #10 sel = 2'b01; SI = 1;
        #10 sel = 2'b01; SI = 0;
        
        // Test shift right
        #10 sel = 2'b10; SI = 1;
        #10 sel = 2'b10; SI = 0;
        
        // End simulation
        #20 $finish;
    end
endmodule
