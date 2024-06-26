module mux_2_1(
input  sel,
input  i0,i1,
output  y);


assign y = sel? i1:i0;
endmodule


module Mux_2_1_tb;
reg i0,i1,sel;
wire y;

mux_2_1 mux(i0,i1,sel,y);
  initial begin
  $monitor("sel=%h:i0=%h,i1=%h:y=%h",sel,i0,i1,y);
  i0 = 0;i1 = 1;
  sel = 0;
  #1;
  sel=1;
  end
endmodule
