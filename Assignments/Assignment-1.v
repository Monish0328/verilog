1. Write RTL (Dataflow) for designing a Half-Subtractor:
   module half_subtractor(input a, b, output D, B);
   assign D = a ^ b;
   assign B = ~a & b;
   endmodule

2. Write RTL for designing a 1-bit Full Subtractor using Half-Subtractor:
   module full_subtractor(input a, b, Bin, output D, Bout);
   assign D = a ^ b ^ Bin;
   assign Bout = (~a & b) | (~(a ^ b) & Bin);
   endmodule

3. Write RTL for designing a 2:1 mux using gate-level abstraction:
    module mux_2_1(
    input  sel,
    input  i0,i1,
    output  y);
    assign y = sel? i1:i0;
    endmodule

4. Write RTL for designing a 4:1 mux using 2:l muxes:

    module demux_1_2(
      input sel,
      input i,
      output y0, y1);
  
      assign {y0,y1} = sel?{1'b0,i}: {i,1'b0};
    endmodule

   module demux_1_4(
    input sel0, sel1,
    input  i,
    output reg y0, y1, y2, y3);
    wire z1,z2;
  
    demux_2_1 d1(sel0, i, z1, z2);
    demux_2_1 d2(sel1, z1, y0, y1);
    demux_2_1 d3(sel1, z2, y2, y3);
  endmodule

5. Write RTL for designing a 2:4 decoder using Data-flow abstraction:
    
  module decoder24_behaviour(en,a,b,y);
      input en,a,b;
      output reg [3:0]y;
  
     always @(en,a,b)
      begin
        if(en==0)
          begin
            if(a==1'b0 & b==1'b0) y=4'b1110;
            else if(a==1'b0 & b==1'b1) y=4'b1101;
            else if(a==1'b1 & b==1'b0) y=4'b1011;
            else if(a==1 & b==1) y=4'b0111;
            else y=4'bxxxx;
          end
        else
         y=4'b1111;
      end
  endmodule

6. Write RTL for designing a 1:4 demux using Data-flow abstraction:
    module demux_1_4(
     input [1:0] sel,
     input  i,
     output reg y0,y1,y2,y3);
    
     always @(*) begin
      case(sel)
       2'h0: {y0,y1,y2,y3} = {i,3'b0};
       2'h1: {y0,y1,y2,y3} = {1'b0,i,2'b0};
       2'h2: {y0,y1,y2,y3} = {2'b0,i,1'b0};
       2'h3: {y0,y1,y2,y3} = {3'b0,i};
       default: $display("Invalid sel input");
     endcase
   end 
endmodule

7. Write RTL for designing a 2:4 encoder using behavior-level abstraction:
   module priority_encoderbehave(A, Y);
    input [3:0]Y;
    output reg [1:0]A;
    always@(Y)
     begin

      casex(Y)
      4'b0001:A = 2'b00;
      4'b001x:A = 2'b01;
      4'b01xx:A = 2'b10;
      4'b1xxx:A = 2'b11;
   default:$display("Error!");
   endcase
   end
 endmodule


8. Design of a glitch-free clock mux: Inputs-&gt; pclk_62_5mhz,
pclk_250mhz, rate[1:0]; output pclk, When Rate=&#39;b00 Select 62.5MHZ
Clock; Rate=&#39;b10 Select 250MHZ Clock:



9. Design a negative edge-triggered D flip flop with an active low reset:

   module D_flipflop (
     input clk, rst_n,
     input d,
     output reg q
     );
  
    always@(posedge clk or negedge rst_n) begin
      if(!rst_n) q <= 0;
      else       q <= d;
    end
  
  endmodule
