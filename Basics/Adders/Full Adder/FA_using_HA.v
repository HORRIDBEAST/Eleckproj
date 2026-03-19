module FA_using_HA(a, b, Cin, Cout, sum);
    input a, b, Cin;
    output Cout, sum;
    wire N1, N2, N3;

    // Instantiate Half Adders
    HA HA1(.a(a), .b(b), .s(N1), .c(N2)); // First Half Adder
    HA HA2(.a(N1), .b(Cin), .s(sum), .c(N3)); // Second Half Adder

    // OR gate for Cout
    or or1(Cout, N2, N3);
endmodule