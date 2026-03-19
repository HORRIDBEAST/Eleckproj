`timescale 1ns / 1ps
module Behavioural_tb;
    reg [7:0] In;
    reg [2:0] n;
    reg L;
    wire [7:0] Out;

    // Instantiate the Behavioural module
    Behavioural uut (.In(In), .n(n), .L(L), .Out(Out));

        $dumpfile("Behavioural.vcd");
        $dumpvars(0, Behavioural_tb);
        
        $monitor("L=%b, In=%b, n=%d -> Out=%b", L, In, n, Out);

        #0  L = 1; In = 8'b00011011; n = 3'b001; // Left shift by 1  -> Expected: 00110110
        #10 L = 1; In = 8'b10000001; n = 3'b010; // Left shift by 2  -> Expected: 00000100
        #10 L = 0; In = 8'b10101010; n = 3'b011; // Right shift by 3 -> Expected: 00010101
        #10 L = 0; In = 8'b11000011; n = 3'b001; // Right shift by 1 -> Expected: 01100001
        #10 L = 1; In = 8'b01100110; n = 3'b100; // Left shift by 4  -> Expected: 01100000
        #10 L = 0; In = 8'b11110000; n = 3'b010; // Right shift by 2 -> Expected: 00111100
        #10 $finish;
    end
endmodule
