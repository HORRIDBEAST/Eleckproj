`timescale 1ns / 1ps

module Moore_001_tb;
    reg inp, clk, rst;
    wire det;

    // Instantiate the FSM
    Moore_001 uut (.det(det), .inp(inp), .clk(clk), .rst(rst));

    // Clock generation
    always #5 clk = ~clk;  // Generate a clock with a 10ns period

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        inp = 0;

        #10 rst = 0; // Release reset

        // Test case 1: Detecting sequence "001"
        #10 inp = 0;
        #10 inp = 0;
        #10 inp = 1;  // Here, det should be 1

        // Test case 2: Sequence with interruption
        #10 inp = 1;  // Reset FSM
        #10 inp = 0;
        #10 inp = 0;
        #10 inp = 1;  // det should be 1

        // Test case 3: Random transitions
        #10 inp = 1;
        #10 inp = 1;
        #10 inp = 0;
        #10 inp = 1;

        #20 $finish;  // Stop simulation
    end

    initial begin
        $monitor("Time=%0t | inp=%b | state=%b | det=%b", $time, inp, uut.state, det);
    end

    // Dump waveform for visualization
    initial begin
        $dumpfile("Moore_001_tb.vcd");
        $dumpvars(0, Moore_001_tb);
    end

endmodule
