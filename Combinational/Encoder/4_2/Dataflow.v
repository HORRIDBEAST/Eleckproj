module encoder(Y, V, I);
    input [3:0] I;
    output [1:0] Y;
    output V;

    assign Y[1] = I[3] | I[2];  // Highest priority bit
    assign Y[0] = I[3] | I[1];  // Second highest priority bit
    assign V = |I;              // Valid signal (1 if any input is high)

endmodule
