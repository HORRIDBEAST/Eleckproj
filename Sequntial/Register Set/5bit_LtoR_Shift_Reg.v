module SR_LR(SO,clk,rst,SI);
input clk,rst,SI;
output  SO;
reg [4:0]SR;

always@(posedge clk,negedge rst)
 if(!rst)
  SR<=5'd0; // Reset shift register to all 0s
 else
 /*
SR[0]=SI;
SR[1]=SR[0];
SR[2]=SR[1];
SR[3]=SR[2];
SR[4]=SR[3];
 */
  SR<={SR[3:0],SI}; // Shift left, inserting SI at LSB
assign SO=SR[4];// Output MSB of shift register
endmodule

/*
// for Right to left shift

module SR_RL(SO,clk,rst,SI);
input clk,rst,SI;
output  SO;
reg [4:0]SR;

always@(posedge clk,negedge rst)
 if(!rst)
  SR<=5'd0; // Reset shift register to all 0s
 else
 /*
SR[4]=SI;
SR[3]=SR[4];
SR[2]=SR[3];
SR[1]=SR[2];
SR[0]=SR[1];
 

  SR<={SI,SR[4:1]}; // Shift Right, inserting SI at MSB
assign SO=SR[0];// Output LSB of shift register
endmodule

*/
