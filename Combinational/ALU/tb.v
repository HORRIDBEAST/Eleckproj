`timescale 1ns / 1ps
module ALU_4bit_tb;
    reg [3:0] a, b, op;
    wire [3:0] x, y;

    // Instantiate ALU
    ALU_4bit uut (.a(a), .b(b), .op(op), .x(x), .y(y));

    initial begin
        $dumpfile("ALU_4bit.vcd");
        $dumpvars(0, ALU_4bit_tb);

        $monitor("a=%b, b=%b, op=%b -> x=%b, y=%b", a, b, op, x, y);

        #0  a = 4'b1010; b = 4'b0101; op = 4'b0000; // OR Reduction
        #10 a = 4'b1101; b = 4'b0000; op = 4'b0001; // AND Reduction
        #10 a = 4'b1001; b = 4'b0110; op = 4'b0010; // XOR Reduction
        #10 a = 4'b1111; b = 4'b0011; op = 4'b0011; // AND
        #10 a = 4'b1100; b = 4'b0110; op = 4'b0100; // OR
        #10 a = 4'b0101; b = 4'b1010; op = 4'b0101; // XOR
        #10 a = 4'b1001; b = 4'b0111; op = 4'b0110; // Greater Than
        #10 a = 4'b0001; b = 4'b1010; op = 4'b0111; // Less Than
        #10 a = 4'b0011; b = 4'b0011; op = 4'b1001; // Equality
        #10 a = 4'b0110; b = 4'b0011; op = 4'b1010; // Addition
        #10 a = 4'b1001; b = 4'b0010; op = 4'b1011; // Subtraction
        #10 a = 4'b0011; b = 4'b0010; op = 4'b1100; // Multiplication
        #10 a = 4'b1100; b = 4'b0001; op = 4'b1101; // Right Shift
        #10 a = 4'b0011; b = 4'b0001; op = 4'b1110; // Left Shift
        #10 a = 4'b1100; b = 4'b0000; op = 4'b1111; // Bitwise NOT

        #10 $finish;
    end
endmodule
