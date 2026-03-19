module Behavioural_tb;
reg [1:0]I;
reg EN;
wire [3:0]Y;
Behavioural uut(.I(I),.Y(Y),.EN(EN));
initial begin
    $dumpfile("Behavioural.vcd");
    $dumpvars(0,Behavioural_tb);

    $monitor("I=%b EN=%b Y=%b",I,EN,Y);
    #0 I=2'b00; EN=1'b1;
    #10 I=2'b01; EN=1'b1;
    #10 I=2'b10; EN=1'b1;
    #10 I=2'b11; EN=1'b1;
    #10 I=2'b00; EN=1'b0;
    #10 I=2'b01; EN=1'b0;
    #10 I=2'b10; EN=1'b0;
    #10 I=2'b11; EN=1'b0;
    #10 $finish;
end
endmodule