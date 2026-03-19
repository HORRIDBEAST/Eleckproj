module Dataflow_2(a, b, gt, eq, sm);
    input [3:0] a, b;
    output gt, eq, sm;

    assign eq=(a==b); //a==b
    assign gt=(a>b); //a>b
    assign sm=(a<b); //a<b
endmodule