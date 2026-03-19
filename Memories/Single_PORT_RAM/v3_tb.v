`timescale 1ns / 1ps

module tb_ram_single_port3;

    // Testbench Signals
    reg [7:0] data;
    reg [5:0] addr;
    reg we, clk;
    wire [7:0] q;

    // Instantiate the RAM Module
    ram_single_port3 uut (
        .q(q),
        .data(data),
        .addr(addr),
        .we(we),
        .clk(clk)
    );

    // Declare loop variable outside procedural blocks
    integer i;

    // Clock Generation (10 ns period)
    always #5 clk = ~clk;

    // Test Procedure
    initial begin
        // Initialize Signals
        clk = 0;
        we = 0;
        addr = 0;
        data = 0;

        // Write Phase: Store values at different addresses
        for (i = 0; i < 10; i = i + 1) begin
            addr = i;           // Set address
            data = i + 10;      // Set data (values 10 through 19)
            we = 1;             // Enable write
            @(posedge clk);     // Wait for clock edge to trigger write
        end

        // Disable Write
        we = 0;
        @(posedge clk);

        // Read Phase: Fetch values from stored addresses
        for (i = 0; i < 10; i = i + 1) begin
            addr = i;           // Set address
            @(posedge clk);     // Wait for clock edge to trigger read
            $display("Read Addr: %2d, Data Out: %3d", addr, q);
        end

        // Test 3: Simultaneous Read and Write
        $display("Test 3: Read and Write at the same time...");
        we = 1; // Enable write
        for (i = 0; i < 5; i = i + 1) begin
            addr = i;           // Set address
            data = i + 50;      // Set data (values 50 through 54)
            @(posedge clk);     // Wait for clock edge to trigger read/write
            $display("Write Addr: %2d, Data In: %3d, Read Addr: %2d, Data Out: %3d",
                     addr, data, addr, q);
        end

        // End Simulation
        #20;
        $finish;
    end

endmodule