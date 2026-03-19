`timescale 1ns/1ps

module tb_counter_10_to_40_up__down;

    // Inputs
    reg u_d;         // Up/Down control signal
    reg load;        // Load signal
    reg reset;       // Reset signal
    reg clock;       // Clock signal
    reg [7:0] data;  // Data input for loading

    // Outputs
    wire [7:0] count;

    // Instantiate the counter module
    counter_10_to_40_up__down uut (
        .count(count),
        .u_d(u_d),
        .load(load),
        .reset(reset),
        .clock(clock),
        .data(data)
    );

    // Clock Generation
    always #5 clock = ~clock; // 10ns clock period

    initial begin
        // Initialize signals
        clock = 0;
        reset = 0; // Active Low Reset
        u_d = 1;   // Default to up-counting
        load = 0;  // Default to no load
        data = 8'd0;

        // Apply reset
        #10;
        reset = 1; // Release reset

        // Test 1: Up-counting from 10 to 40
        $display("Testing Up-Counting...");
        u_d = 1; // Enable up-counting
        #400;    // Allow time for counting

        // Test 2: Down-counting from 40 to 10
        $display("Testing Down-Counting...");
        u_d = 0; // Enable down-counting
        #400;    // Allow time for counting

        // Test 3: Load a specific value
        $display("Testing Load Functionality...");
        load = 1; // Enable load
        data = 8'd25; // Load value 25
        #10;      // Wait for one clock cycle
        load = 0; // Disable load
        #10;      // Observe loaded value

        // Test 4: Reset during operation
        $display("Testing Reset Functionality...");
        reset = 0; // Activate reset
        #10;       // Wait for reset to take effect
        reset = 1; // Release reset

        // Finish simulation
        $display("Simulation Complete.");
        $finish;
    end

    // Monitor changes in count
    initial begin
        $monitor("Time=%0t | Reset=%b | Load=%b | U/D=%b | Data=%d | Count=%d",
                 $time, reset, load, u_d, data, count);
    end

endmodule