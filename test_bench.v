`timescale 1ns / 1ps

module testbench();

reg clk, reset;

RISC_V_Processor testt(clk, reset);

initial
begin
clk<=1;
reset <= 1; #2 reset <= 0;
end


always
begin
#1 clk=~clk;
end
endmodule