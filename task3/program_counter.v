`timescale 1ns / 1ps
module program_counter(clk, reset, PC_In, PC_Out, PCWrite);

input clk, reset;
input [63:0] PC_In;
input PCWrite;

output reg [63:0] PC_Out;

initial
	PC_Out=64'd0;
	
always @(*) begin
if (reset)
PC_Out = 64'b0;
end
always @ (posedge clk) 
       if (reset == 1'b1)
        PC_Out = 64'b0;
	   else if (PCWrite == 1'b0) 
	   PC_Out = PC_Out;
	   else 
	   PC_Out = PC_In;

endmodule
