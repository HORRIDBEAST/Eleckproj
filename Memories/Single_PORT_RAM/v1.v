module ram_single_port (
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
        if (we) begin
            ram[write_addr] <= data; // Write data to RAM
            if (write_addr == read_addr)
                q <= data; // Ensure updated value is read during simultaneous read/write
            else
                q <= ram[read_addr]; // Otherwise, read the current value
        end else begin
            q <= ram[read_addr]; // Read the current value
        end
    end
endmodule

//this is called a single port ram because you can only perform one operation at a time
//3 opeations possible
//1 Write
//1 Read
//1 Write and Read (Read while write => first read then write)
//2 Write -not possible