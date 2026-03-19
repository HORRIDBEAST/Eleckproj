`timescale 1ns/1ns

module Behavioural_tb;

    reg [3:0] I;   // 4-bit input
    reg [1:0] S;   // 2-bit select line
    wire Y;        // Output wire

    // Instantiate the DUT (Device Under Test)
    Behavioural uut (.I(I), .S(S), .Y(Y));

    initial begin
        $monitor("Time=%0t | I=%b S=%b Y=%b", $time, I, S, Y);

        // Apply test cases
        #10 I = 4'b0000; S = 2'b00;
        #10 I = 4'b0001; S = 2'b01;
        #10 I = 4'b0010; S = 2'b10;
        #10 I = 4'b0011; S = 2'b11;
        #10 I = 4'b0100; S = 2'b00;
        #10 I = 4'b0101; S = 2'b01;
        #10 I = 4'b0110; S = 2'b10;
        #10 I = 4'b0111; S = 2'b11;
        #10 I = 4'b1000; S = 2'b00;
        #10 I = 4'b1001; S = 2'b01;
        #10 I = 4'b1010; S = 2'b10;
        #10 I = 4'b1011; S = 2'b11;
        #10 I = 4'b1100; S = 2'b00;
        #10 I = 4'b1101; S = 2'b01;
        #10 I = 4'b1110; S = 2'b10;
        #10 I = 4'b1111; S = 2'b11;

        $finish;
    end
endmodule
