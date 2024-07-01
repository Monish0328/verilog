module fsm_seq_detector(
    input clk,
    input rst,
    input [9:0] x,
    output reg z
    );
parameter A=0,B=1,C=2,D=3;
reg [1:0] PS,NS;
always@(posedge clk or posedge rst)
begin
if(rst) begin
		PS<=A;
		end
else begin
	PS<=NS;
	end
end
always@(PS,x)
	begin
	case(PS)
		A:begin
			z<=x?0:0;
			NS<=x?B:A;
		  end
		B:begin
			z<=x?0:0;
			NS<=x?C:A;
		  end
		C:begin
			z<=x?1:0;
		   NS<=x?D:A;
		  end
		D:begin
			z<=x?1:0;
			NS<=x?D:A;
		  end
	endcase
end
endmodule

module Seq_detector_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [9:0] x;
	

	// Outputs
	wire z;
	

	// Instantiate the Unit Under Test (UUT)
	fsm_seq_detector uut (
		.clk(clk), 
		.rst(rst), 
		//.data(data), 
		.x(x), 
		.z(z)
	);
   always begin
    #5 clk = ~clk; // Toggle clock every 5 time units
  end
  
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		//data = 0;
		x = 0;

		#10 rst=0;
		// Wait 100 ns for global reset to finish
	 @(posedge clk) #10 x = 1'b1;
	 @(posedge clk)	#10 x=1'b0;
	 @(posedge clk)	#10 x=1'b1;
	 @(posedge clk)	#10 x=1'b1;
	 @(posedge clk)	#10 x=1'b1;
	 @(posedge clk)	#10 x=1'b0;
	 @(posedge clk)	#10 x=1'b0;
	 @(posedge clk)	#10 x=1'b1;
	 @(posedge clk)	#10 x=1'b1;
	 @(posedge clk)	#10 x=1'b1;
		// Add stimulus here
 #500 $finish;
	end
    
always @(posedge clk) begin
    $display("Output z = %b", z);
  end	 
endmodule
