`timescale 1ns/1ns

module FA_behavioural_tb;

    // Inputs
    reg a;
    reg b;
    reg cin;

    // Outputs
    wire sum;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    FA_behavioural uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Testbench logic
    initial begin
        // Open a file to log the results
        $dumpfile("FA_behavioural_tb.vcd");
        $dumpvars(0, FA_behavioural_tb);

        // Test case 1: a = 0, b = 0, cin = 0
        a = 0; b = 0; cin = 0;
        #10; // Wait for 10 time units
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // Test case 2: a = 0, b = 0, cin = 1
        a = 0; b = 0; cin = 1;
        #10;
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // Test case 3: a = 0, b = 1, cin = 0
        a = 0; b = 1; cin = 0;
        #10;
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // Test case 4: a = 0, b = 1, cin = 1
        a = 0; b = 1; cin = 1;
        #10;
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // Test case 5: a = 1, b = 0, cin = 0
        a = 1; b = 0; cin = 0;
        #10;
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // Test case 6: a = 1, b = 0, cin = 1
        a = 1; b = 0; cin = 1;
        #10;
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // Test case 7: a = 1, b = 1, cin = 0
        a = 1; b = 1; cin = 0;
        #10;
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // Test case 8: a = 1, b = 1, cin = 1
        a = 1; b = 1; cin = 1;
        #10;
        $display("a = %b, b = %b, cin = %b, cout = %b, sum = %b", a, b, cin, cout, sum);

        // End simulation
        $finish;
    end

endmodule