`timescale 1ns / 1ps

module Reg_set_tb;
    reg CLK, RST;
    reg [7:0] D1, D2;
    wire [7:0] Q1, Q2;

    // Instantiate the Register module
    Reg_set uut (.Q1(Q1), .Q2(Q2), .D1(D1), .D2(D2), .CLK(CLK), .RST(RST));

    // Clock Generation (10ns period -> 5ns high, 5ns low)
    always #5 CLK = ~CLK;

    initial begin
        $dumpfile("Reg_set.vcd");
        $dumpvars(0, Reg_set_tb);

        $monitor("D1=%b, D2=%b, CLK=%b, RST=%b -> Q1=%b, Q2=%b", 
                  $time, D1, D2, CLK, RST, Q1, Q2);

        // Initialize values
        CLK = 0; D1 = 8'b01; D2 = 8'b00000000; RST = 1;

        // Apply Reset
        #10 RST = 1;  // Reset active (Q1, Q2 should be 0)
        #10 RST = 0;  // Release reset (Q1, Q2 should store data on next CLK)

        // Apply Inputs and Observe Outputs
        #10 D1 = 8'b10101010; D2 = 8'b01010101; // Load values
        #10 D1 = 8'b11110000; D2 = 8'b00001111; // Load new values
        
        // Apply Reset in Between
        #10 RST = 1;  // Assert Reset
        #10 RST = 0;  // Release Reset
        
        #10 D1 = 8'b11001100; D2 = 8'b00110011; // Load values after reset
        
        #50 $finish;  // End Simulation
    end
endmodule
