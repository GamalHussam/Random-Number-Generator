`timescale 1ns / 1ps



module D_FF(
    input clk,reset,
    input load,D,
    output reg Q
       );
    
     
    always @ (posedge clk)
    begin
    if (reset)
    Q<=0;
    else if(load)
    Q<=D;
    end
endmodule
