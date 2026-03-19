`timescale 1ns / 1ps

module Counter_Modulus47_up_tb;
    reg clk, rst;
    reg [7:0] data; // Not used in the module, included for completeness
    wire [7:0] count;

    // Instantiate the Design Under Test (DUT)
    Counter_Modulus47_up uut (
        .count(count),
        .clk(clk),
        .rst(rst),
        .data(data)
    );

    // Clock Generation (10ns period -> 5ns high, 5ns low)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("Counter_Modulus47_up_tb.vcd"); // Generate waveform file
        $dumpvars(0, Counter_Modulus47_up_tb);
        $monitor("Time=%0t | Reset=%b | Count=%d", $time, rst, count);

        // Initialize signals
        clk = 0;
        rst = 0;  // Active Low Reset (forces count to 0)
        data = 8'd0;

        #10 rst = 1; // Release Reset, Counter starts counting
        #500; // Allow counter to reach 46 and wrap around

        // Apply Reset in middle of operation
        #10 rst = 0;
        #10 rst = 1; // Counter restarts

        #200;
        $finish; // End Simulation
    end
endmodule
