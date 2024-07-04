1. What is the value of y in binary format in the below snippet?

   reg [5:0] y;
   initial begin
    y='Ox2;
   end
  A:0010

2. What is the value of the b in the below snippet?

   integer b;
   initial begin
     b= -'d12/3;
   end
   A: b= -4

3. What value is passed across the port b in the below snippet?

   module test(output [32:0]b);
    real a=14.5;
    assign b = a;
   endmodule

  A: b=14.5

4. Find the value of the variable t at 1ns &amp; 20ns respectively from the
below snippet:
  time = t;
  initial begin
   #10 t= $time;
   #20 ;
  end
 A: t=10ns


5. Write an RTL snippet to initialize all the locations of an array of size:10x8 to
0 at 0ns. Depth= 10, Width = 8bits:

  A:
    module initialize_array;
    reg [7:0] array [0:9][0:7];
    initial begin
    for (int i = 0; i < 10; i++) begin
      for (int j = 0; j < 8; j++) begin
        array[i][j] = 8'b0; 
      end
      end
     end
    initial begin
      $finish;
    end
    endmodule


6. What will be the value of the parameter constant for the instance DUT in
the top module from the below snippet?
  module test;
   parameter WIDTH=8;
 endmodule
 module top;
  test #(16) OUT ( );
 endmodule

   A:  in module test parameter is 8,
      during instantiation it is overridden by 16.

7. What is the bug in the following snippet?
   module test;
     parameter WIDTH=8;
   endmodule
   module top;
     test OUT ( ) ;
     initial
     defparam OUT.WIDTH=10;
   endmodule

      A: parameters should be set explicitly at module instantiation rather than using defparam statements inside procedural blocks like 'initial'.


  8. What will be displayed in the console mode for the below snippet?

    reg[13*8:1]s;
    initial begin
      s = &quot;hello world&quot;;
      $display(&quot;Value = %s&quot;,s[104:65]);
    end
    
      A:
