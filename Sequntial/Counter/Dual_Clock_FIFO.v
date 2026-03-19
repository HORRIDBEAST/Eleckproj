module FIFO(
    input clk_r, clk_w, rst, wr_en, rd_en,
    input [7:0] buf_in,
    output reg [7:0] buf_out,
    output reg buf_empty, buf_full,
    output reg [3:0] counter
);

    reg [7:0] buf_mem[63:0]; // FIFO memory
    reg [5:0] rd_ptr, wr_ptr; // Read and write pointers

    // Synchronous logic for buf_empty and buf_full on clk_r
    always @(posedge clk_r or posedge rst) begin
        if (rst) begin
            buf_empty <= 1'b1; // Reset: FIFO is empty
            buf_full <= 1'b0;  // Reset: FIFO is not full
        end else begin
            buf_empty <= (counter == 0); // Update empty flag
            buf_full <= (counter == 64); // Update full flag
        end
    end

    // Counter logic on clk_w (write clock)
    always @(posedge clk_w or posedge rst) begin
        if (rst)
            counter <= 0;
        else if (!buf_full && wr_en) // Increment counter if write is active
            counter <= counter + 1;
        else
            counter <= counter;
    end

    // Counter logic on clk_r (read clock)
    always @(posedge clk_r or posedge rst) begin
        if (rst)
            counter <= 0;
        else if (!buf_empty && rd_en) // Decrement counter if read is active
            counter <= counter - 1;
        else
            counter <= counter;
    end

    // Fetch data from FIFO on clk_r
    always @(posedge clk_r or posedge rst) begin
        if (rst)
            buf_out <= 0;
        else if (!buf_empty && rd_en) // Read data if buffer is not empty and read is active
            buf_out <= buf_mem[rd_ptr];
        else
            buf_out <= buf_out; // Hold value otherwise
    end

    // Write data to FIFO on clk_w
    always @(posedge clk_w) begin
        if (!buf_full && wr_en) // Write data if buffer is not full and write is active
            buf_mem[wr_ptr] <= buf_in;
        else
            buf_mem[wr_ptr] <= buf_mem[wr_ptr]; // Hold value otherwise
    end

    // Manage write pointer on clk_w
    always @(posedge clk_w or posedge rst) begin
        if (rst)
            wr_ptr <= 0;
        else if (!buf_full && wr_en) // Increment write pointer if write is active
            wr_ptr <= wr_ptr + 1;
        else
            wr_ptr <= wr_ptr; // Hold value otherwise
    end

    // Manage read pointer on clk_r
    always @(posedge clk_r or posedge rst) begin
        if (rst)
            rd_ptr <= 0;
        else if (!buf_empty && rd_en) // Increment read pointer if read is active
            rd_ptr <= rd_ptr + 1;
        else
            rd_ptr <= rd_ptr; // Hold value otherwise
    end

endmodule