module ALU_4bit(x, y, a, b, op);
    input [3:0] a, b, op;
    output reg [3:0] x, y;

    always @(a, b, op) begin
        case(op)
            4'b0000: x = {3'b000, |a};      // OR Reduction
            4'b0001: x = {3'b000, &a};      // AND Reduction
            4'b0010: x = {3'b000, ^a};      // XOR Reduction
            4'b0011: x = a & b;             // AND Operation
            4'b0100: x = a | b;             // OR Operation
            4'b0101: x = a ^ b;             // XOR Operation
            4'b0110: x = {3'b000, a > b};   // Greater Than
            4'b0111: x = {3'b000, a < b};   // Less Than
            4'b1000: x = {3'b000, !a};      // NOT Reduction
            4'b1001: x = {3'b000, a == b};  // Equality Check
            4'b1010: {y[0], x} = a + b;     // Addition (Carry in y[0])
            4'b1011: x = a - b;             // Subtraction
            4'b1100: {y, x} = a * b;        // Multiplication
            4'b1101: {y, x} = a >> b;       // Right Shift
            4'b1110: {y, x} = a << b;       // Left Shift
            4'b1111: x = ~a;                // Bitwise NOT
            default: $display("Error: Invalid op code");
        endcase
    end
endmodule
