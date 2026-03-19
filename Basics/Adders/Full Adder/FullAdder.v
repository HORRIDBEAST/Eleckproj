module FullAdder(a,b,cin,cout,sum);
    input a;
    input b;
    input cin;
    output cout;
    output sum;
    wire N1,N2,N3,N4;
    xor xor1(N1,a,b);
    xor xor2(sum,N1,cin);
    and and1(N2,a,b);
    and and2(N3,b,cin);
    and and3(N4,cin,a);
    or or1(cout,N2,N3,N4);
endmodule