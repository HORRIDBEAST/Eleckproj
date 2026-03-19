module Counter_Up_Down(count ,u_d,load,reset,clock,data);
input u_d,load,reset,clock;
input [7:0] data;
output [7:0] count;
reg [7:0] count_tmp;

always @ (posedge clock)
begin
    if(!reset) //Active Low
        count_tmp <= 8'd0;
    else if(load) //Load Data
        count_tmp <= data;
    else if(u_d) //Increment
        count_tmp <= count_tmp + 1;
    else //Decrement
        count_tmp <= count_tmp - 1;
end
assign count = count_tmp;
endmodule