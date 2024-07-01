module SR(input S,
    input R,
    input clk,
    output Q,
    output Qbar
    );
    reg M,N;

always @(posedge clk) begin
  M <= !(S & clk);
  N <= !(R & clk);
end
assign Q = !(M & Qbar);
assign Qbar = !(N & Q);

endmodule



module SR_tb;
 
 reg S;
 reg R;
 reg clk;
 
 wire Q;
 wire Qbar;
 SR uut (
 .S(S), 
 .R(R), 
 .clk(clk), 
 .Q(Q), 
 .Qbar(Qbar)
 );



 initial begin
 S = 0;
      R = 0;
      clk = 0;
  fork
  #2 S = 0;
  #2 R = 1;
  #4 S = 0;
  #4 R = 0;
  #6 S = 0;
  #6 R = 1;
  #8 S = 1;
  #8 R = 0;
  #10 S = 1;
  #10 R = 1;
  join
 end
always #1 clk =! clk;
      
endmodule
