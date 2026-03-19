module Counter_Modulus47_up(count,clk,rst,data);
input clk,rst;
input [7:0] data;
output [7:0] count;
reg [7:0] count_tmp;

always @ (posedge clk)
begin
    if(!rst || count_tmp>=8'd46) //Active Low
        count_tmp <= 8'd0;
    else
        count_tmp <= count_tmp + 1;
end
assign count = count_tmp;
endmodule