module FIFO(clk, rst,buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full ,counter);
input clk, rst, wr_en, rd_en;
input [7:0] buf_in;
output [7:0] buf_out;
output buf_empty, buf_full;
output [7:0] counter;

reg[7:0] buf_out;
reg buf_empty, buf_full;
reg[6:0] counter;
reg[3:0] rd_ptr, wr_ptr;
reg[7:0] buf_mem[63:0];

always @(counter) begin //gives status flag
    buf_empty = (counter == 0); //nobidy can read from an empty buffer
    buf_full = (counter == 64); //nobody can write to a full buffer
end

always @(posedge clk or posedge rst) begin //handles the counter
    if (rst) 
        counter <= 0;
    else if((!buf_full && wr_en) && (!buf_empty && rd_en))// hold value of counter as it is if both read and write are active
        counter <= counter ;
    else if (!buf_full && wr_en) //only increment counter if write is active
        counter <= counter + 1;
    else if (!buf_empty && rd_en) //only decrement counter if read is active
        counter <= counter - 1;
    else 
        counter <= counter;
end

always @(posedge clk or posedge rst) begin //fetch data from FIFO
    if (rst) 
        buf_out <= 0;
    else begin 
        if(!buf_empty && rd_en) //only read if buffer is not empty and read is active
            buf_out <= buf_mem[rd_ptr];
        else                      //otherwise hold value of buffer
            buf_out <= buf_out;
    end
end

always @(posedge clk ) begin //write data to FIFO
    if(!buf_full && wr_en) //only write if buffer is not full and write is active
        buf_mem[wr_ptr] <= buf_in;
    else                      //otherwise hold value of buffer
        buf_mem[wr_ptr] <= buf_mem[wr_ptr];
end

always @(posedge clk or posedge rst) begin //manage  pointers
    if (rst) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
    end
    else begin
        //Head pointer
        if(!buf_full && wr_en) //only increment write pointer if write is active
            wr_ptr <= wr_ptr + 1;
        else //otherwise hold value of write pointer
            wr_ptr <= wr_ptr;

        //Tail pointer
        if(!buf_empty && rd_en) //only increment read pointer if read is active
            rd_ptr <= rd_ptr + 1;
        else //otherwise hold value of read pointer
            rd_ptr <= rd_ptr;
    end
end

endmodule