`timescale 1ns / 1ps

module Counter_Up_Down_tb;
    reg clock, reset, load, u_d;
    reg [7:0] data;
    wire [7:0] count;

    // Instantiate the DUT (Design Under Test)
    Counter_Up_Down uut (
        .count(count),
        .u_d(u_d),
        .load(load),
        .reset(reset),
        .clock(clock),
        .data(data)
    );

    // Clock Generation (10ns Period)
    always #5 clock = ~clock;

    initial begin
        $dumpfile("Counter_Up_Down_tb.vcd"); // VCD file for waveform viewing
        $dumpvars(0, Counter_Up_Down_tb);
        $monitor("Time=%0t | Reset=%b | Load=%b | U_D=%b | Data=%d | Count=%d", 
                 $time, reset, load, u_d, data, count);

        // Initialize signals
        clock = 0;
        reset = 0;  // Active low reset
        load = 0;
        u_d = 1;  // Start with up count
        data = 8'd0;

        #10 reset = 1; // Release reset
        #10;

        // Up Counting
        #50;

        // Load a value into the counter
        #10 load = 1; data = 8'd100;
        #10 load = 0; // Stop loading

        // Continue up counting
        #40;

        // Switch to Down Counting
        #10 u_d = 0;
        #50;

        // Load a new value into the counter
        #10 load = 1; data = 8'd50;
        #10 load = 0;

        // Continue Down Counting
        #40;

        // Apply reset again
        #10 reset = 0;
        #10 reset = 1;

        // Count more after reset
        #50;

        // End simulation
        #20 $finish;
    end
endmodule
