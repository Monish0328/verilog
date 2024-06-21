module mealy_over(Clk,Rst,In,OP,CS,NS);
input Clk,Rst,In; 
output OP;        
output [1:0]CS,NS;

parameter s0   = 0,  
		  s1   = 1, 
		  s10  = 2,
		  s101 = 3;
		  
reg [1:0]C_State,N_State; 



always @(posedge Clk,negedge Rst) begin

	if(!Rst)
	begin
		C_State <= s0; 
	end
	
	else begin
		C_State <= N_State;
	end
end


always @(C_State,In) begin

	case(C_State)
	
		s0  : N_State <= In ? s1:s0 ;

		s1  : N_State <= In ? s1:s10 ;

		s10 : N_State <= In ? s101:s0 ;

		s101: N_State <= In ? s1:s10 ;

		default : N_State <= s0;
		
	endcase
end


assign OP = ((C_State == s101) && (!In));

assign CS = C_State ;
assign NS = N_State ;

endmodule
