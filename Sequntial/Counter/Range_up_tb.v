`timescale 1ns/1ps

module tb_counter_10_to_40_up;
    reg clk, rst;
    wire [7:0] count;

    // Instantiate the counter module
    counter_10_to_40_up uut (
        .count(count),
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        rst = 0; // Apply reset
        #10; // Wait for reset to take effect
        rst = 1; // Release reset

        // Run simulation for 0 to 50 time units
        #500;

        // Apply reset in between
        rst = 0;
        #20;
        rst = 1;

        // Continue for a few more cycles
        #500;
        $finish;
    end

    // Monitor count changes
    initial begin
        $monitor("Time=%0t | Reset=%b | Count=%d", $time, rst, count);
    end
endmodule