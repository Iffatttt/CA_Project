`timescale 1ns / 1ps

module RISC_V_Processor(
    input clk, 
    input reset
    );
    //program counter
    wire [63:0] PC_in, PC_out;
    // IF_ID 
    wire [63:0] IF_ID_PC_out;
    wire [31:0] IF_ID_Instruction;
    //instruction
    wire [31:0] Instruction;
    wire [6:0] opcode, funct7; 
    wire [2:0] funct3;  
    wire [4:0] rs1, rs2, rd;
    wire [3:0] Operation, Funct;
    wire [1:0] ALUOp;
    wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, Zero, Branch;
    wire [63:0] ReadData1, ReadData2;
    //immediate
    wire [63:0] shifted_data, Data_Out, Out1, Adder_out;
    //IDEX
    wire IDEX_RegWrite, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_Branch, IDEX_ALUSrc; 
    wire [1:0] IDEX_ALUOp; 
    wire [63:0] IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2, IDEX_ImmData; 
    wire [3:0] IDEX_Funct; 
    wire [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd ; 
    //imm
      wire [63:0] ImmData;
    // Branch Hazard 
    wire branch_and_zero;
    wire a_bgt_b, branch_zero;
    // EX_MEM 
    wire  EXM_RegWrite, EXM_MemRead, EXM_MemtoReg, EXM_MemWrite, EXM_Branch, EXM_Zero; 
    wire [4:0] EXM_rd;
    wire [63:0] EXM_Adder_out, EXM_ALUResult, EXM_ReadData2;
    //Data Memory 
    wire [63:0] array0,array1,array2,array3,array4; 
     wire [63:0] ReadData;
    //alu
    wire [63:0]  ALUResult; 
    //Register File
    wire [63:0] r2,r3,r4,r5;
    wire [63:0] WriteData;
    // MEM_WB 
    wire MWB_RegWrite, MWB_MemtoReg;
    wire [4:0] MWB_rd;
    wire [63:0] MWB_ReadData, MWB_ALUResult; 
    // Forwarding
     wire [63:0] Forward_A_Output, Forward_B_Output;
    wire [1:0] Forward_A, Forward_B;
    // hazard detection
    wire IDEX_Control_Mux_Out, IF_ID_Write, PCWrite;  

   
    program_counter pc(clk, reset, PC_in, PC_out, PCWrite); //pc_write coming from hazard det unit

    adder addr(64'd4, PC_out, Out1);
    
    assign branch_and_zero = EXM_Zero & EXM_Branch;
    mux2to1 mux1(Out1, EXM_Adder_out, branch_and_zero, PC_in);
    
    
    instruction_memory instmem(PC_out, Instruction); 
    
    IF_ID pipereg1(clk, branch_and_zero, PC_out, Instruction, IF_ID_PC_out, IF_ID_Instruction, IF_ID_Write); //branch_and_zero = reset
    
    instruction_parser parser(IF_ID_Instruction, opcode, rd, funct3, rs1, rs2, funct7); 
    
    assign Funct = {IF_ID_Instruction[30],IF_ID_Instruction[14:12]};
    
    hazard_detection ld(IDEX_rd, rs1, rs2, IDEX_MemRead,
                                IDEX_Control_Mux_Out, IF_ID_Write, PCWrite);
    
    immediate_generator immgen(IF_ID_Instruction, ImmData);
    
    Control_unit cu(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, IDEX_Control_Mux_Out); // Mux Inside
     
    registerFile regfile(WriteData, rs1, rs2, MWB_rd, MWB_RegWrite, clk, reset, ReadData1, ReadData2, 
    r2,r3,r4,r5);
    
    ID_EX regpipe2(clk, branch_and_zero,  RegWrite, MemRead, MemtoReg, MemWrite, Branch, ALUOp, ALUSrc,  IF_ID_PC_out, ReadData1, ReadData2, ImmData, rs1, rs2, rd, Funct, 
  IDEX_RegWrite, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_Branch, IDEX_ALUOp, IDEX_ALUSrc, IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2, IDEX_ImmData, IDEX_rs1, IDEX_rs2, IDEX_rd, IDEX_Funct); 
                    
    assign shifted_data = IDEX_ImmData << 1;
    adder branch(IDEX_PC_out, shifted_data, Adder_out); 
    
    forwarding_unit fu(IDEX_rs1, IDEX_rs2, EXM_rd, EXM_RegWrite, MWB_rd, MWB_RegWrite, Forward_A, Forward_B);
    
    mux3to1 f_a(IDEX_ReadData1, WriteData, EXM_ALUResult, Forward_A, Forward_A_Output);
    
    mux3to1 f_b(IDEX_ReadData2, WriteData, EXM_ALUResult, Forward_B, Forward_B_Output);
    
    mux2to1 mux2(Forward_B_Output, IDEX_ImmData, IDEX_ALUSrc, Data_Out);
    
    ALU_Control ac(IDEX_ALUOp, IDEX_Funct, Operation);
    
    ALU_64_bit alu(Forward_A_Output, Data_Out, Operation, ALUResult, Zero, a_bgt_b);
    assign branch_zero = IDEX_Funct[2] ? a_bgt_b : Zero; //funct[2] if 1 then for greater or less than branch
    
    EX_MEM regpipe3(clk, branch_and_zero,IDEX_RegWrite, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_Branch, 
    Adder_out, ALUResult, branch_zero, Forward_B_Output, IDEX_rd,  EXM_RegWrite, EXM_MemRead, EXM_MemtoReg, EXM_MemWrite, EXM_Branch,  EXM_Adder_out, EXM_ALUResult, EXM_Zero, EXM_ReadData2, EXM_rd);
  
    data_memory dm(EXM_ALUResult, EXM_ReadData2,clk, EXM_MemWrite, EXM_MemRead, ReadData,array0,array1,array2,array3,array4);
    
    MEM_WB pipereg4(clk, 1'b0,EXM_RegWrite, EXM_MemtoReg, ReadData, EXM_ALUResult, EXM_rd, MWB_RegWrite, MWB_MemtoReg,MWB_ReadData, MWB_ALUResult, MWB_rd  );
    
    // Write back mux
    mux2to1 mux3(MWB_ALUResult, MWB_ReadData, MWB_MemtoReg, WriteData);
    
endmodule
