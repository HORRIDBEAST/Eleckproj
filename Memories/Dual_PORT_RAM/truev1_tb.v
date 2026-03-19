`timescale 1ns / 1ps

module tb_ram_dual_port1;

  // Inputs
  reg [7:0] data_a, data_b;
  reg [5:0] add_a, add_b;
  reg we_a, we_b, clk;
  wire [7:0] q_a, q_b;

  // Instantiate RAM
  true_ram_dual_port1 uut (
    .q_a(q_a),
    .q_b(q_b),
    .data_a(data_a),
    .data_b(data_b),
    .add_a(add_a),
    .add_b(add_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk)
  );

  integer i;

  // Clock generation
  always #5 clk = ~clk;  // Clock with 10ns period

  initial begin
    // Initialize
    clk = 0;
    we_a = 0; we_b = 0;
    add_a = 0; add_b = 0;
    data_a = 0; data_b = 0;

    // Writing data using Port A
    $display("Test 1: Writing to RAM via Port A...");
    for (i = 0; i < 5; i = i + 1) begin
      @(posedge clk);
      we_a = 1;
      add_a = i;
      data_a = i + 50;
    end
    we_a = 0;

    // Writing data using Port B
    $display("Test 2: Writing to RAM via Port B...");
    for (i = 5; i < 10; i = i + 1) begin
      @(posedge clk);
      we_b = 1;
      add_b = i;
      data_b = i + 100;
    end
    we_b = 0;

    // Reading data from both ports
    $display("Test 3: Reading from RAM using both ports...");
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge clk);
      add_a = i;
      add_b = 9 - i;
      #2; // Small delay for stability
      $display("Addr A: %2d, Data Out A: %3d | Addr B: %2d, Data Out B: %3d", add_a, q_a, add_b, q_b);
    end

    #20;
    $finish;
  end

endmodule
