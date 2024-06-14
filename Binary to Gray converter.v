module b2g_converter #(parameter WIDTH=4) (input [WIDTH-1:0] binary, output [WIDTH-1:0] gray);
  genvar i;    
  generate
    for(i=0;i<WIDTH-1;i=i+1) begin
      assign gray[i] = binary[i] ^ binary[i+1];
    end
  endgenerate
  
  assign gray[WIDTH-1] = binary[WIDTH-1];
endmodule

module TB;
  reg[3:0]binary;
  wire[3:0]gray;
  b2g_converter b2g(binary, gray);

   initial begin
    $monitor("binary=%b:gray=%b",binary,gray);
     binary = 4'b1011;#1;
     binary = 4'b0111;#1;
     binary = 4'b0101;#1;
     binary = 4'b1100;#1;
     binary = 4'b1111;
    end

endmodule
