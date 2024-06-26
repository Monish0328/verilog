module i2c (
  input clk,
  input reset,
  input [6:0] addr,
  input [7:0] data,
  output reg i2c_sda,
  output wire i2c_scl,
  output reg [7:0] state
);


  localparam STATE_IDLE = 3'b000;
  localparam STATE_START = 3'b001;
  localparam STATE_ADDR = 3'b010;
  localparam STATE_RW = 3'b011;
  localparam STATE_WACK = 3'b100;
  localparam STATE_DATA = 3'b101;
  localparam STATE_WACK2 = 3'b110;
  localparam STATE_STOP = 3'b111;


  reg [31:0] count;
  wire clk_div;
  reg i2c_scl_enable = 1'b0;

  
  assign i2c_scl = (i2c_scl_enable == 1'b0) ? 1'b1 : ~clk;

  
  initial begin
    count[3:0] = 4'b0000;
    i2c_sda = 1'b0;
    state[2:0] = STATE_IDLE;
    count[3:0] = 4'b0110;
    i2c_sda = 1'b1;
    state[2:0] = STATE_STOP;
  end

  
  always @(negedge clk) begin
    if (reset == 1) begin
      i2c_scl_enable <= 1'b1;
    end else begin
      if ((state == STATE_IDLE) || (state == STATE_START) || (state == STATE_STOP)) begin
        i2c_scl_enable <= 1'b0;
      end else begin
        i2c_scl_enable <= 1'b1;
      end
    end
  end

 
  always @(posedge clk) begin
    if (reset == 1) begin
      state <= STATE_IDLE;
      i2c_sda <= 1'b1;
      count <= 4'b0;
    end else begin
      case (state)
        STATE_IDLE: begin
          i2c_sda <= 1'b0;
          state <= STATE_START;
        end

        STATE_START: begin
          i2c_sda <= 1'b1;
          state <= STATE_ADDR;
          count <= 6;
        end

        STATE_ADDR: begin
          i2c_sda <= addr[count];
          if (count == 0) begin
            state <= STATE_RW;
          end else begin
            count <= count - 1;
          end
        end

        STATE_RW: begin
          i2c_sda <= 1'b1;
          state <= STATE_WACK;
        end

        STATE_WACK: begin
          state <= STATE_DATA;
          count <= 7;
        end

        STATE_DATA: begin
          i2c_sda <= data[count];
          if (count == 0) begin
            state <= STATE_WACK2;
          end else begin
            count <= count - 1;
          end
        end

        STATE_WACK2: begin
          state <= STATE_STOP;
        end

        STATE_STOP: begin
          i2c_sda <= 1'b1;
          state <= STATE_IDLE;
        end

        default: begin
          state <= STATE_IDLE;
        end
      endcase
    end
  end

endmodule

module i2c_testbench;

  
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

 
  always begin
    #5 clk = ~clk;
  end

  
  initial begin
    clk   = 0;
    reset = 1;
    addr  = 7'b0000000; 
    data  = 8'b00000000; 
    #10;
    reset = 0;
    #10;

  
    addr = 7'b0010010; 
    data = 8'b10101010;
    #100;

    
    addr = 7'b0101100; 
    data = 8'b01010101; 
    #100;

    
    addr = 7'b0010010; 
    data = 8'b00000000; 
    #100;

    
    addr = 7'b0101100; 
    data = 8'b00000000; 
    #100;

    
    $finish;
  end

endmodule
