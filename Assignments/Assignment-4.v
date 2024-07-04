1. What value of a is displayed on the console output? Justify the
same.
   reg[1:0]a;
   initial begin
    $display($time,“a=%d”,a);
    a =2’d3;
    #10;
    a = 2’d2;
   end

2. What is the value of b displayed on the console output? Justify the
same.

   reg[1:0]b;
    initial begin
      $strobe($time,“b=%d”,b);
      b =2’d3;
      b = 2’dx;
      #10;
      b = 2’d2;
    end

3. What values are monitored for the variable b till the end of
simulation time? Display the same.

   reg[1:0]b;
   initial begin
     $monitor($time,“b=%d”,b);
     b = 2’d0;
     b = 2’dx;
     #10;
     b = 2’d2;
     #10;
     b = 2’d1;
     $monitoroff;
     #10;
     b = 2’d2;
    $monitoron;
    #10;
    #100 $finish;
  end

4. Display the console output for the following.

  `timescale 10ns/1ns
   parameter P=15.5;
   reg a;
   initial begin
     $monitor($time,“Value of a = %b”,a); #P a =
     1’b1;
     #P a = 1’b0;
   end

5. Display the console output for the following.
  `timescale 10ns/1ns
   parameter P=15.5 ;
   reg a ;
   initial begin
    $monitor($realtime,“Value of a = %b”,a);
    #P a = 1’b1;
    #P a = 1’b0;
   end

6. Write Verilog code in order to generate 5 odd random numbers
between 1 to 10.

7. Write RTL code for designing a JK Flip-flop and use the following input
states as `define macro: SET, RESET, TOGGLE, HOLD. 

  
8. Write Verilog code in order to generate a clock signal of frequency ;
1Ghz. Use the following timescale: `timescale 1us/1ps

9. Write Verilog code for reading an external file “f1.txt” from the path
location/home/user1/sim and transfer the contents of the file to
an 8-bit data_in bus in every clock cycle.

  
10. Find the bug if any in the following File write operation snippet.

  module test ;
      reg [5:0]channel ;
      reg a ;
      initial begin
       channel = $fopen(“file1.txt”);
       $monitor(channel,”a=%b”,a);
      end
  endmodule
