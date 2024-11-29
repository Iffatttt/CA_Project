`timescale 1ns / 1ps

module Control_unit(opcode, ALUop, Branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite);
input [6:0]opcode;
output reg Branch;
output reg MemRead;
output reg MemtoReg;
output reg [1:0]ALUop;
output reg MemWrite;
output reg ALUsrc;
output reg RegWrite;
   

 always @(*) begin  
if (opcode==7'b0110011) begin //first case of R-Type
 ALUsrc<=0;
 MemtoReg<=0;
 RegWrite<=1;
 MemRead<=0;
 MemWrite<=0;
 Branch<=0;
 ALUop<=2'b10;
end
else if (opcode==7'b0000011) begin  //I-Type
 ALUsrc<=1;
 MemtoReg<=1;
 RegWrite<=1;
 MemRead<=1;
 MemWrite<=0;
 Branch<=0;
 ALUop<=2'b00;
end
else if(opcode==7'b0100011)begin  //S-Type
 MemtoReg<=1'bX;
 ALUsrc<=1;
 RegWrite<=0;
 MemRead<=0;
 MemWrite<=1;
 Branch<=0;
 ALUop<=2'b00;
end
else if(opcode==7'b1100011) begin //SB-Type
 MemtoReg<=1'bX;
 ALUsrc<=0;
 RegWrite<=0;
 MemRead<=0;
 MemWrite<=0;
 Branch<=1;
 ALUop<=2'b01;
end
else if(opcode==7'b0010011) begin //addi
 ALUsrc<=1;
 MemtoReg<=0;
 RegWrite<=1;
 MemRead<=0;
 MemWrite<=0;
 Branch<=0;
 ALUop<=2'b00;
 end
 
else begin //default
ALUsrc<=0;
 MemtoReg<=0;
 RegWrite<=0;
 MemRead<=0;
 MemWrite<=0;
 Branch<=0;
 ALUop<=2'b00;

end
end
endmodule