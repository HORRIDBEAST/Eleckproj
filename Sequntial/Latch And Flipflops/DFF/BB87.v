//Bheavioural Positive Edge Triggered DFF Asynchronous Active Low Reset and Active High set

module dff_PE_ARL_AHS(q, d, clk, rst, set);
    input d, clk, rst, set;
    output reg q;

    always @(posedge clk or negedge rst or posedge set) // Correct 'or' instead of ','
    begin
        if (!rst)       // Active low reset
            q <= 1'b0;
        else if (set)   // Active high set
            q <= 1'b1;
        else
            q <= d;     // Standard D-Flip-Flop operation
    end
endmodule