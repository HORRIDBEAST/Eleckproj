module true_ram_dual_port1(
    output reg [7:0] q_a,q_b,
    input [7:0] data_a,data_b,
    input [5:0] add_a,add_b,
    input we_a,we_b,clk
);
reg [7:0] ram [63:0];

//write port -only write no read

//port a
always @(posedge clk)
    if(we_a) begin 
        //write and read at the same time
        ram[add_a] <= data_a;
        q_a <= data_a;
    end
    //read
    else q_a <= ram[add_a];

//port b
always @(posedge clk)
    if(we_b) begin 
                //write and read at the same time

        ram[add_b] <= data_b;
        q_b <= data_b;
    end
    //read
    else q_b <= ram[add_b];

endmodule