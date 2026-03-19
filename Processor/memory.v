module memory (read , write , chipSelectMemory , addressBits , dataBusInput , dataBusOutput  );

    parameter numberOfAddressBits = 25;
    parameter memorySize          = 1 << numberOfAddressBits;
    parameter numberOfDataBits    = 32;
    parameter locationSize        = 8;   // 1 location = 1 byte in my system.



    input [numberOfAddressBits - 1 : 0] addressBits;
    input read;
    input write;
    input chipSelectMemory;
    input [numberOfDataBits - 1 : 0] dataBusInput;
    output reg [numberOfDataBits - 1 : 0] dataBusOutput;

    reg [locationSize - 1 : 0] primaryMemory[memorySize - 1 : 0];



    initial 
        begin
            
            $readmemh("memoryContents.out" , primaryMemory);
        
        end

    task printMemory;
        begin
            $display("The base address of the 4 byte word is %h" , addressBits);
            $display("The contents written to the memory are %h %h %h %h" , primaryMemory[addressBits + 3] , primaryMemory[addressBits + 2] , primaryMemory[addressBits + 1] , primaryMemory[addressBits]);
        end
    endtask



    always @(read , write , chipSelectMemory , addressBits)
        begin
            if(chipSelectMemory && write && !read)
                begin

                   #1   primaryMemory[addressBits + 3] =  dataBusInput[31 : 24];
                        primaryMemory[addressBits + 2] =  dataBusInput[23 : 16];
                        primaryMemory[addressBits + 1] =  dataBusInput[15 : 8];
                        primaryMemory[addressBits]     =  dataBusInput[7  : 0];
                        printMemory;

                end
            else if(chipSelectMemory && !write && read)
                begin

                    dataBusOutput = { primaryMemory[addressBits + 3] , primaryMemory[addressBits + 2] , primaryMemory[addressBits + 1] , primaryMemory[addressBits] };
                end
        end


    
endmodule