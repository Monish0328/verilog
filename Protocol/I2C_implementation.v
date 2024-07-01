module i2c(
	input  clk,
	input reset,
	input[6:0]addr,
	input[7:0] data,
	output reg i2c_sda,
	output wire i2c_scl,
	output reg [7:0]state 
    );

	localparam STATE_IDLE = 0;
	localparam STATE_START = 1; 
	localparam STATE_ADDR = 2;
	localparam STATE_RW = 3;
	localparam STATE_WACK = 4; 
	localparam STATE_DATA = 5;
	localparam STATE_WACK2 = 6;
	localparam STATE_STOP = 7;  

	reg [31:0] count;
	wire clk_div;
	reg i2c_scl_enable = 0;
	assign i2c_scl = (i2c_scl_enable == 0) ? 1 : ~clk;
	
	initial begin
	count[3:0] =4'b0000;
	i2c_sda =1'b0;
	state[2:0] = 3'b000;
	count[3:0] =4'b0110;
	i2c_sda =1'b1;       
	state[2:0] = 3'b111;
	end
	
	always @(negedge clk)
	begin
	if (reset == 1)
	begin
	i2c_scl_enable <= 1;
	end
	
	else begin
	if((state == STATE_IDLE) || (state == STATE_START) || (state == STATE_STOP))
	begin     
	i2c_scl_enable <= 0;  
	end
	else begin
	i2c_scl_enable <= 1;
	end
	end
	end
	
  always@(posedge clk)
	begin
	if (reset==1)
	begin
	state<= 3'b0;
	i2c_sda <= 1;
	count <= 4'b0;
	end
	
	else begin
	case(state)
	
	STATE_IDLE: begin 
	i2c_sda <= 0;   
	state <= STATE_START;
	end
	
	STATE_START: begin 
	i2c_sda <= 1;
	state <= STATE_ADDR;
	count <= 6;   

	end
	
	
	
	STATE_ADDR: begin 
	i2c_sda <= addr[count];
	if (count == 0) state <= STATE_RW;
	else count <= count - 1;
	end
	

	STATE_RW: begin
	i2c_sda <= 1;
	state <= STATE_WACK;
	end
	
	

	STATE_WACK: begin
	state <= STATE_DATA;
	count <=7;
	
	end

	STATE_DATA: begin
	i2c_sda <= data[count];
	if (count == 0) state <= STATE_WACK2;
	else count <= count - 1;
	end
	
	
	
	STATE_WACK2: begin
	state <= STATE_STOP;
	end
	
	STATE_STOP: begin
	i2c_sda <= 1;
	state <= STATE_IDLE;
	end
	endcase
	end
	end 
endmodule

module i2c_test;


	reg clk;
	reg reset;
	reg [6:0] addr;
	reg [7:0] data;


	wire i2c_sda;
	wire i2c_scl;
	wire [7:0] state;

	i2c uut (
		.clk(clk), 
		.reset(reset), 
		.addr(addr), 
		.data(data), 
		.i2c_sda(i2c_sda), 
		.i2c_scl(i2c_scl), 
		.state(state)
	);
	initial begin
	
		clk = 0;
		forever begin
		clk = #1 ~clk;
		end
		end
	

	initial begin
	
		clk = 0;
		reset = 1;
		addr = 1111111;
		data = 11111111;
		#100;

		reset = 0; 
		addr = 0001010;
		data = 00010100;
		#100;$finish;
        
	
	end
      
endmodule
