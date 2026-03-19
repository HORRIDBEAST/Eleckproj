module ram_single_port3 (
    output wire [7:0] q, // Change from reg to wire
    input [7:0] data,
    input [5:0] addr,
    input we, clk
);
    reg [7:0] ram [63:0]; // RAM memory
    reg [5:0] add_reg;    // Address register

    // Initialize RAM memory
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1)
            ram[i] = 8'd0; // Initialize all memory locations to 0
    end

    always @ (posedge clk) begin
        if (we)
            ram[addr] <= data; // Write data to RAM using non-blocking assignment
        add_reg <= addr;       // Capture the current address
    end

    assign q = ram[add_reg];   // Continuous assignment for read operation
endmodule