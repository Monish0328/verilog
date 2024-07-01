module mux_2_1(
  input sel,
  input i0, i1,
  output y);
  
  assign y = sel ? i1 : i0;
endmodule

module mux_3_1(
  input sel0, sel1,
  input  i0,i1,i2,i3,
  output reg y);
  
  wire y, y0, y1;
  
  mux_2_1 m1(sel1, i0, i1, y0);
  mux_2_1 m2(sel0, y0, i2, y);
endmodule


module tb;
  reg sel0, sel1;
  reg i0,i1,i2,i3;
  wire y;
  
  mux_3_1 mux(sel0, sel1, i0, i1, i2, i3, y);
  
  initial begin
    $monitor("sel0=%b, sel1=%b -> i3 = %0b, i2 = %0b ,i1 = %0b, i0 = %0b -> y = %0b", sel0,sel1,i3,i2,i1,i0, y);
    {i3,i2,i1,i0} = 4'h5;

    repeat(8) begin
      {sel0, sel1} = $random;
      #5;
    end
  end
endmodule
