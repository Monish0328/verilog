module c1(clk,clr,o);
input clk,clr;
output [3:0]o;
sajk aa(1,1,clk,clr,o[0]);
sajk bb(1,1,o[0],clr,o[1]);
sajk cc(1,1,o[1],clr,o[2]);
sajk dd(1,1,o[2],clr,o[3]);
endmodule

module sajk(j,k,clk,clr,q);
input j,k;
input clk;
input clr;
output q;
reg q;
 always@(negedge clk or posedge clr)
  begin
   if(clr==1)
    q<=0;
   else
 begin 
   case({j,k})
     0: q<=q;
     1: q<=0;
     2: q<=1;
     3: q<=~q;
   endcase
 end
 end
endmodule

module testbench();
reg clk,clr;
wire [3:0]o;
c1 tst(clk,clr,o);
always #1 clk=~clk;
initial begin
clr=1; clk=1;
#4 clr=0;
#40 $finish;
end
endmodule
