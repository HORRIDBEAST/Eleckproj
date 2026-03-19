module encoder_tb;
    reg [3:0] I;
    wire [1:0] Y;
    wire V;

    encoder uut (.I(I), .Y(Y), .V(V));

    initial begin
        $dumpfile("encoder.vcd");
        $dumpvars(0, encoder_tb);

        $monitor("I=%b -> Y=%b, V=%b", I, Y, V);

        #0  I = 4'b0001; // Y=00, V=1
        #10 I = 4'b0010; // Y=01, V=1
        #10 I = 4'b0100; // Y=10, V=1
        #10 I = 4'b1000; // Y=11, V=1
        #10 I = 4'b0110; // Y=10, V=1 (Highest priority I[2])
        #10 I = 4'b1010; // Y=11, V=1 (Highest priority I[3])
        #10 I = 4'b0000; // Y=00, V=0 (No valid input)
        #10 $finish;
    end
endmodule
