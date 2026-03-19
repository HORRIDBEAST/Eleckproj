`timescale 1ns/1ps

module tb_FIFO;

    // Inputs
    reg clk_w;         // Write clock
    reg clk_r;         // Read clock
    reg rst;           // Reset signal
    reg wr_en;         // Write enable signal
    reg rd_en;         // Read enable signal
    reg [7:0] buf_in;  // Input data to FIFO

    // Outputs
    wire [7:0] buf_out; // Output data from FIFO
    wire buf_empty;     // Buffer empty flag
    wire buf_full;      // Buffer full flag
    wire [3:0] counter; // Number of elements in FIFO

    // Instantiate the FIFO module
    FIFO uut (
        .clk_r(clk_r),
        .clk_w(clk_w),
        .rst(rst),
        .buf_in(buf_in),
        .buf_out(buf_out),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .buf_empty(buf_empty),
        .buf_full(buf_full),
        .counter(counter)
    );

    // Clock Generation (clk_w: 10ns period, clk_r: 15ns period)
    always #5 clk_w = ~clk_w; // Generate a 10ns period clock (5ns high, 5ns low)
    always #7.5 clk_r = ~clk_r; // Generate a 15ns period clock (7.5ns high, 7.5ns low)

    initial begin
        // Declare loop variable
        integer i;

        // Initialize signals
        clk_w = 0;
        clk_r = 0;
        rst = 1;  // Start with reset active
        wr_en = 0;
        rd_en = 0;
        buf_in = 8'd0;

        // Apply reset
        $display("Applying reset...");
        #20;
        rst = 0; // Release reset

        // Test 1: Write data into FIFO
        $display("Testing Write Operation...");
        wr_en = 1; // Enable write
        for (i = 0; i < 10; i = i + 1) begin
            buf_in = 8'd10 + i; // Write values 10, 11, ..., 19
            @(posedge clk_w);   // Wait for one write clock cycle
        end
        wr_en = 0; // Disable write

        // Test 2: Read data from FIFO
        $display("Testing Read Operation...");
        rd_en = 1; // Enable read
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge clk_r); // Wait for one read clock cycle
        end
        rd_en = 0; // Disable read

        // Test 3: Simultaneous Read and Write
        $display("Testing Simultaneous Read and Write...");
        wr_en = 1; // Enable write
        rd_en = 1; // Enable read
        for (i = 0; i < 5; i = i + 1) begin
            buf_in = 8'd20 + i; // Write values 20, 21, ..., 24
            @(posedge clk_w);   // Wait for one write clock cycle
            @(posedge clk_r);   // Wait for one read clock cycle
        end
        wr_en = 0; // Disable write
        rd_en = 0; // Disable read

        // Test 4: Fill FIFO completely
        $display("Testing Full Buffer...");
        wr_en = 1; // Enable write
        for (i = 0; i < 64; i = i + 1) begin
            buf_in = 8'd30 + i; // Write values 30, 31, ..., 93
            @(posedge clk_w);   // Wait for one write clock cycle
        end
        wr_en = 0; // Disable write

        // Test 5: Empty FIFO completely
        $display("Testing Empty Buffer...");
        rd_en = 1; // Enable read
        for (i = 0; i < 64; i = i + 1) begin
            @(posedge clk_r); // Wait for one read clock cycle
        end
        rd_en = 0; // Disable read

        // Finish simulation
        $display("Simulation Complete.");
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | clk_w=%b | clk_r=%b | rst=%b | wr_en=%b | rd_en=%b | buf_in=%d | buf_out=%d | buf_empty=%b | buf_full=%b | counter=%d",
                 $time, clk_w, clk_r, rst, wr_en, rd_en, buf_in, buf_out, buf_empty, buf_full, counter);
    end

endmodule