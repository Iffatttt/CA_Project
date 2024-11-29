`timescale 1ns / 1ps

module MEM_WB(clk, reset, EXM_RegWrite, EXM_MemToReg, ReadData, EXM_ALUResult, EXM_rd, // inputs
MWB_RegWrite, MWB_MemToReg, MWB_ReadData, MWB_ALUResult, MWB_rd  //ouputs
);

input clk, reset, EXM_RegWrite, EXM_MemToReg; 
input [4:0] EXM_rd; 
input [63:0] ReadData, EXM_ALUResult; 

output reg MWB_RegWrite, MWB_MemToReg; 
output reg [4:0] MWB_rd; 
output reg [63:0] MWB_ReadData, MWB_ALUResult; 

  always @(posedge clk) begin

   if(reset)
           //reset 1
            begin
                MWB_RegWrite <= 0;
                MWB_MemToReg <= 0;
                MWB_ReadData <= 0;
                MWB_ALUResult <= 0;
                MWB_rd <= 0;
            end

         else // reset 0
            begin
                MWB_RegWrite <= EXM_RegWrite;
                MWB_MemToReg <= EXM_MemToReg;
                MWB_ReadData <= ReadData;
                MWB_ALUResult <= EXM_ALUResult;
                MWB_rd <=  EXM_rd;
            end
   
end
endmodule