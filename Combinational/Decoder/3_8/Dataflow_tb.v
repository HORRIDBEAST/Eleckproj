module Dataflow_tb;
    reg [2:0] I;
    reg EN;
    wire [7:0] Y;

    Dataflow uut (.I(I), .Y(Y), .EN(EN));

    initial begin
        $dumpfile("Dataflow.vcd");
        $dumpvars(0, Dataflow_tb);

        $monitor("I=%b EN=%b Y=%b", I, EN, Y);
        
        // Test cases for EN = 1 (should activate one-hot encoding)
        #0  I=3'b000; EN=1'b1; // Y=00000001
        #10 I=3'b001; EN=1'b1; // Y=00000010
        #10 I=3'b010; EN=1'b1; // Y=00000100
        #10 I=3'b011; EN=1'b1; // Y=00001000
        #10 I=3'b100; EN=1'b1; // Y=00010000
        #10 I=3'b101; EN=1'b1; // Y=00100000
        #10 I=3'b110; EN=1'b1; // Y=01000000
        #10 I=3'b111; EN=1'b1; // Y=10000000
        
        // Test cases for EN = 0 (all outputs should be 00000000)
        #10 I=3'b000; EN=1'b0; // Y=00000000
        #10 I=3'b001; EN=1'b0; // Y=00000000
        #10 I=3'b010; EN=1'b0; // Y=00000000
        #10 I=3'b011; EN=1'b0; // Y=00000000
        #10 I=3'b100; EN=1'b0; // Y=00000000
        #10 I=3'b101; EN=1'b0; // Y=00000000
        #10 I=3'b110; EN=1'b0; // Y=00000000
        #10 I=3'b111; EN=1'b0; // Y=00000000
        
        #10 $finish;
    end
endmodule
