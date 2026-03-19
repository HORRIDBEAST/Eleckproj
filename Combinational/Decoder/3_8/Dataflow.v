module Dataflow(I,Y,EN);
input [2:0] I;
input EN;
output [7:0] Y;

assign Y = {
    EN & I[2] & I[1] & I[0],
    EN & I[2] & I[1] & ~I[0],
    EN & I[2] & ~I[1] & I[0],
    EN & I[2] & ~I[1] & ~I[0],
    EN & ~I[2] & I[1] & I[0],
    EN & ~I[2] & I[1] & ~I[0],
    EN & ~I[2] & ~I[1] & I[0],
    EN & ~I[2] & ~I[1] & ~I[0]
};
endmodule