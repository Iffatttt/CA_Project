`timescale 1ns / 1ps
module adder(a, b, out);
input [63:0] a;
input [63:0] b;
output reg [63:0] out;
always @ (*)
    out <= a + b; //a+b
endmodule