
`timescale 1ns / 1ps

module ALU_64_bit(
    input [63:0] a,
    input [63:0] b,
    input [3:0] ALUop,
    output reg [63:0] result,
    output Zero
    );
   
    always @(*)
    begin
    case(ALUop)
    4'b0000: //and
    result=a&b;
    4'b0001: //or
    result=a|b;
    4'b0010:
    result=a+b;//add
    4'b0110:
    result=a-b;//sub
    4'b1100:
    result=~(a|b);//nor
    4'b1000:
     result = a * (2 ** b);//slli
    endcase
    end  
    assign Zero= result? 0:1;
   
endmodule