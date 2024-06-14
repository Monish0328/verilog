module g2b_converter #(parameter width = 4)(input [width - 1:0] gray,output [width - 1:0] binary);
  genvar i;
  generate
   for(i=0;i<width;i=i+1) begin 
   assign binary[i]= ^(gray >> i);
   end
  endgenerate
endmodule   
   
module g2b_converter_tb;
reg[3:0] gray;
wire[3:0] binary;
g2b_converter g2b(gray,binary);


 initial begin
   $monitor("gray=%b:binary=%b",gray,binary);
   gray = 4'b1110; #1;
   gray = 4'b0100; #1;
   gray = 4'b0111; #1;
   gray = 4'b1010; #1;
   gray = 4'b1000;
 end
endmodule  
