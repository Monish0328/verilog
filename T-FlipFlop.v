module tff(input t, clk, output reg q, qbar);
initial begin
q<=0;
qbar<=1;
end
always @(posedge clk)
begin
q <= ~q;
qbar <= q;
end
endmodule

module flipfloptb();
reg t, clk;
wire q, qbar;

tff dut(.q(q), .qbar(qbar), .t(t), .clk(clk));
initial begin
  clk=0;
     forever #10 clk = ~clk;  
end 
initial begin 
t = 0;
#100
t = 1;
#100
$finish;
end 
endmodule
