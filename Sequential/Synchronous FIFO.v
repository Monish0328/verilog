
module sync_fifo #
    (
        parameter DEPTH     = 8,
        parameter WIDTH     = 8,
        parameter PTR_WIDTH = $clog2(DEPTH)
    )
    (
        input  wire               CLK, 
        input  wire               RST, 

        input  wire [WIDTH-1:0]   DATA_IN, 
        input  wire               WR_EN,

        input  wire               RD_EN, 
        output reg  [WIDTH-1:0]   DATA_OUT, 
        output reg  [PTR_WIDTH:0] CNTR,

        output wire               EMPTY, 
        output wire               FULL
    );

  
    reg [WIDTH-1:0] FIFO_REG [0:DEPTH-1];

    reg [PTR_WIDTH-1:0] RD_PTR, WR_PTR;

    
    integer i;

    
    assign EMPTY = (CNTR == 0);
    assign FULL  = (CNTR == DEPTH);

    
    always @(posedge CLK, negedge RST) begin: COUNTER
        if (!RST) begin
            CNTR <= 0;
        end else begin
            case ({WR_EN, RD_EN})
                2'b00  : CNTR <= CNTR;
                2'b01  : CNTR <= (CNTR == 0)     ? 0        : CNTR - 1;
                2'b10  : CNTR <= (CNTR == DEPTH) ? DEPTH    : CNTR + 1;
                2'b11  : CNTR <= (CNTR == 0)     ? CNTR + 1 : CNTR;
                default: CNTR <= CNTR;
            endcase
        end
    end

   
    always @(posedge CLK, negedge RST) begin: POINTER
        if (!RST) begin
            WR_PTR <= 0;
            RD_PTR <= 0;
        end 
        else begin
            WR_PTR <= ((WR_EN && !FULL) || (WR_EN && RD_EN)) ? WR_PTR + 1: WR_PTR;
            RD_PTR <= (RD_EN && !EMPTY) || ((WR_EN && RD_EN) && (WR_PTR != RD_PTR)) ? RD_PTR + 1: RD_PTR;
        end
    end

    
    always @(posedge CLK, negedge RST) begin: WRITE_OPR
        if (!RST)
            for (i = 0; i < DEPTH; i = i + 1)
                FIFO_REG [i] <= 0;
        else if ((WR_EN && !FULL) || (WR_EN && RD_EN))
            FIFO_REG [WR_PTR] <= DATA_IN;
    end

    always @ (posedge CLK, negedge RST) begin: READ_OPR
        if (!RST)
            DATA_OUT <= 0;
        else if ((WR_EN && RD_EN) && (WR_PTR == RD_PTR))
            DATA_OUT <= 0;
        else if ((RD_EN && !EMPTY) || (WR_EN && RD_EN))
            DATA_OUT <= FIFO_REG [RD_PTR];
    end
endmodule



module sync_fifo_tb ();

  reg clk, rst, wr, rd;
  reg  [7:0] data_in;
  reg  [7:0] tempdata;
  wire [7:0] data_out;

  sync_fifo fifo ( .CLK(clk), .RST(rst), .DATA_IN(data_in), .DATA_OUT(data_out), .WR_EN(wr), .RD_EN(rd), .EMPTY(empty), .FULL(full));

  initial
  begin
          clk = 0; rst = 1; rd  = 0; wr  = 0; tempdata = 0; data_in  = 0;
          #5 rst  = 0;
          #5 rst  = 1;
          #5 

          push(1);
          fork
             push(2);
             pop(tempdata);
          join              
          push(10);
          push(20);
          push(30);
          push(40);
          push(50);
          push(60);
          push(70);
          push(80);
          push(90);
          push(100);
          push(110);
          push(120);
          push(130);

          pop(tempdata);
          push(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          push(140);
          pop(tempdata);
          push(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          pop(tempdata);
          push(5);
          pop(tempdata);
  end

  always
     #5 clk = ~clk;

      task push;
          input[7:0] data;
          if(full)
              $display("---Cannot push: FIFO Full---");
          else
              begin
              $display("Pushed ",data );
              data_in = data;
              wr = 1;
              @(posedge clk);
              #1 wr = 0;
              end

      endtask

      task pop;
          output [7:0] data;
          if(empty)
              $display("---Cannot Pop: FIFO Empty---");
          else
              begin
                  rd = 1;
                  @(posedge clk);
                  #1 rd = 0;
                  data = data_out;
                  $display("-------------------------------Poped ", data);
              end
      endtask
endmodule
