module Behavioural_Async_Reset(q,d,en,rst);
input d,en,rst;
output reg q;

always@(en,d,rst)
    if(rst) q=0;
    else if(en) q=d;

endmodule