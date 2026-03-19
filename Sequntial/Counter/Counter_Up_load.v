module Counter_Up_Load(count, reset, clock,load,data);
input reset, clock,load;
input [7:0] data;
output [7:0] count;
reg [7:0] count_tmp;

always @ (posedge clock)
    if(!reset) //Active Low
        count_tmp <= 8'd0;
    else if(load) //Load Data
        count_tmp <= data;
    else
        count_tmp <= count_tmp + 1; //Increment
assign count = count_tmp;
endmodule