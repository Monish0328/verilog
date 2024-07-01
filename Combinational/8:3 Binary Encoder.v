module binary_encoder(
  input [7:0] D,
  output [2:0] y);
  
  assign y[2] = D[4] | D[5] | D[6] | D[7];
  assign y[1] = D[2] | D[3] | D[6] | D[7];
  assign y[0] = D[1] | D[3] | D[5] | D[7];
endmodule

module tb;
  reg [7:0] D;
  wire [2:0] y;
  reg [7:0]i;
 
  binary_encoder bin_enc(D, y);
  
  initial begin
    D=8'b1; #1;
    for(i = 0; i < 8; i = i+1) begin
      $display("D = %h(in dec:%0d) -> y = %0h", D, i, y);
      D=D<<1; #1;
    end
  end
endmodule
