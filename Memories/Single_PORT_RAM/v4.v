module ram_single_port4 (
    output reg [7:0] q,
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, clk
);

reg [7:0] ram [63:0];
reg [5:0] read_add_reg;
always @ (posedge clk) begin
    if (we) 
      ram[write_addr] = data; //write then read
    read_add_reg=read_addr; 
       
end
assign q=ram[read_add_reg];


endmodule