module Structural(s, cout, a, b, cin);
    input [3:0] a, b;
    input cin;
    output [3:0] s;
    output cout;
    wire n1, n2, n3;

    FullAdder f1(.a(a[0]), .b(b[0]), .cin(cin), .sum(s[0]), .cout(n1));
    FullAdder f2(.a(a[1]), .b(b[1]), .cin(n1), .sum(s[1]), .cout(n2));
    FullAdder f3(.a(a[2]), .b(b[2]), .cin(n2), .sum(s[2]), .cout(n3));
    FullAdder f4(.a(a[3]), .b(b[3]), .cin(n3), .sum(s[3]), .cout(cout));
endmodule