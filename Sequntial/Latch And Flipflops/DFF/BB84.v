//Bheavioural Positive Edge Triggered DFF Asynchronous Active High Reset

module dff_PE_ARH(q,d,clk,rst);
input d,clk,rst;
output reg q;
always@(posedge clk or posedge rst) //when clock changes on 0 to 1 , it is posedge triggered
    if(rst)
        q<=1'b0;
    else
        q<=d;
endmodule