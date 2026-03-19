module Behavioural(a, b, gt, eq, sm);
    input [3:0] a, b;
    output gt, eq, sm;

    always@(*) begin
        eq = (a == b);
        gt = (a > b);
        sm = (a < b);
    end
endmodule