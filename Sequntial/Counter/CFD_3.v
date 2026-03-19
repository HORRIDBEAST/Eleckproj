module div_3(input clk_in, input rst, output clk_out);
    reg [1:0] ps_count; // Positive-edge counter
    reg [1:0] ns_count; // Negative-edge counter

    // Positive-edge triggered logic
    always @(posedge clk_in) begin
        if (rst)
            ps_count <= 0; // Reset counter
        else if (ps_count == 2)
            ps_count <= 0; // Reset counter when it reaches 2
        else
            ps_count <= ps_count + 1; // Increment counter
    end

    // Negative-edge triggered logic
    always @(negedge clk_in) begin
        if (rst)
            ns_count <= 0; // Reset counter
        else if (ps_count == 2)
            ns_count <= 0; // Reset counter when ps_count reaches 2
        else
            ns_count <= ns_count + 1; // Increment counter
    end

    // Output logic
    assign clk_out = (ns_count == 2) | (ps_count == 2); // Output is high when either counter equals 2
endmodule