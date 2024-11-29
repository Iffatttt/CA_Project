`timescale 1ns / 1ps
module program_counter(clk, reset, PC_in, PC_out);
input clk, reset;
input [63:0] PC_in;
output reg [63:0] PC_out;
always @(*) begin //if reset is 0 pc out is set 0 even if not posedge clk
if (reset) 
PC_out=64'b0;
end
always @ (posedge clk)
begin
if (reset == 1'b1) //if reset is 1 then reset PC
    PC_out <= 64'b0;
else 
    begin
    PC_out <= PC_in; //if reset is 0 and posedge of clk then pc_out=pc_in
    end
end
endmodule