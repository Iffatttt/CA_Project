`timescale 1ns / 1ps

module ALU_Control(ALUOp, Funct, operation);

input [1:0] ALUOp;
input [3:0] Funct;
output reg [3:0] operation;

always @(*) begin

if(ALUOp==2'b00) begin //if ALUOp ==00:
    case(Funct[2:0])
    4'b001:
  operation= 4'b1000; //slli
  default: 
  operation=4'b0010;
  endcase
end
else if (ALUOp == 2'b01) begin //if ALUOp ==01:
 operation= 4'b0110;
end
//if ALUOp ==10, check Funct:
else if (ALUOp == 2'b10 && Funct==4'b0000) begin
 operation = 4'b0010;
end
else if (ALUOp == 2'b10 && Funct==4'b1000) begin
 operation = 4'b0110;
end
else if (ALUOp == 2'b10 && Funct==4'b0111) begin
 operation = 4'b0000;
end
else if (ALUOp == 2'b10 && Funct==4'b0110)begin
 operation = 4'b0001;
end
end

endmodule