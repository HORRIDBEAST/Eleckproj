`timescale 1ns / 1ps

module tb_ram_dual_port1;

  // Signals
  reg [7:0] data;
  reg [5:0] read_add, write_add;
  reg we, read_clk, write_clk;
  wire [7:0] q;

  // Instantiate the RAM Module
  ram_dual_port1 uut (
    .q(q),
    .data(data),
    .read_add(read_add),
    .write_add(write_add),
    .we(we),
    .read_clk(read_clk),
    .write_clk(write_clk)
  );

  integer i;

  // Generate separate clocks
  always #5 write_clk = ~write_clk;  // Write clock: 10 ns period
  always #7 read_clk = ~read_clk;    // Read clock: 14 ns period (different from write clock)

  // Test Procedure
  initial begin
    // Initialize signals
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
      data = i + 50; // Store values 50, 51, ..., 59
    end
    we = 0;

    // Reading data
    $display("Test 2: Reading from RAM...");
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge read_clk);
      read_add = i;
      #1; // Small delay for output stabilization
      $display("Read Addr: %2d, Data Out: %3d", read_add, q);
    end

    // End simulation
    #20;
    $finish;
  end

endmodule
