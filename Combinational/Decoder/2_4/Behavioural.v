module Behavioural(I, Y, EN);
    input [1:0] I;
    input EN;
    output reg [3:0] Y;  // FIXED: Y must be reg
    
    always @(*) begin
        if (EN) begin
            case (I)
                2'b00: Y = 4'b0001;
                2'b01: Y = 4'b0010;
                2'b10: Y = 4'b0100;
                2'b11: Y = 4'b1000;
                default: Y = 4'b0000; // Should never happen
            endcase
        end else begin
            Y = 4'b0000;  // FIXED: Output should be 0000 when EN=0
        end
    end
endmodule
