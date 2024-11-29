`timescale 1ns / 1ps

module mux3to1(a, b, c, sel, data_out); 

input [63:0] a; 
input [63:0] b;
input [63:0] c; 
input [1:0] sel; 
output reg [63:0] data_out;

always @(*) begin

case(sel)  
    2'b00 : data_out <= a; //if sel = 0 then data is a else b
    2'b01 : data_out <= b; 
    2'b10 : data_out <= c;
endcase

end
endmodule
