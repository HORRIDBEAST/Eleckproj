module counter_10_to_40_up__down(count,u_d,load,reset,clock,data);
input u_d,load,reset,clock;
input [7:0] data;
output [7:0] count;
reg [7:0] count_tmp;

always @ (posedge clock)
begin
    if(!reset || count_tmp>=8'd40 || count_tmp<8'd10) //Active Low
        count_tmp <= 8'd10;
    else if(load) //Load Data
        count_tmp <= data;
    else if(u_d) //Increment
        count_tmp <= (count_tmp >= 8'd40) ? 8'd10 : count_tmp + 1;
    else //Decrement
        count_tmp <= (count_tmp <= 8'd10) ? 8'd40 : count_tmp - 1;
end
assign count = count_tmp;
endmodule