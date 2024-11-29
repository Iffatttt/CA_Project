`timescale 1ns / 1ps

module immediate_generator(instruction,imm_data);

input [31:0] instruction; 
output reg [63:0] imm_data; 

wire [1:0]opcode;
assign opcode = instruction[6:5];
    
always @(instruction) begin

if (opcode==2'b00) // I type
imm_data[11:0] <= instruction[31:20];

else if (opcode==2'b01) begin // S type
imm_data[4:0] <= instruction[11:7];
imm_data[11:5] <= instruction[31:25]; 
end

else if (opcode==2'b11) begin// SB type
imm_data[11] <= instruction[31];
imm_data[3:0] <= instruction[11:8];
imm_data[9:4] <= instruction[30:25];
imm_data[10] <= instruction[7];
end

else // default 
imm_data <= 64'h0000000000000000;
end

always @(*) begin
//sign extension

if (instruction[31] == 1)
imm_data[63:12] <= 52'hfffffffffffff; 

else
imm_data[63:12] <= 52'b0;

end
endmodule