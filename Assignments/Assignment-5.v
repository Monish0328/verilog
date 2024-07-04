1. How many DFFs will be inferred from the below snippet.

   input c, din;
   output reg y3;
   reg y1,y2;
   always@ ( posedge c) begin
    y1 = din;
    y2 = y1;
    y3 = y2;
   end

  A:one d-flipflop.

2. How many DFFs will be inferred from the below snippet:

   input c,din;
   output reg y3;
   reg y1,y2;
   always@(posedge c)
   begin
    y1 &lt;= din;
    y2 &lt;= y1;
    y3 &lt;= y2;
   end

   A:three d-flipflops.

3. Write RTL code to design a 3-bit SISO right shift register using
only a Non-blocking assignment. (Do not use any operators).

      A:module SISO_ShiftRegister (
        input wire clk,  
        input wire reset, 
        input wire si,   
        output reg [2:0] q );
   
        always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 3'b0;
        end else begin
            q <= {si, q[2], q[1]};
        end
        end

       endmodule

4. Which of the statements will execute from the below
snippet &amp; justify the behavior?
   reg c = 3’b00x;
   always@(*)
   begin
    casex( c )
      3’b000:st1;
      3’b100:st2;
      3’b001 : st3;
    endcase
   end
   A:

5. Which hardware logic is inferred from the below snippet?

   always@(*) begin
    case( 1’b1 ) 
      a[3] : y=3;
      a[2] : y = 2;;
      a[1] : y = 1;
      a[0] : y = 0;
    endcase
  end 

   A:a priority encoder or a priority decoder.

6. Write RTL code for designing an 8:1 mux using a for loop.
   A:module mux8_1 (
     input [7:0] data_in, 
     input [2:0] s,       
     output reg [7:0] y );

     always @* begin
        y = 0; // Initialize output
        for (int i = 0; i < 8; i = i + 1) begin
            if (s == i) begin
                y = data_in[i]; 
            end
            end
     end
     endmodule
  
7. Write Verilog code for generating an infinite clock signal
with a 50% Duty cycle having a time period of 10ns using a
forever loop.
    A:module InfiniteClock;
      reg clk;  
      always begin
        #5 clk = ~clk; 
      end
      initial begin
        clk = 0; 
        forever begin
            #5 clk = ~clk;  
        end
      end
      endmodule

  
8. Draw the waveform for the below snippet.

   initial begin
   #5 clk = 0;
   forever #5clk =~clk; end
   initial begin
    rst = 1;
    repeat(3)@(negedge clk);
    rst =0;
   end

    A:


9. Write RTL code for designing a D latch using a 2:1 mux.

   A:module DLatch (
     input D,    
     input LE,   
     output reg Q );
     reg Q_bar;  
     always @* begin
        if (LE) begin
            Q = D;      
            Q_bar = ~D; 
        end else begin
            Q = Q;      
            Q_bar = Q_bar; 
        end
     end
     endmodule
10. Find the output for the below codes:

  1)    reg a,b;
        always@(a,b) begin
         #10 a &lt;= 1&#39;b0;
         #1 b &lt;= 1&#39;b1;
         a &lt;= 1;
         #5 b &lt;= a;
         $display($time,&quot;a=%d,b=%d&quot;,a,b);
        end

        A:#0 a=1, b=1
          #10 a=0, b=1
          #11 a=1, b=1
          #16 a=1, b=1

  2)   reg a,b;
       always@(a,b) begin
         #10 a = 1&#39;b0;
         #1 b = 1&#39;b1;
         a = 1;
         #5 b = a;
         $display($time,&quot;a=%d,b=%d&quot;,a,b);
       end

          A:#0 a=1, b=1
            #10 a=0, b=1
            #11 a=1, b=1
            #16 a=1, b=1


 3)    reg a,b;
       initial begin
        a=1;
        b=a;
        $display($time,&quot;a=%d,b=%d&quot;,a,b);
       end
       initial begin
        #1 a&lt;=1;
        b&lt;=a;
        $display($time,&quot;a=%d,b=%d&quot;,a,b);
       end


        A:#1 a=1, b=1

11. For the below RTL schematic write the RTL snippet

