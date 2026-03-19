module Clock_Frequency_Divider_by_4(clk_in,clk_div2, clk_out, rst);

input clk_in, rst;
output reg clk_out;
output reg clk_div2;

always @ (posedge clk_in)
begin
    if(rst) clk_div2 <= 0;
    else clk_div2 <= ~clk_div2;
end

always @ (posedge clk_div2)
begin
    if(rst) clk_out <= 0;
    else clk_out <= ~clk_out;
end

endmodule