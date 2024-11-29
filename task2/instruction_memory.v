`timescale 1ns / 1ps

module instruction_memory(
input [63:0] Instr_Addr,
output reg [31:0] Instruction
);

reg [7:0] Inst_memory [48:0];
initial begin   //testing pipeline processor
{Inst_memory[3], Inst_memory[2], Inst_memory[1], Inst_memory[0]} = 32'h00e68633; // add x12 x13 x14
{Inst_memory[7], Inst_memory[6], Inst_memory[5], Inst_memory[4]} = 32'h40e68633; // sub x12 x13 x14
{Inst_memory[11], Inst_memory[10], Inst_memory[9], Inst_memory[8]} = 32'h00371613; //slli x12 x14 3
{Inst_memory[15], Inst_memory[14], Inst_memory[13], Inst_memory[12]} = 32'h00100613; // addi x12 x0 1

{Inst_memory[19], Inst_memory[18], Inst_memory[17], Inst_memory[16]} = 32'h00003703; // ld x14 0(x0)
{Inst_memory[23], Inst_memory[22], Inst_memory[21], Inst_memory[20]} = 32'h00d03023; // sd x13 0(x0)

{Inst_memory[27], Inst_memory[26], Inst_memory[25], Inst_memory[24]} = 32'h00f78463	; // beq x15 x15 8
{Inst_memory[31], Inst_memory[30], Inst_memory[29], Inst_memory[28]} = 32'h00200793; // addi x15 x0 2
{Inst_memory[35], Inst_memory[34], Inst_memory[33], Inst_memory[32]} = 32'h00f6c463	; //blt x13 x15 8
{Inst_memory[39], Inst_memory[38], Inst_memory[37], Inst_memory[36]} = 32'h00400693; //addi x13 x0 4

end

always @(Instr_Addr)

begin
Instruction[31:24] <= Inst_memory[Instr_Addr + 3];
Instruction[23:16] <= Inst_memory[Instr_Addr + 2];
Instruction[15:8] <= Inst_memory[Instr_Addr + 1];
Instruction[7:0] <= Inst_memory[Instr_Addr];

end
endmodule