
`timescale 1ns / 1ps

module MEM_WB(clk, reset, 

EXM_RegWrite, EXM_MemToReg, 
ReadData, EXM_ALUResult, EXM_rd, 

MWB_RegWrite, MWB_MemToReg, 
MWB_ReadData, MWB_ALUResult, MWB_rd  
);

input clk, reset, EXM_RegWrite, EXM_MemToReg; 
input [63:0] EXM_ALUResult,ReadData; 
input [4:0] EXM_rd;
output reg MWB_RegWrite, MWB_MemToReg; 
output reg [63:0]  MWB_ALUResult,MWB_ReadData; 
output reg [4:0] MWB_rd; 
  always @(posedge clk) 
  begin

    if(reset)
          
            begin
                MWB_RegWrite <= 0;
                MWB_rd <= 0;
                MWB_ALUResult <= 0;
                MWB_MemToReg <= 0;
                MWB_ReadData <= 0;
            end

         else
            begin
                MWB_RegWrite <= EXM_RegWrite;
                MWB_rd <= EXM_rd;
                MWB_ALUResult <= EXM_ALUResult;
                MWB_MemToReg <= EXM_MemToReg;
                MWB_ReadData <= ReadData;
               
               
            end

end
endmodule
