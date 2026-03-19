`timescale 1ns/1ps

module tb_ram_single_port;

    // Inputs
    reg [7:0] data;         // Data to write into RAM
    reg [5:0] read_addr;    // Address to read from
    reg [5:0] write_addr;   // Address to write to
    reg we;                 // Write enable signal
    reg clk;                // Clock signal
    integer i;
    // Outputs
    wire [7:0] q;           // Data read from RAM

    // Instantiate the RAM module
    ram_single_port uut (
        .q(q),
        .data(data),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .we(we),
        .clk(clk)
    );

    // Clock Generation
    always #5 clk = ~clk; // Generate a clock with a period of 10ns (5ns high, 5ns low)

    initial begin
        // Initialize signals
        clk = 0;
        data = 8'd0;
        read_addr = 6'd0;
        write_addr = 6'd0;
        we = 0;

        // Apply reset (optional, if needed)
        #10;

        // Test 1: Write data to specific addresses
        $display("Test 1: Writing to RAM...");
        we = 1; // Enable write
        for (i = 0; i < 10; i = i + 1) begin
            write_addr = i;       // Write to address i
            data = 8'd10 + i;     // Write value 10, 11, ..., 19
            @(posedge clk);       // Wait for one clock cycle
        end
        we = 0; // Disable write

        // Test 2: Read data from the same addresses
        $display("Test 2: Reading from RAM...");
        for (i = 0; i < 10; i = i + 1) begin
            read_addr = i;        // Read from address i
            @(posedge clk);       // Wait for one clock cycle
            $display("Read Addr: %2d, Data Out: %3d", read_addr, q);
        end

        // Test 3: Simultaneous Read and Write
        $display("Test 3: Read and Write at the same time...");
        we = 1; // Enable write
        for (i = 0; i < 5; i = i + 1) begin
            write_addr = i;       // Write to address i
            read_addr = i;        // Read from the same address
            data = 8'd50 + i;     // Write value 50, 51, ..., 54
            @(posedge clk);       // Wait for one clock cycle
            $display("Write Addr: %2d, Data In: %3d, Read Addr: %2d, Data Out: %3d",
                     write_addr, data, read_addr, q);
        end
        we = 0; // Disable write

        // Finish simulation
        $display("Test Completed.");
        $finish;
    end

    // Monitor signals (without Time=%0t)
    initial begin
        $monitor("clk=%b | we=%b | write_addr=%d | read_addr=%d | data=%d | q=%d",
                 clk, we, write_addr, read_addr, data, q);
    end

endmodule