module ram_dual_port1(
    output reg [7:0] q,
    input [7:0] data,
    input [5:0] read_add,write_add,
    input we,read_clk,write_clk
);
reg [7:0] ram [63:0];

//write port -only write no read
always @(posedge write_clk)
    if(we)
        ram[write_add] <= data;

//read port
always @(posedge read_clk)
    q <= ram[read_add];

endmodule

//what happens if we read while write
//ans => Bheaviour is diffuclt to predict , depends on clk timing or read
//1)If your wrt_clk comes after data is settled down inside the memeory and then read clk arrives then it will be reading the new data 
//2)If your read_clk arrives before data is settled down inside the memory then it will be reading the old data