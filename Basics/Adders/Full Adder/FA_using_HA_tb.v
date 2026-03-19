`timescale 1ns/1ns

module FA_using_HA_tb;

    // Inputs
    reg a;
    reg b;
    reg Cin;

    // Outputs
    wire Cout;
    wire sum;

    // Instantiate the Unit Under Test (UUT)
    FA_using_HA uut (
        .a(a),
        .b(b),
        .Cin(Cin),
        .Cout(Cout),
        .sum(sum)
    );

    // Testbench logic
    initial begin
        // Open a file to log the results
        $dumpfile("FA_using_HA_tb.vcd");
        $dumpvars(0, FA_using_HA_tb);

        // Test case 1: a = 0, b = 0, Cin = 0
        a = 0; b = 0; Cin = 0;
        #10; // Wait for 10 time units
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // Test case 2: a = 0, b = 0, Cin = 1
        a = 0; b = 0; Cin = 1;
        #10;
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // Test case 3: a = 0, b = 1, Cin = 0
        a = 0; b = 1; Cin = 0;
        #10;
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // Test case 4: a = 0, b = 1, Cin = 1
        a = 0; b = 1; Cin = 1;
        #10;
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // Test case 5: a = 1, b = 0, Cin = 0
        a = 1; b = 0; Cin = 0;
        #10;
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // Test case 6: a = 1, b = 0, Cin = 1
        a = 1; b = 0; Cin = 1;
        #10;
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // Test case 7: a = 1, b = 1, Cin = 0
        a = 1; b = 1; Cin = 0;
        #10;
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // Test case 8: a = 1, b = 1, Cin = 1
        a = 1; b = 1; Cin = 1;
        #10;
        $display("a = %b, b = %b, Cin = %b, Cout = %b, sum = %b", a, b, Cin, Cout, sum);

        // End simulation
        $finish;
    end

endmodule