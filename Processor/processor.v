module processor ( clk , read , write ,  chipSelect , addressBus , dataBusInput , dataBusOutput );

        parameter clockFrequency  = 10; 
        parameter numberOfAddressBits  = 25;  //The PC size must be the same as that of the address bus;
        parameter numberOfDataBits    = 32;
        parameter registerSize    = 32;
        parameter instructionSize = 32;   //Keeping the IR size same as the instruction size;
        parameter numberOfRegisters = 32;


        //Opcodes.
        //Using the compiler directive define in order to "name" the opcodes so we do not have to refer to the opcodes by their numbers 
        //anymore. We can simply use their names to reference the opcodes
        `define NOP 5'd0
        `define ADD 5'd1
        `define SUB 5'd2
        `define OR  5'd3
        `define AND 5'd4
        `define NOT 5'd5
        `define XOR 5'd6
        `define CMP 5'd7
        `define Bxx 5'd8
        `define JMP 5'd9  
        `define JMPL 5'd9  //Same opcode for the JMP and JMPL instructions. We will differentiate them with the link vit i.e. bit 16 of the Instrcution Register.
        `define LD  5'd10
        `define LDI 5'd11
        `define LDX 5'd12
        `define ST  5'd13
        `define STX 5'd14
        `define HLT 5'd31



        //We have 14 different types of conditional branches and we have defined a single opcode for the branch instruction.
        //So we have to reserve some bits in the format of the branch instruction to tell the processor that which condition is to be tested.
        //We have a total of 14 branch instructions, so we have to reserve a total of 4 bits to represent these 14 conditions uniquely.
        //4 bits produce a combination of 16 (that is the closest to 14). Hence we dedicate 4 bits.
        //naming the conditions so that we do not have to remember the "number combination" for the respective condition.
        //We can simply reference this condition using its name.

        `define BRA 4'd0  //Always branch. No condition
        `define BNV 4'd1  //Never Branch.
        `define BCC 4'd2  //Branch if Carry Flag Bit = 0
        `define BCS 4'd3  //Branch if Carry Flag Bit = 1
        `define BOC 4'd4  //Branch if Overflow Flag Bit = 0
        `define BOS 4'd5  //Branch if Overflow Flag Bit = 1
        `define BEQ 4'd6  //Branch if Zero Flag Bit = 0
        `define BNE 4'd7  //Branch if Zero Flag Bit = 1
        `define BGE 4'd8  //Branch if op1 >= op2 in cmp instruction before it
        `define BLT 4'd9  //Branch if op1 < op2 in cmp instruction before it
        `define BGT 4'd10 //Branch if op1 > op2 in cmp instruction before it
        `define BLE 4'd11 //Branch if op1 <= op2 in cmp instruction before it
        `define BPL 4'd12 //Branch if Signed Flag Bit = 0
        `define BMI 4'd13 //Branch if Signed Flag Bit = 1


        input clk;
        output read;
        output write;
        output [numberOfAddressBits - 1 : 0] addressBus; 
        input  [numberOfDataBits - 1 : 0] dataBusInput;  //dataBusInput of processor is dataBusOutput of the memory.
        output reg [numberOfDataBits - 1 : 0] dataBusOutput; //dataBusOutput of processor is dataBusInput of memory.
        output chipSelect;    //Selects either memory or UART for the data transfer.



        reg [numberOfAddressBits - 1 : 0] programCounter;
        reg [numberOfAddressBits - 1 : 0] dataPointer;
        //Like the program counter stores the address of the next instruction, the dataPointer stores the 
        reg [instructionSize - 1 : 0] IR;
        reg [registerSize - 1 : 0] dataRegister;
        reg [numberOfRegisters - 1 : 0] registerBank [registerSize - 1 : 0];


        //defining some vector slices that we are going to use frequently in the program

        //we have a 5 bit opcode
        `define opcode IR[ 31 : 27 ]
        //since we have 32 registers, we will require 5 bits to address each of the registers uniquely
        //In case of binary arithematic instructions, we will require two operands and one destination register
        //Now these two operands needs to be specified in the instruction
        //The two operands can be specified by directly encoding the register addresses of two registers and these two registers contain the two 32 bit operands
        /*
            If we do this we will require 5 bits opcode + 5 bits for destination register + 5 bits for register operand 1 + 5 bits for register operand 2 = 20 bits.
            The instruction  is of 32 bits , so we still have (32 - 20 = 12) bits left. Now in this case where we are using the registers to specify both the operands,
            it is healthy practice for me to keep the remaining 12 bits as 0.
            But instead of wasting these bits, we can do something with these 12 bits.
            So what we can do is instead of specifying the second operand as a register, we can directly encode the second operand in the instruction.
             So 5 bits opcode + 5 bits destination register address + 5 bits operand register 1 address + 1 bit for specifying the second operand + remaining 
             16 bits for the second operand = 32 bits. This mode is called as immediate addressing mode where the operand is directly encoded in the instruction.
            Now the problem here is our machine is 32 bits so it works on the 32 bit operands.
            But the immediate operand inn the instruction is 16 bits. So we sign extend this immediate operand to 32 bits.
            Sign extending means padding the MSB of the immediate operand 16 times. So now our operand becomes 32 bits.
        
         */
        `define destinationRegister IR[ 26 : 22 ]
        `define operandReg1 IR[ 21 : 17 ] 
        `define operandReg2 IR[ 15 : 11 ]
        `define immediate16 IR[ 15 : 0 ]
        `define specifyOperandBit IR[16]

        `define conditionBits IR[ 26 : 23 ]
        /* In case of the conditional branch instructions, we need to specify a condition.
           If the condition is true, the processor will branch to some other instruction else the processor will continue the sequrntial execution.
           So the conditionBits is to define that condition. 
           Aside from the condition, in the conditional branch instrcutions we also require the address to which we want the processor to branch to if the condtion is true.
           So the address can be given in two ways
           Way 1 -
                Now since I am simulating this processor with a 32 MB memory, I am required to give a 25 bits address (32MB = 2^25) to the processor.
                So in the first way I can give this address, directly by specifying the register address in the instruction.
                The register will contain the address to the memory location where the branch is to be made.
                This is absolute addressing i.e. I am giving the address to which I want to branch to.

            Way 2 -
                The second way to specify the branch address is PC relative addressing.
                So, effectively, I am not giving the address directly in this method.
                I am going to specify an offset.
                The branch address is produced the following way from that offset encoded directly in to the instruction
                Branch address = PC +- offset.
                So I am branching with respect to the PC.
                We are going to use this method for specifying the branch address.
                Instruction division in case of branch instrcutions 
                5 bits opcode + 4 bits to specify the condition + remaining 23 bits to specify the offset = 32 bits
                Now since the value of PC is 25 bits and I am adding adding the offset (which is of 23 bits), I should sign extend
                the offset to 25 bits in order to perform addition.
            */
        `define offset   IR[ 22 : 0 ]

        
        /* Both the types of Jumps have the same opcode. 
           So in the jump instruction I need to reserve a bit such that the processor can identify whether just a jump is to be performed
           or on performing a jump, we have to return back (Jump and link instruction)*/
        `define linkBit IR[16] // This bit tells whether the instruction is jump or jump and link

        /* In the jump instruction we only make use of the absolute addressing i.e. I will directly mention the address to which a jump is to be 
           performed.  
           So what I will do is push the jump address inside a register and I will give that respective register address to the instruction
           In case of the jump and link instuction , I also have to provide a register in which I will store the return address.
           So for the jump instrcution
           5 bits opcode + 1 link bit + 5 bits for the register operand that contains the jump address +  remaining 21 bits preferably set to 0 = 32 bits.
           Also the register operand that contains the branch address will be operandRegister1 i.e. IR[15 : 11].
           For the jump and link instruction
           5 bits opcode + 5 bits for register operand that stores the return address + 1 link bit + 5 bits for register address that stores the jump address + 16 remaining bits preferably set to 0 = 32 bits*/
        `define returnAddressRegister IR[ 26 : 22]   // will be set to 00000(or dont care) in case of the jump instruction
                                                     // will be set to the respective register address that stores the return address in case of the jump and link instruction

        `define jumpAddressRegister IR[ 15 : 11]


        //For Load and Store instructions
        `define immediate22 IR[21 : 0]
        `define sourceRegister IR[26 : 22]

        //Defining the flag register bits
        reg C , Z , S , O;

        

        //I am definig the RUN reg just for the simulation purpose.
        //It is not a physical register in the processor.
        //It just tells whether the processor is ON or OFF.
        //when RUN = 0 -> the processor is OFF.
        //when RUN = 1 -> the processor is ON.
        //Also only the halt instruction (which stops the processor) can affect this register and make it to RUN = 0; 
        reg RUN;


        initial 
            begin
                //Initializing the RUN and the program counter.
                //making RUN = 1, indicating we are turning ON the processor.
                //BY default, when the processor turns ON, the contents of the PC are reset to 0;
                //This means that the program counter now points to the memory location 0000000H, which stores the reboot program.
                /* So the processor will start its execution from the instruction stored at 0000000H.
                   The PC value will be incremented per instruction fetched from the memory guarating a sequential execution if no branch or jump instruction is encountered.
                   However, if a branch or jump instrcution is encountered, the value of the PC will be updated accordingly.
                   ( PC <= Branch Address or Jump Address )
                   */

                RUN = 1;
                programCounter  <= 0;
                dataPointer     <= 0;
                C <= 0 ; Z <= 0 ; S <= 0 ; O <= 0;

                registerBank[5'b00001] = 32'h94eff659;
                registerBank[5'b00010] = 32'h3e4a3fb9;
                registerBank[5'b01111] = 32'h01741c28;


                while (RUN == 1) 
                    begin
                        fetchInstruction;
                        execute;
                    end

            
            end

        task fetchInstruction;
                begin
                        
                    #7 IR = dataBusInput; // I am delaying this statement until the dataBusInput gets the value.
                    printInstruction;
                    programCounter = programCounter + (instructionSize/8) ;
                    
                        
                end
        endtask

        task fetchData;
                begin
                    #7 dataRegister = dataBusInput;
                    printData;
                end
        endtask

        task writeMemory;
                begin
                    #2 dataBusOutput = dataRegister;
                end
        endtask


        task execute;
            begin
                case(`opcode)

                        `OR  :  begin
                                    if(`specifyOperandBit == 0)  
                                        begin 
                                            //The second operand is given by the register
                                            registerBank[`destinationRegister] = registerBank[`operandReg1] | registerBank[`operandReg2];
                                        end
                                    else 
                                        begin
                                            //The second operand is given by an immediate value
                                            registerBank[`destinationRegister] = registerBank[`operandReg1] | signExtend16Data( `immediate16 );
                                        end
                                    
                                    {S , Z} = setFlagBitsLogical(registerBank[`destinationRegister]);

                                    $display("The OR instrcution was just executed.");
                                    $display("The result is %h ." , registerBank[`destinationRegister]);
                                    $display("S = %b , Z = %b " , S , Z);
                                   
                                    
                                    
                                end

                        `AND  :  begin
                                    if(`specifyOperandBit == 0)  
                                        begin 
                                            //The second operand is given by the register
                                            registerBank[`destinationRegister] = registerBank[`operandReg1] & registerBank[`operandReg2];
                                        end
                                    else 
                                        begin
                                            //The second operand is given by an immediate value
                                            registerBank[`destinationRegister] = registerBank[`operandReg1] & signExtend16Data( `immediate16 );
                                        end
                                    
                                    {S , Z} = setFlagBitsLogical(registerBank[`destinationRegister]);

                                    $display("The AND instrcution was just executed.");
                                    $display("The result is %h ." , registerBank[`destinationRegister]);
                                    $display("S = %b , Z = %b " , S , Z);
                                end

                        `XOR  :  begin
                                    if(`specifyOperandBit == 0)  
                                        begin 
                                            //The second operand is given by the register
                                            registerBank[`destinationRegister] = registerBank[`operandReg1] ^ registerBank[`operandReg2];
                                        end
                                    else 
                                        begin
                                            //The second operand is given by an immediate value
                                            registerBank[`destinationRegister] = registerBank[`operandReg1] ^ signExtend16Data( `immediate16 );
                                        end
                                    
                                    {S , Z} = setFlagBitsLogical(registerBank[`destinationRegister]);

                                    $display("The XOR instrcution was just executed.");
                                    $display("The result is %h ." , registerBank[`destinationRegister]);
                                    $display("S = %b , Z = %b " , S , Z);
                                end

                        `NOT : begin
                                    registerBank[`destinationRegister] = ~ registerBank[`operandReg1];
                                    {S , Z} = setFlagBitsLogical(registerBank[`destinationRegister]);

                                    $display("The NOT instrcution was just executed.");
                                    $display("The result is %h ." , registerBank[`destinationRegister]);
                                    $display("S = %b , Z = %b " , S , Z);
                               end

                        `NOP : begin
                                    //This instruction does nothing.
                                    //The reason why we define such a instrcution is to produce a software delay.
                                    //The processor wastes its time to fetch this instruction and hence this buys us some time.
                               end

                        `Bxx : begin

                                    case(`conditionBits)
                                        
                                        `BRA : begin
                                                    //In this case, the processor will always branch since their is no condition tested.
                                                    programCounter = programCounter + signExtend23Address(`offset);
                                               end

                                        `BCC : begin
                                                    //In this case, the processor will branch only if carry flag = 0;
                                                    if(C == 0)
                                                        programCounter = programCounter + signExtend23Address(`offset);       
                                               end
                                        
                                        `BCS : begin
                                                    //In this case, the processor will branch only if the carry flag = 1;
                                                    if(C == 1)
                                                        programCounter = programCounter + signExtend23Address(`offset);

                                               end
                                        
                                        `BOC : begin
                                                    //In this case, the processor will branch only if the overflow flag = 0;
                                                    if(O == 0)
                                                        programCounter = programCounter + signExtend23Address(`offset);
                                               end
                                        
                                        `BOS : begin
                                                    //In this case, the processor will barnch only if the overflow flag = 1;
                                                    if(O == 1)
                                                        programCounter = programCounter + signExtend23Address(`offset);


                                               end
                                        
                                        `BEQ : begin
                                                    //In this case, the processor will jump only if the zero flag = 1;
                                                    if( Z == 1)
                                                        programCounter = programCounter + signExtend23Address(`offset);
                                               end

                                        `BNE : begin
                                                    //In this case, the processor will branch only if zero flag = 0;
                                                    if( Z == 0)
                                                        programCounter = programCounter + signExtend23Address(`offset);
                                               end
                                        
                                        //Before using this comparison types of branch instructions, we must execute the compare instrcution so that it can affect the flags.
                                        `BGE : begin
                                                     
                                                    //In this case, the processor will branch only if op1 >= op2 in the Compare instrcution.
                                                    //in cmp op1, op2; op1 - op2 happens
                                                    if( Z | ( ~S & ~O) | (S & O) )
                                                        programCounter = programCounter + signExtend23Address(`offset);

                                               end    

                                        `BLT : begin
                                                    //In this case, the processor will branch if op1 < op2
                                                    if( (S & ~O) | ( ~S & O) )
                                                        programCounter = programCounter + signExtend23Address(`offset);

                                               end 

                                        `BGT : begin
                                                    //In this case, the processor will branch if op1 > op2
                                                    if( ~Z & (( ~S & ~O) | (S & O )) )
                                                        programCounter = programCounter + signExtend23Address(`offset);

                                               end  

                                        `BLE : begin
                                                    //In this case, the processor will branch if op1 <= op2
                                                    if( Z | (S & ~O) | (~S & O))
                                                        programCounter = programCounter + signExtend23Address(`offset);

                                               end
                                        
                                        `BPL : begin
                                                    //In this case, the processor will branch only if Signed Flag = 0
                                                    if( S == 0)
                                                        programCounter = programCounter + signExtend23Address(`offset);
                                                


                                               end
                                        
                                        `BMI : begin
                                                    //In this case, the processor will branch only if Signed Flag = 1
                                                    if( S == 1)
                                                        programCounter = programCounter + signExtend23Address(`offset);

                                               end

                                                                     


                                               
                                    endcase
                               end

                        `JMP : begin

                                    if(`linkBit == 0) 
                                        begin
                                            //Normal jump 
                                            programCounter = registerBank[`operandReg2];
                                            $display("program Counter : %h" , programCounter);
                                            $display("The jump instruction was just executed.");
                                        end
                                    else
                                        begin
                                            //Jump and store the return address
                                            registerBank[`destinationRegister] = programCounter;
                                            programCounter = registerBank[`operandReg2];
                                            $display("Link register : %h" , registerBank[`destinationRegister]);
                                            $display("The jump and link instruction was just executed.");
                                        end
                               end


                        `LDI : begin  

                                    registerBank[`destinationRegister] = signExtend22Data( `immediate22 );
                                    $display("The load immediate instrcution was just executed.");
                                    $display("The destination register is %h", `destinationRegister);
                                    $display("The value loaded into the destination register is %h" , registerBank[`destinationRegister]);

                               end
                        
                        `LD : begin
                                    dataPointer  = signExtend22Address( `immediate22 );
                                    fetchData;
                                    registerBank[`destinationRegister] = dataRegister;
                                    $display("The load direct instruction was just executed.");
                                    $display("The data loaded in the destination register is %h", registerBank[`destinationRegister]);
                               end

                        `LDX : begin

                                    dataPointer = registerBank[`operandReg1];
                                    fetchData;
                                    registerBank[`destinationRegister] = dataRegister;
                                    $display("The load indexed instruction was just executed.");
                                    $display("The data loaded in the destination register is %h", registerBank[`destinationRegister]);
                               end

                        `ST  : begin
                                    dataPointer = signExtend22Address( `immediate22 );
                                    dataRegister = registerBank[`sourceRegister]; 
                                    writeMemory;
                               end

                        `STX : begin
                                    dataPointer = registerBank[`operandReg1];
                                    dataRegister = registerBank[`sourceRegister];
                                    writeMemory;
                                    $display("The store indexed instruction was just executed.");
                               end
                        
                              

                        `HLT : begin
                                    RUN = 0;
                                    $display("The Halt instruction was just executed.");
                               end

                        default : begin
                                        $display("Illegal opcode.");
                                   end
                        
                    
                endcase
            end
        endtask



        function [registerSize - 1 : 0] signExtend16Data;
            input [15 : 0] immediateValue;
            begin
                signExtend16Data = {  {16{immediateValue[15]}} , immediateValue };
            end
        endfunction



        /*In this sign extension function, I will only allow the sign extension upto 25 bits since the return value of this function 
          will be an offset that will be added to the value of the program counter to calculate the branch address. */
        function [numberOfAddressBits - 1 : 0 ] signExtend23Address;
            input [22 : 0] offset;
            begin
                signExtend23Address = { { 2{offset[22]} } , offset };
            end
        endfunction


        //The below sign extend function will be used in the load immediately instrcution
        //It extends a 22 bit number to a 32 bit number.
        function [registerSize - 1 : 0] signExtend22Data;
            input [21 : 0] value;
            begin
                signExtend22Data = { { 10{value[21]}} , value};
            end
        endfunction

        //The below sign extend function will be used in the load direct instruction where address is directly encoded in the instruction.
        //The data that is to be loaded in the destination register is to be loaded in this address
        function [numberOfAddressBits - 1 : 0] signExtend22Address;
            input [21 : 0] address;
            begin
                signExtend22Address = { {3{address[21]}} , address};
            end
        endfunction


        //The logical instructions can set only the signed flag and the zero flag
        function [1 : 0] setFlagBitsLogical;
            input [registerSize - 1 : 0 ] result;
            begin
                //The function returns the value {S , Z};
                //The signed flag is simply the MSB of the result.
                //The Zero flag is 0 if at least a single a bit in the result is 1;
                setFlagBitsLogical = { result[registerSize - 1] , ~ (|result)};
            end
        endfunction


        task printInstruction;
                begin
                    $display("The instrcution fetched from the memory is %h ", IR);
                end
        endtask

        task printData;
                begin
                    $display("The data fetched from the memory is %h ", dataRegister );
                end
        endtask


endmodule