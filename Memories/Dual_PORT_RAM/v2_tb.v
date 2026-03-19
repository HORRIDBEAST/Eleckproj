`timescale 1ns / 1ps

module tb_ram_dual_port2;

  // Inputs
  reg [7:0] data;
  reg [5:0] read_add, write_add;
  reg we, read_clk, write_clk;
  wire [7:0] q;

  // Instantiate RAM
  ram_dual_port2 uut (
    .q(q),
    .data(data),
    .read_add(read_add),
    .write_add(write_add),
    .we(we),
    .read_clk(read_clk),
    .write_clk(write_clk)
  );

  integer i;

  // Clock generation
  always #5 write_clk = ~write_clk;  // 10ns period
  always #7 read_clk = ~read_clk;   // 14ns period (different from write)

  initial begin
    // Initialize
    write_clk = 0;
    read_clk = 0;
    we = 0;
    read_add = 0;
    write_add = 0;
    data = 0;

    // Writing data
    $display("Test 1: Writing to RAM...");
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge write_clk);
      we = 1;
      write_add = i;
      data = i + 50;
    end
    we = 0;

    // Reading data
    $display("Test 2: Reading from RAM...");
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge read_clk);
      read_add = i;
      #2; // Small delay for stability
      $display("Read Addr: %2d, Data Out: %3d", read_add, q);
    end

    #20;
    $finish;
  end

endmodule
