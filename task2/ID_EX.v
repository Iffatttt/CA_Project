
`timescale 1ns / 1ps

module ID_EX (clk, reset, RegWrite, MemRead, MemToReg, MemWrite, Branch, ALUOp, ALUSrc, IFID_PC_out, 
ReadData1, ReadData2, imm_data, rs1, rs2, rd, Funct, // inputs
IDEX_RegWrite, IDEX_MemRead, IDEX_MemToReg, IDEX_MemWrite, IDEX_Branch, IDEX_ALUOp, IDEX_ALUSrc,// outputs
IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2, IDEX_imm_data, IDEX_rs1, IDEX_rs2, IDEX_rd, IDEX_Funct); 

input clk, reset, RegWrite, MemRead, MemToReg, MemWrite, Branch, ALUSrc; 
input [1:0] ALUOp;  
input [3:0] Funct; 
input [4:0] rs1, rs2, rd;
input [63:0] IFID_PC_out, ReadData1, ReadData2, imm_data;

output reg IDEX_RegWrite, IDEX_MemRead, IDEX_MemToReg, IDEX_MemWrite, IDEX_Branch, IDEX_ALUSrc; 
output reg [1:0] IDEX_ALUOp;  
output reg [3:0] IDEX_Funct; 
output reg [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd ; 
output reg [63:0] IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2, IDEX_imm_data;


always @(posedge clk) begin
    
    if (reset)
    
         // when reset 1
        begin
            IDEX_RegWrite <= 0;
            IDEX_MemRead <= 0;
            IDEX_MemToReg <= 0;
            IDEX_MemWrite <= 0;
            IDEX_Branch <= 0;
            IDEX_ALUSrc <= 0;
            IDEX_ALUOp <= 0;
            IDEX_Funct <= 0; 
            IDEX_rs1 <= 0;
            IDEX_rs2 <= 0;
            IDEX_rd <= 0; 
            IDEX_PC_out <= 0;
            IDEX_ReadData1 <= 0; 
            IDEX_ReadData2 <= 0; 
            IDEX_imm_data <= 0; 
           
        end
        
        else // when reset is 0
        begin
            IDEX_RegWrite <= RegWrite;
            IDEX_MemRead <= MemRead;
            IDEX_MemToReg <= MemToReg;
            IDEX_MemWrite <= MemWrite;
            IDEX_Branch <= Branch;
            IDEX_ALUSrc <= ALUSrc;
            IDEX_ALUOp <= ALUOp;
            IDEX_Funct <= Funct;
            IDEX_rs1 <= rs1;
            IDEX_rs2 <= rs2;
            IDEX_rd <= rd;
            IDEX_PC_out <= IFID_PC_out;
            IDEX_ReadData1 <= ReadData1;
            IDEX_ReadData2 <= ReadData2;
            IDEX_imm_data <= imm_data;
           
        end     
    
      
end
endmodule