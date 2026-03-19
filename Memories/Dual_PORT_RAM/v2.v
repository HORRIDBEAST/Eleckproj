module ram_dual_port2(
    output reg [7:0] q,
    input [7:0] data,
    input [5:0] read_add,write_add,
    input we,read_clk,write_clk
);
reg [7:0] ram [63:0];
reg [5:0] read_add_reg;

//write port -only write no read
always @(posedge write_clk)
    if(we)
        ram[write_add] <= data;

//read port
always @(posedge read_clk)
begin

    q <= ram[read_add_reg];
    read_add_reg <= read_add;

end

endmodule