module SR_latch(s,r,c,q,qn);

input s,r,c;

output reg q;
output reg qn;

always @ (s,r,c)

if (c & s) 
    {q,qn} <= 2'b10;

else if (c & r)
    {q,qn} <= 2'b01;


endmodule



module SR_latch_control(s,r,c,q,qn);

input c;
input [3:0] s,r;

output [3:0] q,qn;

SR_latch islem1(s[0],r[0],c,q[0],qn[0]);
SR_latch islem2(s[1],r[1],c,q[1],qn[1]);
SR_latch islem3(s[2],r[2],c,q[2],qn[2]);
SR_latch islem4(s[3],r[3],c,q[3],qn[3]);


endmodule




module SR_latch_control_tb();

reg [3:0] s,r;
reg c;

wire [3:0] q,qn;

SR_latch_control uut(

.s(s),
.r(r),
.c(c),
.q(q),
.qn(qn)
);

initial begin

c = 1'b0;
s = 4'h0;
r = 4'h0;
#10;

c = 1'b0;
s = 4'hF;
r = 4'h0;
#10;

c = 1'b1;
s = 4'h0;
r = 4'h0;
#10;

c = 1'b1;
s = 4'hA;
r = 4'h5;
#10;

c = 1'b1;
s = 4'h0;
r = 4'h0;
#10;

c = 1'b1;
s = 4'hF;
r = 4'hA;
#10;

c = 1'b1;
s = 4'h0;
r = 4'h5;
#10;

c = 1'b1;
s = 4'h0;
r = 4'h0;
#10;

end 

endmodule
