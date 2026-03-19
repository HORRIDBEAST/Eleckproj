module USR(PO, SO, PI, sel, clk, rst, SI);
    input clk, rst, SI;
    input [1:0] sel;
    input [4:0] PI;  // Parallel Input
    output reg [4:0] PO; // Parallel Output
    output SO; // Serial Output

    always @(posedge clk or negedge rst) begin
        if (!rst) 
            PO <= 5'd0;  // Active-low Reset
        else begin
            case (sel)
                2'b00: PO <= PO;               // No change
                2'b01: PO <= {PO[3:0], SI};   // Shift left
                2'b10: PO <= {SI, PO[4:1]};   // Shift right
                2'b11: PO <= PI;              // Load parallel input
                default: PO <= 5'd0;          // Default case
            endcase
        end
    end
    
    assign SO = (sel == 2'b01) ? PO[4] : PO[0]; // Output MSB or LSB based on shift direction

endmodule
