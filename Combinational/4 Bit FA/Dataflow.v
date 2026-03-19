module Dataflow(a, b, cin, sum, cout);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout;

    // Perform addition and assign the result to {cout, sum}
    assign {cout, sum} = a + b + cin;
endmodule