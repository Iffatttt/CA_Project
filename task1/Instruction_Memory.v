`timescale 1ns / 1ps

module instruction_memory(
input [63:0] Instr_Addr,
output reg [31:0] Instruction
);

reg [7:0] Inst_memory [92:0];
initial begin   //bubble sort
{Inst_memory[3], Inst_memory[2], Inst_memory[1], Inst_memory[0]} = 32'h00500593; // addi x11 x0 5
{Inst_memory[7], Inst_memory[6], Inst_memory[5], Inst_memory[4]} = 32'h04058863; // beq x11 x0 80
{Inst_memory[11], Inst_memory[10], Inst_memory[9], Inst_memory[8]} = 32'h00000613; // addi x12 x0 0
{Inst_memory[15], Inst_memory[14], Inst_memory[13], Inst_memory[12]} = 32'h04c5c463	; // blt x11 x12 72

{Inst_memory[19], Inst_memory[18], Inst_memory[17], Inst_memory[16]} = 32'h04b60263; // beq x12 x11 68
{Inst_memory[23], Inst_memory[22], Inst_memory[21], Inst_memory[20]} = 32'h000606b3; // add x13 x12 x0

{Inst_memory[27], Inst_memory[26], Inst_memory[25], Inst_memory[24]} = 32'h02d5ca63; // blt x11 x13 52
{Inst_memory[31], Inst_memory[30], Inst_memory[29], Inst_memory[28]} = 32'h02b68863; // beq x13 x11 48
{Inst_memory[35], Inst_memory[34], Inst_memory[33], Inst_memory[32]} = 32'h00361393; // slli x7 x12 3
{Inst_memory[39], Inst_memory[38], Inst_memory[37], Inst_memory[36]} = 32'h0003b283; // lw x5 0(x7)
{Inst_memory[43], Inst_memory[42], Inst_memory[41], Inst_memory[40]} = 32'h00369813	; // slli x16 x13 3
{Inst_memory[47], Inst_memory[46], Inst_memory[45], Inst_memory[44]} = 32'h00083c03; // lw x24 0(x16)
{Inst_memory[51], Inst_memory[50], Inst_memory[49], Inst_memory[48]} = 32'h0182ca63; // blt x5 x24 20
{Inst_memory[55], Inst_memory[54], Inst_memory[53], Inst_memory[52]} = 32'h01828863; // beq x5 x24 16
{Inst_memory[59], Inst_memory[58], Inst_memory[57], Inst_memory[56]} = 32'h00028713; //addi x14 x5 0
{Inst_memory[63], Inst_memory[62], Inst_memory[61], Inst_memory[60]} = 32'h0183b023; // sw x24 0(x7)
{Inst_memory[67], Inst_memory[66], Inst_memory[65], Inst_memory[64]} = 32'h00e83023	; //sw x14 0(x16)
{Inst_memory[71], Inst_memory[70], Inst_memory[69], Inst_memory[68]} = 32'h00168693	; //addi x13 x13 1
{Inst_memory[75], Inst_memory[74], Inst_memory[73], Inst_memory[72]} = 32'hfc0008e3; // beq x0 x0 -48

{Inst_memory[79], Inst_memory[78], Inst_memory[77], Inst_memory[76]} = 32'h00160613; // addi x12 x12 1
{Inst_memory[83], Inst_memory[82], Inst_memory[81], Inst_memory[80]} = 32'hfa000ee3; // beq x0 x0 -68

end

always @(Instr_Addr)

begin
Instruction[31:24] <= Inst_memory[Instr_Addr + 3];
Instruction[23:16] <= Inst_memory[Instr_Addr + 2];
Instruction[15:8] <= Inst_memory[Instr_Addr + 1];
Instruction[7:0] <= Inst_memory[Instr_Addr];

end
endmodule