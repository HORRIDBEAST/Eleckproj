module Clock_Frequency_Divider_by_2(clk_in, clk_out, rst);

input clk_in, rst;
output reg clk_out;

always @ (posedge clk_in)
begin
    if(rst)
        clk_out <= 0;
    else
        clk_out <= ~clk_out;
end

endmodule