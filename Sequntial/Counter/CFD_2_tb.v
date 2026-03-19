`timescale 1ns/1ps

module tb_Clock_Frequency_Divider_by_2;

    // Inputs
    reg clk_in;  // Input clock
    reg rst;     // Reset signal

    // Outputs
    wire clk_out; // Output clock

    // Instantiate the Clock Frequency Divider module
    Clock_Frequency_Divider_by_2 uut (
        .clk_in(clk_in),
        .clk_out(clk_out),
        .rst(rst)
    );

    // Clock Generation
    always #5 clk_in = ~clk_in; // Generate a 10ns period clock (5ns high, 5ns low)

    initial begin
        // Initialize signals
        clk_in = 0;
        rst = 0;

        // Apply reset
        $display("Applying reset...");
        rst = 1; // Activate reset
        #20;     // Hold reset for 20ns
        rst = 0; // Release reset

        // Observe normal operation
        $display("Observing normal operation...");
        #100;    // Run simulation for 100ns to observe frequency division

        // Test reset during operation
        $display("Testing reset during operation...");
        rst = 1; // Activate reset again
        #20;     // Hold reset for 20ns
        rst = 0; // Release reset

        // Finish simulation
        $display("Simulation Complete.");
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | clk_in=%b | clk_out=%b | rst=%b", $time, clk_in, clk_out, rst);
    end

endmodule