`timescale 1ns/1ns

module Behavioural_tb;
    reg [3:0] a, b;
    reg cin;
    wire [3:0] sum;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    Behavioural uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        // Open a file to log the results
        $dumpfile("Behavioural_tb.vcd");
        $dumpvars(0, Behavioural_tb);

        // Monitor the inputs and outputs
        $monitor("Time=%0t: a=%b, b=%b, cin=%b, sum=%b, cout=%b", $time, a, b, cin, sum, cout);
    end

    // Test cases
    initial begin
        // Initialize inputs
        a = 0;
        b = 0;
        cin = 0;

        // Test all combinations of a, b, and cin
        repeat (16) begin
            #10 a = a + 1;
            repeat (16) begin
                #10 b = b + 1;
                repeat (2) begin
                    #10 cin = ~cin;
                end
            end
        end

        // End simulation
        #10 $finish;
    end
endmodule