module mealy_non_over(Clk,Rst,In,OP,state);
input Clk,Rst,In; 
output OP;        
output [1:0]state;

reg op;    
reg [1:0]State; 

parameter s0   = 0;  
parameter s1   = 1;
parameter s10  = 2;
parameter s101 = 3;
		  
always @(posedge Clk,negedge Rst) begin
	if(!Rst)
	begin
		State <= s0;
		op <= 0; 
	end
	
	else begin
		case(State)
			s0  : begin
					State <= In ? s1:s0 ;
					op <= 0;
				 end
			
			s1  : begin
					State <= In ? s1:s10 ;
					op <= 0;
				end

			s10 : begin
					State <= In ? s101:s0 ;
					op <= 0;
				end

			s101: begin
					State <= In ? s1:s0 ;
					op <= In ? 0:1 ;
				end
				
			default : begin
					  State <= s0 ;
					  op <= 0;
					  end
		endcase
	end
	
end

assign OP = op;
assign state = State;

endmodule


module mealy_non_over_tb ();
reg Clk,Rst,In; 
wire OP;
wire [1:0]state;
 
mealy_1010_seq_det_non_over UUT(Clk,Rst,In,OP,state);


initial begin
	$monitor("Input = %b || State = %b || Output = %b",In,state,OP);
end

initial begin
	Clk = 1'b0;
	forever #5 Clk = ~Clk;
end



initial begin
		 Rst = 1'b0;
	#15  Rst = 1'b1; end
	
initial begin
        In  = 1'b1;
	#10 In  = 1'b0;
	#10 In	= 1'b0;
	#10 In  = 1'b1;
	#10 In	= 1'b0;
	#10 In  = 1'b0;
	#10 In	= 1'b1;
	#10 In  = 1'b0;
	#10 In	= 1'b1;
	#10 In  = 1'b0;
	#10 In	= 1'b1;
	#10 In  = 1'b0;
	#10 In  = 1'b1;
	#10 In	= 1'b1;
	#10 In  = 1'b0;
	#10 In	= 1'b1;
	#10 In  = 1'b0;
	#10 In	= 1'b0;
	#10 $finish();
end

endmodule
