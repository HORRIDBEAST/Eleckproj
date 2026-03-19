`timescale 1ns/1ns

module Structural_tb;
reg [3:0]a,b;
reg cin;
wire [3:0]s;
wire cout;
Structural uut(s,cout,a,b,cin);
initial begin 
    $dumpfile("Structural_tb.vcd");
    $dumpvars(0,Structural_tb);

    $monitor("a=%b,b=%b,cin=%b,s=%b,cout=%b",a,b,cin,s,cout);
    a=4'b0000;b=4'b0000;cin=1'b0;

    #10 a=4'b0001;b=4'b0001;cin=1'b0;
    #10 a=4'b0010;b=4'b0010;cin=1'b0;
    #10 a=4'b0011;b=4'b0011;cin=1'b0;
    #10 a=4'b0100;b=4'b0100;cin=1'b0;
    #10 a=4'b0101;b=4'b0101;cin=1'b0;
    #10 a=4'b0110;b=4'b0110;cin=1'b0;
    #10 a=4'b0111;b=4'b0111;cin=1'b0;
    #10 a=4'b1000;b=4'b1000;cin=1'b0;
    #10 a=4'b1001;b=4'b1001;cin=1'b0;
    #10 a=4'b1010;b=4'b1010;cin=1'b0;
    #10 a=4'b1011;b=4'b1011;cin=1'b0;
    #10 a=4'b1100;b=4'b1100;cin=1'b0;
    #10 a=4'b1101;b=4'b1101;cin=1'b0;
    #10 a=4'b1110;b=4'b1110;cin=1'b0;
    #10 a=4'b1111;b=4'b1111;cin=1'b0;
    #10 $finish;
end
endmodule