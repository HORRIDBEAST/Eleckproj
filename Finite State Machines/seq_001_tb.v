`timescale 1ns / 1ps

module seq_001_tb;
    reg inp, clk, rst;
    wire det;

    // Instantiate the FSM
    seq_001 uut (.det(det), .inp(inp), .clk(clk), .rst(rst));

    // Generate clock
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        inp = 0;

        #10 rst = 0; // Release reset

        // Test sequence: 001 (should detect at s3)
        #10 inp = 0;
        #10 inp = 0;
        #10 inp = 1; // Here, det should be 1
        
        // Another test sequence: 100 (should not detect)
        #10 inp = 1;
        #10 inp = 0;
        #10 inp = 0;
        #10 inp = 1; // Again, det should be 1

        // Edge case: Random inputs
        #10 inp = 1;
        #10 inp = 1;
        #10 inp = 0;
        #10 inp = 1;

        #20 $finish; // End simulation
    end

    initial begin
        $monitor("Time=%0t | inp=%b | state=%b | det=%b", $time, inp, uut.state, det);
    end
endmodule
