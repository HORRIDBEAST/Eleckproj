module Moore_001(det, inp, clk, rst); //Moore Machine
    input inp, clk, rst;
    output reg det;
    parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;
    reg [1:0] state, nxt_state;

    // State transition logic (synchronous)
    always @(posedge clk )
        if (rst)
            state <= s0;
        else
            state <= nxt_state;

    // Next state logic
    always @(inp, state) 
        case (state)
            s0: if (inp) 
                    nxt_state = s0;  // Stay in s0 on '1'
                else 
                    nxt_state = s1;  // Go to s1 on '0'
                    
            s1: if (inp) 
                    nxt_state = s0;  // Reset to s0 on '1'
                else 
                    nxt_state = s2;  // Move to s2 on '0'
                    
            s2: if (inp) 
                    nxt_state = s3;  // Move to s3 on '1'
                else 
                    nxt_state = s2;  // Stay in s2 on '0'
                    
            s3: if (inp) 
                    nxt_state = s0;  // Stay in s3 on '1'
                else 
                    nxt_state = s1;  // Reset to s0 on '0'
                    
            default: nxt_state = s0;
        endcase

    // Output logic
    always @(state) 
        case (state)
            s0: det = 0;  // Output is 0 in s0
            s1: det = 0;  // Output is 0 in s1
            s2: det = 0;  // Output is 0 in s2
            s3: det = 1;  // Output is 1 in s3
            default: det = 0;
        endcase
endmodule

