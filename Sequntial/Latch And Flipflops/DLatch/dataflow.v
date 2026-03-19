module Dataflow(q,d,en);
input d,en;
output q;
assign q=en?d:q;
endmodule