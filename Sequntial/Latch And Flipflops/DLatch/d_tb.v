`timescale 1ns / 1ps
module Dataflow_tb;
    reg d, en;
    wire q;
    
    // Instantiate the D Latch module
    Dataflow uut (.q(q), .d(d), .en(en));
    
    initial begin
        $dumpfile("Dataflow.vcd");
        $dumpvars(0, Dataflow_tb);
        
        $monitor("Time=%0t | d=%b, en=%b -> q=%b", $time, d, en, q);
        
        // Test cases
        #0  d = 0; en = 0;
        #10 d = 1; en = 0;
        #10 d = 1; en = 1;
        #10 d = 0; en = 1;
        #10 d = 1; en = 1;
        #10 d = 0; en = 0;
        #10 d = 1; en = 0;
        #10 d = 0; en = 1;
        #10 d = 1; en = 1;
        #10 d = 0; en = 0;
        
        #10 $finish;
    end
endmodule
