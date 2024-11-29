
`timescale 1ns / 1ps

module IF_ID(clk, reset, PC_out, Instruction, IF_ID_PC_out, IF_ID_Instruction, IF_ID_Write); 
input clk, reset, IF_ID_Write; 
input [63:0] PC_out;
input [31:0] Instruction; 
output reg [63:0] IF_ID_PC_out; 
output reg [31:0] IF_ID_Instruction; 



always @ (posedge clk) begin
    if (reset == 1)     //reset values to 0 if reset 1
        begin
            IF_ID_Instruction <= 0; 
            IF_ID_PC_out <= 0;
        end
    else if (IF_ID_Write == 0) //for nop bcs of load
        begin
            IF_ID_PC_out <= IF_ID_PC_out; 
            IF_ID_Instruction <= IF_ID_Instruction;
        end
    else                //continue
        begin
            IF_ID_Instruction <= Instruction; 
            IF_ID_PC_out <= PC_out;
        end
end
endmodule
