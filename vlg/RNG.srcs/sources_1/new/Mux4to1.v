module Mux4to1( input [3:0] A,//ones
input [3:0] B,//tens
input [1:0] C,//hundreds
input [3:0] D, //zeroes
input [1:0]
sel, output
[3:0] Y);
assign Y = (sel==0)?A : (sel==1)?B : (sel==2)?C : D;
endmodule