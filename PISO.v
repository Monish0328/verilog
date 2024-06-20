module piso(in,ld,clk,rst,q);
  input ld,clk,rst;
  input [3:0] in;
  output q;
  reg [3:0]qq;
  assign q=qq[0];
  always @ (posedge clk, posedge rst)
    begin
      if(rst)
         qq<=0; 
      else if(ld)
          qq <=in;
      else
        qq <= {1'b0,qq[3:1]};
    end
endmodule  


module pisotb();
  reg ld,clk,rst;
  reg [3:0] in;
  wire q;
  piso dut(in,ld,clk,rst,q);
  
   initial 
    begin
      clk = 1;
      forever #5 clk = ~clk;
    end
  
 initial 
    begin
      $dumpfile("pisotb.vcd");
      $dumpvars(0,pisotb);
      #100 $finish;
    end
  
  initial 
    begin
      rst=1;
      #10 rst=0;ld=1;in=4'b0111;
      #10 ld=0;in=0;
    end
endmodule   
