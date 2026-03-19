module counter_10_to_40_up(count,clk,rst);
input clk,rst;
output [7:0] count;
reg [7:0] count_tmp;

always @ (posedge clk)
begin
    if (!rst) // Active Low Reset
        count_tmp <= 8'd10; // Reset to 10
    else if (count_tmp >= 8'd40 || count_tmp < 8'd10) // Stop counting when reaching 40
        count_tmp <= 8'd40;
    else
        count_tmp <= count_tmp + 1; // Increment otherwise
end
assign count = count_tmp;
endmodule