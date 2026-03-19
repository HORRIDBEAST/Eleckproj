`timescale 1ns / 1ps
module Dataflow_2_tb;
    reg [3:0] a, b;
    wire gt, eq, sm;

    Dataflow_2 uut (.a(a), .b(b), .gt(gt), .eq(eq), .sm(sm));

    initial begin
        $dumpfile("Dataflow_2_tb.vcd");
        $dumpvars(0, Dataflow_2_tb);
        
        $monitor("a=%b, b=%b -> gt=%b, eq=%b, sm=%b", a, b, gt, eq, sm);

        #0  a = 4'b0000; b = 4'b0000; // Expected: eq=1, gt=0, sm=0
        #10 a = 4'b0100; b = 4'b0011; // Expected: eq=0, gt=1, sm=0
        #10 a = 4'b1001; b = 4'b1010; // Expected: eq=0, gt=0, sm=1
        #10 a = 4'b1111; b = 4'b0111; // Expected: eq=0, gt=1, sm=0
        #10 a = 4'b0110; b = 4'b0110; // Expected: eq=1, gt=0, sm=0
        #10 a = 4'b0011; b = 4'b0111; // Expected: eq=0, gt=0, sm=1
        #10 $finish;
    end
endmodule
