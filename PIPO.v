module invert (input wire i, output wire o);
   assign o = !i;
endmodule

module and2 (input wire i0, i1, output wire o);
  assign o = i0 & i1;
endmodule


module df (input wire clk, in, output wire d_out);
  reg df_out;
  always@(posedge clk) df_out <= in;
  assign d_out = df_out;
endmodule

module dfr (input wire clk, reset, in, output wire d_out);
  wire reset_, df_in;
  invert invert_0 (reset, reset_);
  and2 and2_0 (in, reset_, df_in);
  df df_0 (clk, df_in, d_out);
endmodule


module PIPO(input wire clk, reset,input wire[3:0] d_in, output wire[3:0] d_out);

dfr d0(clk,reset,d_in[0],d_out[0]);
dfr d1(clk,reset,d_in[1],d_out[1]);
dfr d2(clk,reset,d_in[2],d_out[2]);
dfr d3(clk,reset,d_in[3],d_out[3]);

endmodule



module PIPO_tb;
reg clk, reset;
reg[3:0] d_in;
wire[3:0] d_out;
PIPO p1(clk,reset,d_in,d_out);

initial 
begin
$dumpfile("dump.vcd");
$dumpvars(0, PIPO_tb);
clk=0;
reset=0;
d_in=4'b0000;
#20 reset=1;
#20 reset=0;
#60 d_in= 4'b1001;
#60 d_in= 4'b1010;
#60 d_in= 4'b1111;

#60 $finish;
end
always #10 clk = ~clk;
endmodule 
