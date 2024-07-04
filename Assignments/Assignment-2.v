1. What is the value of y in binary format in the below snippet?

   reg [5:0] y;
   initial
   begin
   y= &#39;Ox2;
   end

2. What is the value of the b in the below snippet?

   integer b;
   initial begin
     b= -&#39;d12/3;
   end

3. What value is passed across the port b in the below snippet?

   module test(output [32:0]b);
    real a=14.5;
    assign b = a;
   endmodule

4. Find the value of the variable t at 1ns &amp; 20ns respectively from the
below snippet:
  time = t;
  initial begin
   #10 t= $time;
   #20 ;
  end


5. Write an RTL snippet to initialize all the locations of an array of size:10x8 to
0 at 0ns. Depth= 10, Width = 8bits:


6. What will be the value of the parameter constant for the instance DUT in
the top module from the below snippet?
  module test;
   parameter WIDTH=8;
 endmodule
 module top;
  test #(16) OUT ( );
 endmodule

7. What is the bug in the following snippet?
   module test;
     parameter WIDTH=8;
   endmodule
   module top;
     test OUT ( ) ;
     initial
     defparam OUT.WIDTH=10;
   endmodule


  8. What will be displayed in the console mode for the below snippet?

    reg[13*8:1]s;
    initial begin
      s = &quot;hello world&quot;;
      $display(&quot;Value = %s&quot;,s[104:65]);
    end
