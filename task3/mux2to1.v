`timescale 1ns / 1ps
`timescale 1ns / 1ps
module mux2to1(a, b, sel, out);
input [63:0] a; 
input [63:0] b;
input sel;
output reg [63:0] out;
always @(a,b,sel) begin

if (sel)
    out <= b;
else
    out <= a;

end
endmodule

