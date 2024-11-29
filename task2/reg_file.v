`timescale 1ns / 1ps

module registerFile(WriteData, rs1, rs2, rd, RegWrite,clk,reset,ReadData1,ReadData2,r2,r3,r4 );
    input [63:0] WriteData;
    input [4:0] rs1;
    input [4:0] rs2;
    input [4:0] rd;
    input RegWrite;
    input clk;
    input reset;
    output reg [63:0] ReadData1;
    output reg [63:0] ReadData2;
    
    output [63:0] r2,r3,r4;
    reg [63:0] Registers [31:0];
  
    integer i;
    initial begin
    for (i = 0 ; i < 31 ; i = i + 1)
        Registers[i] = 0; //initializing values as 0
        
    Registers[12]=64'd12;
    Registers[13]=64'd13;
    Registers[14]=64'd14;
    Registers[15]=64'd5;
//    Registers[16]=64'd6;
//    Registers[17]=64'd7;
//    Registers[18]=64'd8;
//    Registers[19]=64'd9;
//    Registers[20]=64'd20;
    end
    assign r2=Registers[12];
    assign r3=Registers[13];
    assign r4=Registers[14];
    assign r5=Registers[15];
//    assign r6=Registers[16];
//    assign r7=Registers[17];
//    assign r8=Registers[18];
//    assign r9=Registers[19];
//    assign r20=Registers[20];
    
    always @(*) begin
    if (reset) //if reset==1, reset readata1 and readata2
       begin
       ReadData1<=64'd0;
       ReadData2<=64'd0;
       end
       else begin
      
        ReadData1 <= Registers[rs1];  //if reset==0, readdata1 as reg[rs1] and readdata2 as reg[rs2]
        ReadData2 <= Registers[rs2];
        end
      end
    
    always @(posedge clk) //if posedge of clk and regwrite==1, write data in rd
    begin 
       if (RegWrite)
       begin
       Registers[rd] <= WriteData;
       end
    end
endmodule