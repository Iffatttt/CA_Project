`timescale 1ns / 1ps

module Branch_Unit(Funct3, ReadData1, ReadData2, sel);
input [2:0] Funct3;
input [63:0] ReadData1, ReadData2;
output reg sel;

initial begin
      sel = 1'b0;
    end
  always @(*) begin
      case (Funct3)
        3'b000: begin //beq
            sel= ReadData1 == ReadData2? 1'b1:1'b0;
            end
         3'b100:begin //blt
              sel=ReadData1 < ReadData2? 1'b1:1'b0;
            end
        3'b101: begin //bgt
            sel= ReadData1 > ReadData2? 1'b1:1'b0;
          end    
      endcase
     end
endmodule
