module ram_single_port2 (
    output reg [7:0] q,
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, clk
);
    reg [7:0] ram [63:0]; // RAM memory

    // Initialize RAM memory
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1)
            ram[i] = 8'd0; // Initialize all memory locations to 0
    end

    always @ (posedge clk) begin
        if (we)
            ram[write_addr] <= data; // Write data to RAM using non-blocking assignment
        q <= ram[read_addr];         // Always update q with the value at read_addr
    end
endmodule