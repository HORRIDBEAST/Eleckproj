`timescale 1ns/1ns

module HA_Structural_tb;

    // Inputs
    reg a;
    reg b;

    // Outputs
    wire s;
    wire c;

    // Instantiate the Unit Under Test (UUT)
    HA_Structral uut (
        .a(a),
        .b(b),
        .s(s),
        .c(c)
    );

    // Testbench logic
    initial begin
        // Open a file to log the results
        $dumpfile("HA_Structural_tb.vcd");
        $dumpvars(0, HA_Structural_tb);

        // Test case 1: a = 0, b = 0
        a = 0; b = 0;
        #10; // Wait for 10 time units
        $display("a = %b, b = %b, s = %b, c = %b", a, b, s, c);

        // Test case 2: a = 0, b = 1
        a = 0; b = 1;
        #10;
        $display("a = %b, b = %b, s = %b, c = %b", a, b, s, c);

        // Test case 3: a = 1, b = 0
        a = 1; b = 0;
        #10;
        $display("a = %b, b = %b, s = %b, c = %b", a, b, s, c);

        // Test case 4: a = 1, b = 1
        a = 1; b = 1;
        #10;
        $display("a = %b, b = %b, s = %b, c = %b", a, b, s, c);

        // End simulation
        $finish;
    end

endmodule