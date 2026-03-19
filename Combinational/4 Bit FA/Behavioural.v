module Behavioural(a, b, cin, sum, cout);
    input [3:0] a, b;
    input cin;
    output reg [3:0] sum;
    output reg cout;

    // Perform addition and assign the result to {cout, sum}
    always @(a, b, cin) 
        {cout, sum} = a + b + cin;
    
endmodule