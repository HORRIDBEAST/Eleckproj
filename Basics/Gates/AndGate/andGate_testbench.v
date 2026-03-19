`timescale 1ns/1ps
module testbench;

    reg a,b;
    wire y;

    andGate dut(a ,b , y);

    initial 
        begin
           $dumpfile("andGate_testbench.vcd");
           $dumpvars(0 , testbench); 
        end
    
    initial
        begin

            $monitor( $time , " a = %b , b = %b , y = %b" , a ,b ,y);

            #5 a = 0 ; b = 0;
            #5 a = 0 ; b = 1;
            #5 a = 1 ; b = 0;
            #5 a = 1 ; b = 1;
            #5 $finish;

        end

    
endmodule