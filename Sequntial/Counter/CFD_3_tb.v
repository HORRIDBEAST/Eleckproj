module tb_div_3;

    // Inputs
    reg clk_in;
    reg rst;

    // Outputs
    wire clk_out;

    // Instantiate the Unit Under Test (UUT)
    div_3 uut (
        .clk_in(clk_in),
        .rst(rst),
        .clk_out(clk_out)
    );

    // Clock Generation
    initial begin
        clk_in = 0; // Initialize clock
        forever #5 clk_in = ~clk_in; // Toggle clock every 5 time units
    end

    // Test Sequence
    initial begin
        // Initialize Inputs
        rst = 1; // Assert reset
        #20;     // Wait for 20 time units
        rst = 0; // De-assert reset

        // Run Simulation for 60 time units
        #60;

        // Re-assert Reset
        rst = 1;
        #20;
        rst = 0;

        // Run Simulation for another 60 time units
        #60;

        // End Simulation
        $stop;
    end

endmodule