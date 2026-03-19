module Behavioural(Y, V, I);
    input [3:0] I;
    output reg [1:0] Y;
    output reg V;

    always @(*) begin
        casez (I) // Use 'casez' to handle priority encoding (z = don't care)
            4'b1???: {V, Y} = 3'b111; // Highest priority (I[3])
            4'b01??: {V, Y} = 3'b110; // I[2] set
            4'b001?: {V, Y} = 3'b101; // I[1] set
            4'b0001: {V, Y} = 3'b100; // I[0] set
            default: {V, Y} = 3'b000; 
        endcase
    end
endmodule
