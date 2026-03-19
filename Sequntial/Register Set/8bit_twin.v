module Reg_set(Q1, Q2, D1, D2, CLK, RST);
    input CLK, RST;
    input [7:0] D1, D2;   // Corrected syntax for 8-bit input buses
    output reg [7:0] Q1, Q2; // Corrected syntax for 8-bit output registers

    always @(posedge CLK) begin
        if (RST) begin  // Added begin-end for proper conditional block execution
            Q1 <= 8'b0;
            Q2 <= 8'b0;
        end 
        else begin
            Q1 <= D1;
            Q2 <= D2;
        end
    end
endmodule
