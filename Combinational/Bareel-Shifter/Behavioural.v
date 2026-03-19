module Behavioural(In,L,n,Out);
input [7:0] In;
input [2:0]n;
input L;
output reg [7:0] Out;

always @(*) begin
    if(L) Out = In << n;
    else Out = In >> n;
end

endmodule