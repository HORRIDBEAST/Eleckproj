module HA_Behavioural(a,b,c,s);
input a,b;
output reg s,c;
always @(a,b) begin
    s=a^b;
    c=a&b;    
end
endmodule