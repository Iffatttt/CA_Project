`timescale 1ns / 1ps

module EX_MEM(clk, reset, IDEX_RegWrite, IDEX_MemRead, IDEX_MemToReg, 
IDEX_MemWrite, IDEX_Branch,  // inputs
Adder_out, ALU_Result, zero, IDEX_ReadData2, IDEX_rd, 
EXM_RegWrite, EXM_MemRead, EXM_MemToReg, EXM_MemWrite, EXM_Branch, EXM_Adder_out, // outputs
EXM_ALU_Result, EXM_zero, EXM_ReadData2, EXM_rd); 

input clk, reset, IDEX_RegWrite, IDEX_MemRead, IDEX_MemToReg, IDEX_MemWrite, IDEX_Branch, zero; 
input [4:0] IDEX_rd; 
input [63:0] Adder_out, ALU_Result, IDEX_ReadData2; 

output reg  EXM_RegWrite, EXM_MemRead, EXM_MemToReg, EXM_MemWrite, EXM_Branch, EXM_zero;  
output reg [63:0] EXM_Adder_out, EXM_ALU_Result, EXM_ReadData2; 

output reg [4:0] EXM_rd;


always @(posedge clk) begin
        if (reset)
        // reset 1
        begin
            EXM_RegWrite <= 0;
            EXM_MemRead <= 0;
            EXM_MemToReg <= 0;
            EXM_MemWrite <= 0;
            EXM_Branch <= 0;
            EXM_zero <= 0;
            EXM_ALU_Result <= 0;
            EXM_ReadData2 <= 0;
            EXM_rd <= 0;
            EXM_Adder_out <= 0;
        end

        else // reset0 
        begin
            EXM_RegWrite <= IDEX_RegWrite;
            EXM_MemRead <= IDEX_MemRead;
            EXM_MemToReg <= IDEX_MemToReg;
            EXM_MemWrite <= IDEX_MemWrite;
            EXM_Branch <= IDEX_Branch;
            EXM_zero <= zero;
            EXM_ALU_Result <= ALU_Result;
            EXM_ReadData2 <= IDEX_ReadData2;
            EXM_rd <= IDEX_rd;
            EXM_Adder_out <= Adder_out;
        end
   
end
endmodule