`timescale 1ns / 1ps
module Behavioural_tb;
    reg d, en;
    wire q;
    
    // Instantiate the D Latch module
    Behavioural uut (.q(q), .d(d), .en(en));
    
    initial begin
        $dumpfile("Behavioural.vcd");
        $dumpvars(0, Behavioural_tb);
        
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
