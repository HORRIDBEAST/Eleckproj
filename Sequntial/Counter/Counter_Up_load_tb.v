`timescale 1ns / 1ps

module Counter_Up_Load_tb;
    reg clock, reset, load;
    reg [7:0] data;
    wire [7:0] count;

    // Instantiate the DUT (Design Under Test)
    Counter_Up_Load uut (
        .count(count),
        .reset(reset),
        .clock(clock),
        .load(load),
        .data(data)
    );

    // Clock Generation (Period = 10ns, i.e., 5ns HIGH, 5ns LOW)
    always #5 clock = ~clock;

    initial begin
        $dumpfile("Counter_Up_Load_tb.vcd"); // VCD file for waveform viewing
        $dumpvars(0, Counter_Up_Load_tb);
        $monitor("Time=%0t | Reset=%b | Load=%b | Data=%d | Count=%d", 
                 $time, reset, load, data, count);

        // Initialize signals
        clock = 0;
        reset = 0;  // Apply reset (Active-Low)
        load = 0;
        data = 8'd0;

        #10 reset = 1;  // Release reset
        #10;

        // Let it count normally
        #40;

        // Load a value into the counter
        #10 load = 1; data = 8'd75;
        #10 load = 0; // Stop loading

        // Continue normal counting
        #50;

        // Apply another load while counter is running
        #10 load = 1; data = 8'd150;
        #10 load = 0;

        // More counting
        #50;

        // Apply reset again
        #10 reset = 0;
        #10 reset = 1;

        // Count more after reset
        #50;

        // End simulation
        #20 $finish;
    end
endmodule
