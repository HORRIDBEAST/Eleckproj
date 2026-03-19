module Behavioural_Basic(q,d,clk);
input d,clk;
output reg q;
always@(posedge clk) //when clock changes on 0 to 1 , it is posedge triggered
  q=d;
endmodule