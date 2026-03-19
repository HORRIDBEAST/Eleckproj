module Dataflow(I, S, Y);
    input [1:0] I; // Corrected syntax for input array
    input S;
    output Y;

    assign Y = S ? I[1] : I[0]; // Conditional assignment
endmodule
