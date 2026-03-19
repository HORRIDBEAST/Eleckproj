module Dataflow3(Y,I,S);

input [3:0] I;   // 4-bit input
input [1:0] S;   // 2-bit select line
output Y;        // Output wire
assign Y=(S==2'd0)?I[0]:((S==2'd1)?I[1]:((S==2'd2)?I[2]:I[3]));
endmodule