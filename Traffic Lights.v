
module cyclic_lamp (clock, light);
  input clock;
  output reg [0:2] light;
  parameter S0=0, S1=1, S2=2;
  parameter RED=3'b100, GREEN=3'b010, YELLOW=3'b001;
  reg [0:1] state;
always @(posedge clock)
  begin
    case (state)
      S0: state <= S1;
      S1: state <= S2;
      S2: state <= S0;
      default: state <= S0;
    endcase
  end
always @(state)
  begin
    case (state)
    S0: light = RED;
    S1: light = GREEN;
    S2: light = YELLOW;
    default: light = RED;
    endcase
  end
endmodule

module cyclic_lamp_tb;
  reg clk;
  wire [0:2] light;
cyclic_lamp LAMP (clk, light);
always #5 clk = ~clk;
initial
  begin
    clk = 1'b0;
    #100 $finish;
  end
initial
  begin
    $monitor ($time, " RGY: %b", light);
  end
endmodule
