`timescale 1ns / 1ps

module Counter_Up_tb;
    reg clock, reset;
    wire [7:0] count;

    // Instantiate the Counter Module
    Counter_Up uut (
        .count(count),
        .reset(reset),
        .clock(clock)
    );

    // Clock Generation (10ns period → 5ns HIGH, 5ns LOW)
    always #5 clock = ~clock; 

    initial begin
        $dumpfile("Counter_Up_tb.vcd"); // Generate waveform
        $dumpvars(0, Counter_Up_tb);
        $monitor("Time=%0t | Reset=%b | Count=%d", $time, reset, count);

        // Initialize signals
        clock = 0; 
        reset = 1; // Apply reset at start
        
        // Reset the counter
        #10 reset = 0; // Deactivate reset
        #20 reset = 1; // Release reset
    
        #100 $finish;
    end
endmodule
