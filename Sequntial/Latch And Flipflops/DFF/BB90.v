//Bheavioural Positive Edge Triggered DFF Synchronous Active Low Reset and Active High Set

module dff_PE_SRL_SHS(q, d, clk, rst, set);
    input d, clk, rst, set;
    output reg q;

    always @(posedge clk ) // Correct 'or' instead of ','
    begin
        if (!rst)       // Active low reset
            q <= 1'b0;
        else if (set)   // Active high set
            q <= 1'b1;
        else
            q <= d;     // Standard D-Flip-Flop operation
    end
endmodule