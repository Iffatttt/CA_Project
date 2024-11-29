`timescale 1ns / 1ps

module data_memory(
input [63:0] mem_add,
input [63:0] write_data,
input clk,
input mem_write,
input mem_read,
output reg [63:0] read_data,
output [63:0] arr0, //array is of length 5
output [63:0] arr1,
output [63:0] arr2,
output [63:0] arr3,
output [63:0] arr4
);
reg [7:0] Data_Memory [63:0]; 

integer i;
initial begin
for (i = 0 ; i < 64 ; i = i+ 1)  //initializing 64 locations in data memory, each location 8 bit wide
    Data_Memory[i] = 0; //initializing each element as 0
    
Data_Memory[0] = 8'd8; //assigning array values in data memory to sort
Data_Memory[8] = 8'd4;
Data_Memory[16] = 8'd5;
Data_Memory[24] = 8'd2;
Data_Memory[32] = 8'd7;
end 
//each array value is of 8 bytes ( 64-bit integers)
assign arr0 = {Data_Memory[7],Data_Memory[6],Data_Memory[5],Data_Memory[4],Data_Memory[3],Data_Memory[2],Data_Memory[1],Data_Memory[0]};
assign arr1 = {Data_Memory[15],Data_Memory[14],Data_Memory[13],Data_Memory[12],Data_Memory[11],Data_Memory[10],Data_Memory[9],Data_Memory[8]};
assign arr2 = {Data_Memory[23],Data_Memory[22],Data_Memory[21],Data_Memory[20],Data_Memory[19],Data_Memory[18],Data_Memory[17],Data_Memory[16]};
assign arr3 = {Data_Memory[31],Data_Memory[30],Data_Memory[29],Data_Memory[28],Data_Memory[27],Data_Memory[26],Data_Memory[25],Data_Memory[24]};
assign arr4 = {Data_Memory[39],Data_Memory[38],Data_Memory[37],Data_Memory[36],Data_Memory[35],Data_Memory[34],Data_Memory[33],Data_Memory[32]};

always@ (*) begin
 if (mem_read == 1'b1)
 //if mem_read is high, and mem_address changes:
 begin//reading data from data memory
 read_data[7:0] <= Data_Memory[mem_add];
 read_data[15:8] <= Data_Memory[mem_add+1];
 read_data[23:16] <= Data_Memory[mem_add+2];
 read_data[31:24] <= Data_Memory[mem_add+3];
 read_data[39:32] <= Data_Memory[mem_add+4];
 read_data[47:40] <= Data_Memory[mem_add+5];
 read_data[55:48] <= Data_Memory[mem_add+6];
 read_data[63:56] <= Data_Memory[mem_add+7];end
else
read_data<=64'b0;

end
always@ (posedge clk) begin
 if (mem_write == 1'b1) //if mem_write is high and positive edge of clk is high:
 begin //writing data in data memory at mem_address
 Data_Memory[mem_add+7] <= write_data[63:56];
 Data_Memory[mem_add+6] <= write_data[55:48];
 Data_Memory[mem_add+5] <= write_data[47:40];
 Data_Memory[mem_add+4] <= write_data[39:32];
 Data_Memory[mem_add+3] <= write_data[31:24];
 Data_Memory[mem_add+2] <= write_data[23:16];
 Data_Memory[mem_add+1] <= write_data[15:8];
 Data_Memory[mem_add] <= write_data[7:0];
 end
 end
endmodule
