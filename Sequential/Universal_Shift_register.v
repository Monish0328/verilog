module universal_shift_reg(
  input clk, rst_n, 
  input [1:0] select, 
  input [3:0] p_din,   
  input s_left_din,   
  input s_right_din,  
  output reg [3:0] p_dout, 
  output s_left_dout, 
  output s_right_dout 
);
  always@(posedge clk) begin
    if(!rst_n) p_dout <= 0;
    else begin
      case(select)
        2'h1: p_dout <= {s_right_din,p_dout[3:1]};
        2'h2: p_dout <= {p_dout[2:0],s_left_din};  
        2'h3: p_dout <= p_din; // Parallel in - Parallel out
        default: p_dout <= p_dout;
      endcase
    end
  end
  assign s_left_dout = p_dout[0];
  assign s_right_dout = p_dout[3];
endmodule


module TB;
  reg clk, rst_n;
  reg [1:0] select;
  reg [3:0] p_din;
  reg s_left_din, s_right_din;
  wire [3:0] p_dout; //parallel data out
  wire s_left_dout, s_right_dout;
  
  universal_shift_reg usr(clk, rst_n, select, p_din, s_left_din, s_right_din, p_dout, s_left_dout, s_right_dout);
  
  always #2 clk = ~clk;
  initial begin
    $monitor("select=%b, p_din=%b, s_left_din=%b, s_right_din=%b --> p_dout = %b, s_left_dout = %b, s_right_dout = %b",select, p_din, s_left_din, s_right_din, p_dout, s_left_dout, s_right_dout);
    clk = 0; rst_n = 0;
    #3 rst_n = 1;
    
    p_din = 4'b1101;
    s_left_din = 1'b1;
    s_right_din = 1'b0;
    
    select = 2'h3; #10;
    select = 2'h1; #20;
    p_din = 4'b1101;
    select = 2'h3; #10;
    select = 2'h2; #20;
    select = 2'h0; #20;
    
    $finish;
  end
 
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
   
endmodule
