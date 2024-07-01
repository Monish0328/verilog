module d_latch (  input d,          
                  input en,           
                  input rstn,       
                  output reg q);     
  
   
  
   always @ (en or rstn or d)  
      if (!rstn)  
         q <= 0;  
      else  
         if (en)  
            q <= d;  
endmodule  

module tb_latch;  
  
   reg d;  
   reg en;  
   reg rstn;  
   reg [2:0] delay;  
   reg [1:0] delay2;  
   integer i;  
  
   
   d_latch  dl0 ( .d (d),  
                  .en (en),  
                  .rstn (rstn),  
                  .q (q));  
  
    
   initial begin  
      $monitor ("[%0t] en=%0b d=%0b q=%0b", $time, en, d, q);  
  
    
      d <= 0;  
      en <= 0;  
      rstn <= 0;  
  
      #10 rstn <= 1;  
  
   
      for (i = 0; i < 5; i=i+1) begin  
         delay = $random;  
         delay2 = $random;  
         #(delay2) en <= ~en;  
         #(delay) d <= i;  
      end  
   end  
endmodule  
