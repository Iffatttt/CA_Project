`timescale 1ns / 1ps

module RISC_V_Pipeline(
    input clk, 
    input reset
    );

    //program counter
    wire [63:0] PC_in, PC_out;
    
    //reg file
    wire [63:0] ReadData1, ReadData2, WriteData;
    // registers values
    wire [63:0] r2,r3,r4;
   
    //immediate
    wire [63:0] ImmData, shifted_data;
     
     //alu
    wire [63:0] ALUResult; 
    
    //adders
    wire [63:0] mux2out, Addt, Adder_out;
    
    //control unit
    wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc, zero, Branch, BranchSelect ; 
    
    // IF_ID 
    wire [63:0] IFID_PC_out;
    wire [31:0] IFID_instruction;
    
    // ID_EX 
    wire IDEX_RegWrite, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_Branch, IDEX_ALUSrc; 
    wire [1:0] IDEX_ALUOp; 
    wire [63:0] IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2, IDEX_ImmData; 
    wire [3:0] IDEX_Funct;
    wire [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd ; 
    
    // EX_MEM 
    wire  EXM_RegWrite, EXM_MemRead, EXM_MemtoReg, EXM_MemWrite, EXM_Branch, EXM_zero; 
    wire [4:0] EXM_rd; 
    wire [63:0] EXM_Adder_out, EXM_ALUResult, EXM_ReadData2;

    //instruction mem and parser
    wire [31:0] instruction;
    wire [6:0] opcode, funct7; 
    wire [2:0] funct3;  
    wire [4:0] rs1, rs2, rd;
    wire [3:0] Operation, Funct;
    wire [1:0] ALUOp;
    
    // MEM_WB 
    wire MWB_RegWrite, MWB_MemtoReg; 
    wire [4:0] MWB_rd; 
    wire [63:0] MWB_ReadData, MWB_ALUResult; 
    
        //data memory
     wire [63:0] ReadData;
      // array in data memory
    wire [63:0] array0,array1,array2,array3,array4;
    
    //PC
    program_counter PC(clk, reset, PC_in, PC_out);
    
   //first adder
    adder pc_add(PC_out,64'd4, Addt);
    
    //mux if branch or not
    mux2to1 mux1(Addt, EXM_Adder_out, (EXM_Branch & EXM_zero), PC_in);
    
    //instruction memory
    instruction_memory inst(PC_out, instruction); 
    
    //IF_ID pipeline reg
    IF_ID pipe_reg1(clk, reset, PC_out, instruction, IFID_PC_out, IFID_instruction);
      
    assign Funct = {IFID_instruction[30],IFID_instruction[14:12]};
    //instruction parser
    instruction_parser parser(IFID_instruction, opcode, rd, funct3, rs1, rs2, funct7);
    
    //imm generator
    immediate_generator imm(IFID_instruction, ImmData);
    
    //reg file
    registerFile rf(WriteData, rs1, rs2, MWB_rd, MWB_RegWrite, clk, reset, ReadData1, ReadData2, r2,r3,r4);
    
    //control unit
    Control_unit cu(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
    
    //branch unit
    Branch_Unit bu(funct3, ReadData1, ReadData2, BranchSelect);
    
    //ID_EX pipeline reg
    ID_EX pipe_reg2(clk, reset, RegWrite, MemRead, MemtoReg, MemWrite, Branch, ALUOp, ALUSrc, IFID_PC_out, 
    ReadData1, ReadData2, ImmData, rs1, rs2, rd, Funct, IDEX_RegWrite, IDEX_MemRead, IDEX_MemtoReg, 
    IDEX_MemWrite, IDEX_Branch, IDEX_ALUOp, IDEX_ALUSrc, IDEX_PC_out, IDEX_ReadData1, IDEX_ReadData2,
     IDEX_ImmData, IDEX_rs1, IDEX_rs2, IDEX_rd, IDEX_Funct); 
                    
    // imm
    assign shifted_data = IDEX_ImmData << 1;
    
    //second adder
    adder add2(IDEX_PC_out, shifted_data, Adder_out); 
    
    //mux for readdata2 vs immediate
    mux2to1 mux2(IDEX_ReadData2, IDEX_ImmData, IDEX_ALUSrc, mux2out);
    
    //alu control
    ALU_Control ALUC(IDEX_ALUOp, IDEX_Funct, Operation);
    
    //alu
    ALU_64_bit ALU(IDEX_ReadData1, mux2out, Operation, ALUResult, zero);
    
    //EX_MEM pipeline reg
    EX_MEM pipe_reg3(clk, reset, IDEX_RegWrite, IDEX_MemRead, IDEX_MemtoReg, IDEX_MemWrite, IDEX_Branch, 
      Adder_out, ALUResult, BranchSelect, IDEX_ReadData2, IDEX_rd,  EXM_RegWrite, EXM_MemRead, 
      EXM_MemtoReg, EXM_MemWrite, EXM_Branch, EXM_Adder_out, EXM_ALUResult, EXM_zero, EXM_ReadData2, EXM_rd );
    
    //data memory
    data_memory dm(EXM_ALUResult, EXM_ReadData2, clk, EXM_MemWrite, EXM_MemRead, ReadData,array0,array1,array2,array3,array4);
    
    //MEM_WB pipeline reg
    MEM_WB pipe_reg4(clk, reset, EXM_RegWrite, EXM_MemtoReg, ReadData, EXM_ALUResult, EXM_rd, 
    MWB_RegWrite, MWB_MemtoReg, MWB_ReadData, MWB_ALUResult, MWB_rd  );
    
    // Write back mux
    mux2to1 mux3(MWB_ALUResult, MWB_ReadData, MWB_MemtoReg, WriteData);
    
endmodule