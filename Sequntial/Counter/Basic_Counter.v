module Counter_Up(count, reset, clock);
input reset, clock;
output [7:0] count;
reg [7:0] count_tmp;

always @ (posedge clock)
     if(!reset) //Active Load
        count_tmp <= 8'd0;
     else
        count_tmp <= count_tmp + 1;
assign count = count_tmp;
endmodule