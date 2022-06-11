`timescale 1ns / 1ps





module Top_Module(
input clk, //100 Hz Clock
input load_button,//to generate a RNG and display on the board
input reset, //Reset,
output [6:0] seg,
output [3:0] an
    );
    
parameter zero = 4'b0000; //255 Random number will be generated, only 3 segments will be used, left most is 0

//everything that comes out of the individual modules is declared as wire
wire clk_out; //slow clock 100 Hz for toggling seven segments
wire [3:0] mux_out;
wire [1:0] counter_out; //enables each segment one-by-one
wire [3:0] ones, tens;
wire [1:0] hundreds;

//debouncing button for generating a new random number to make sure we don't skip a number

    wire button_deb;
    Debounce U0(clk,load_button, button_deb);   

   wire [7:0] Q; 
D_FF D0(clk, reset,button_deb, Q[1],Q[0]); //instantiating 8 D Flip Flops
D_FF D1(clk, reset, button_deb,Q[2],Q[1]);
D_FF D2(clk, reset,button_deb, Q[3],Q[2]);
D_FF D3(clk, reset, button_deb,Q[4],Q[3]);
D_FF D4(clk, reset, button_deb,Q[5],Q[4]);
D_FF D5(clk, reset,button_deb, Q[6],Q[5]);
D_FF D6(clk, reset,button_deb, Q[7],Q[6]);
D_FF D7(clk, reset, button_deb,~(Q[7]^ Q[5] ^ Q[4] ^ Q[3]),Q[7]);
 
 
  //These modules below have been covered in the video, #8 Binary to BCD Conversion
Binary_to_BCD U2(Q, ones, tens, hundreds);
Mux4to1 U3(ones, tens, hundreds, zero, counter_out, mux_out);
Slowclock_100Hz U4(clk, clk_out);
Two_bit_counter U5(clk_out, counter_out);
Decoder2to4 U6(counter_out, an);
BCD7seg U7(mux_out, seg);
endmodule
