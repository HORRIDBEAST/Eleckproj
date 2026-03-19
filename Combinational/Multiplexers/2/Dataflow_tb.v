`timescale 1ns/1ns

module Dataflow_tb;

    reg [1:0] I; // Corrected syntax for reg array
    reg S;
    wire Y;

    // Instantiate the DUT (Device Under Test)
    Dataflow uut (.I(I), .S(S), .Y(Y));

    initial begin
        $monitor("I=%b S=%b Y=%b", I, S, Y);

        #10 I = 2'b00; S = 1'b0;
        #10 I = 2'b01; S = 1'b0;
        #10 I = 2'b10; S = 1'b0;
        #10 I = 2'b11; S = 1'b0;
        #10 I = 2'b00; S = 1'b1;
        #10 I = 2'b01; S = 1'b1;
        #10 I = 2'b10; S = 1'b1;
        #10 I = 2'b11; S = 1'b1;

        $finish;
    end
endmodule
