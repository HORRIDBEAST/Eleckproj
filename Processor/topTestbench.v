module testbench;
    parameter numberOfAddressBits = 25;
    parameter numberOfDataBits    = 32;

    wire [numberOfAddressBits - 1 : 0] addressBusByProcessor;
    wire readByProcessor;
    wire writeByProcessor;
    wire chipSelectByProcessor;
    wire clk;
    reg [numberOfDataBits - 1 : 0] dataBusInputProcessor;
    wire [numberOfDataBits - 1 : 0]  dataBusOutputProcessor;




    reg [numberOfAddressBits - 1 : 0] addressBusMemory;
    reg readMemory;
    reg writeMemory;
    reg chipSelectMemory;
    reg [numberOfDataBits - 1 : 0] dataBusInputMemory;
    wire [numberOfDataBits - 1 : 0] dataBusOutputMemory;



    integer i;
    
    


    processor p(clk , readByProcessor , writeByProcessor , chipSelectByProcessor , addressBusByProcessor , dataBusInputProcessor , dataBusOutputProcessor );

    memory m( readMemory , writeMemory , chipSelectMemory, addressBusMemory , dataBusInputMemory , dataBusOutputMemory );



    initial 
        begin
            $dumpvars(0 ,testbench);
            $dumpfile("topTestbench.vcd");
        end

   
    assign readByProcessor         = (readMemory) ? 1 : 0;
    assign writeByProcessor        = (writeMemory) ? 1 : 0;
    assign chipSelectByProcessor   = (chipSelectMemory) ? 1 : 0;
    assign addressBusByProcessor   = addressBusMemory;

    always @(chipSelectMemory , readMemory , writeMemory , addressBusMemory)
        begin
            if(chipSelectMemory)
                begin
                    if( readMemory && !writeMemory )
                        begin
                            #1 dataBusInputProcessor = dataBusOutputMemory;
                        end
                    else if ( !readMemory && writeMemory )
                        begin
                            dataBusInputMemory = dataBusOutputProcessor;

                        end
                end
        end

    initial 
        begin



                    $display("program counter from testbench : %h , addressBus : %h , time = %d" , p.programCounter , addressBusMemory , $time);
                    #5 readMemory = 1 ; writeMemory = 0 ; chipSelectMemory = 1 ; addressBusMemory = p.programCounter;
                    $display("program counter from testbench : %h , addressBus : %h , time = %d" , p.programCounter , addressBusMemory , $time);
                    #5 readMemory = 0 ; writeMemory = 1 ; chipSelectMemory = 1 ; addressBusMemory = p.dataPointer;
                    $display("data Pointer from testbench : %h , addressBus : %h , time = %d" , p.dataPointer , addressBusMemory , $time);
                    #3 readMemory = 1 ; writeMemory = 0 ; chipSelectMemory = 1 ; addressBusMemory = p.programCounter;
                    $display("program counter from testbench : %h , addressBus : %h , time = %d" , p.programCounter , addressBusMemory , $time);

        

  
            
                    #100 $finish;

        end


    


endmodule