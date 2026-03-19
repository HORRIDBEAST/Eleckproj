module true_ram_dual_port2(
    output reg [7:0] q_a, q_b,
    input [7:0] data_a, data_b,
    input [5:0] add_a, add_b,
    input we_a, we_b, clk
);
    reg [7:0] ram [63:0]; // 64x8 RAM

    // Port A: Write when we_a is high, Read when we_a is low
    always @(posedge clk) begin
        if (we_a) 
            ram[add_a] <= data_a;  // Write operation
        else 
            q_a <= ram[add_a];  // Read operation
    end

    // Port B: Write when we_b is high, Read when we_b is low
    always @(posedge clk) begin
        if (we_b) 
            ram[add_b] <= data_b;  // Write operation
        else 
            q_b <= ram[add_b];  // Read operation
    end

endmodule
