
module johnson_counter( out,reset,clk);
input clk,reset;
output [3:0] out;

reg [3:0] q;

always @(posedge clk)
begin

if(reset)
 q=4'd0;
 else
 	begin 
 		q[3]<=q[2];
  		q[2]<=q[1];
  		q[1]<=q[0];
   		q[0]<=(~q[3]);
 	end
 end

assign out=q;  
endmodule


module johnson_counter_tb;
  reg clk,reset;
  wire [3:0] out;
  
  johnson_counter dut (.out(out), .reset(reset), .clk(clk));
  
  always 
    #5 clk =~clk;
  
  initial begin
    reset=1'b1; clk=1'b0;
   #20 reset= 1'b0;
  end
  
  initial 
    begin 
   	 $monitor( $time, " clk=%b, out= %b, reset=%b", clk,out,reset);
  	 #105  $stop;  
   end
 
endmodule
