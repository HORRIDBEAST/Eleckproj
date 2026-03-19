module Behavioural_tb;
    reg [3:0] I;
    wire [1:0] Y;
    wire V;

    // Instantiate the Behavioural encoder
    Behavioural uut (.I(I), .Y(Y), .V(V));

    initial begin
        $dumpfile("Behavioural.vcd");
        $dumpvars(0, Behavioural_tb);

        $monitor("I=%b -> Y=%b, V=%b", I, Y, V);

        #0  I = 4'b0001; // Expected Y=00, V=1
        #10 I = 4'b0010; // Expected Y=01, V=1
        #10 I = 4'b0100; // Expected Y=10, V=1
        #10 I = 4'b1000; // Expected Y=11, V=1
        #10 I = 4'b0110; // Expected Y=10, V=1 (Highest priority is I[2])
        #10 I = 4'b1010; // Expected Y=11, V=1 (Highest priority is I[3])
        #10 I = 4'b0000; // Expected Y=00, V=0 (No valid input)
        #10 $finish;
    end
endmodule
