module seq_001(det, inp, clk, rst); //Mealy Machine
    input inp, clk, rst;
    output reg det;

    parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;
    reg [1:0] state, nxt_state;

    // State transition logic (synchronous)
    always @(posedge clk or posedge rst)
        if (rst)
            state <= s0;
        else
            state <= nxt_state;

    // Next state logic
    always @(*) begin
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
                    nxt_state = s0;  // Reset to s0 on '1'
                else 
                    nxt_state = s1;  // Go to s1 on '0'
                    
            default: nxt_state = s0;
        endcase
    end

    // Output logic
    always @(state)
        case (state)
            s0: det = 0;
            s1: det = 0;
            s2: det = 0;
            s3: det = 1; // Detects "001" at s3
            default: det = 0;
        endcase
endmodule
