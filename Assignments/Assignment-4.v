1. What value of a is displayed on the console output? Justify the
same.
   reg[1:0]a;
   initial begin
    $display($time,“a=%d”,a);
    a =2’d3;
    #10;
    a = 2’d2;
   end

  A:If $display executes before a , it will display a=0.
   If $display executes after a , it will display a=2.

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

   A:It will display b=0 initially .
     Then, b is assigned 3 (2'b11).
     Next, b is assigned x, unknown value.
     After a delay of 10 ns, b is assigned 2 (2'b10).
    

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

    A:0,x,2,1,2.

4. Display the console output for the following.

  `timescale 10ns/1ns
   parameter P=15.5;
   reg a;
   initial begin
     $monitor($time,“Value of a = %b”,a); 
      #P a = 1’b1;
      #P a = 1’b0;
   end
     A:0 Value of a = x.
       15.5 Value of a = 1.
       31 Value of a = 0.

5. Display the console output for the following.
  `timescale 10ns/1ns
   parameter P=15.5 ;
   reg a ;
   initial begin
    $monitor($realtime,“Value of a = %b”,a);
    #P a = 1’b1;
    #P a = 1’b0;
   end
    A:0 Value of a = x.
    15.5 Value of a = 1.
    31 Value of a = 0.

6. Write Verilog code in order to generate 5 odd random numbers
between 1 to 10.
   A:module OddRandomNumbers (
     output reg [3:0] odd_numbers [0:4]);
     initial begin
     integer i;
     integer count = 0;
    
     while (count < 5) begin
        odd_numbers[count] = ($random % 5) * 2 + 1; 
        if (odd_numbers[count] <= 10 && odd_numbers[count] >= 1) begin
            count = count + 1;
        end
     end
     $display("Generated odd numbers:");
     for (i = 0; i < 5; i = i + 1) begin
        $display("%d", odd_numbers[i]);
     end
     $finish;
     end

     endmodule

7. Write RTL code for designing a JK Flip-flop and use the following input
states as `define macro: SET, RESET, TOGGLE, HOLD. 
   A:module JK_FlipFlop (
    input J, 
    input K, 
    input wire SET,   
    input wire RESET, 
    input wire TOGGLE,
    input wire HOLD,  
    output reg Q,     
    output reg Qbar );

    always @* begin
        if (SET) begin
            Q = 1'b1;   
        end else if (RESET) begin
            Q = 1'b0;   
        end else if (TOGGLE) begin
            Q = ~Q;     
        end else if (!HOLD) begin
        end
    end

    assign Qbar = ~Q;   // Qbar is the complement of Q

    endmodule

  
8. Write Verilog code in order to generate a clock signal of frequency ;
1Ghz. Use the following timescale: `timescale 1us/1ps
   A:`timescale 1us/1ps   
      module ClockGenerator (
      output reg clk   );

      reg [31:0] counter;
      initial begin
        counter = 32'd0;   
        clk = 1'b0;     
        forever begin
            #0.5;           
            clk = ~clk;     
            counter = counter + 1; 
        end
        end

      endmodule


9. Write Verilog code for reading an external file “f1.txt” from the path
location/home/user1/sim and transfer the contents of the file to
an 8-bit data_in bus in every clock cycle.

   A:module FileDataTransfer (
    input wire clk,      
    output reg [7:0] data_in );

    reg [7:0] file_data;  
    reg [31:0] file_length; 
    integer file_handle;   e
    initial begin
        file_handle = $fopen("/home/user1/sim/f1.txt", "r"); 
        if (file_handle == 0) begin
            $display("Error opening file.");
            $finish;
        end
        
        file_length = $fsize(file_handle);
        $display("File size: %d bytes", file_length);
        $fclose(file_handle);
    end

   
    always @(posedge clk) begin
        file_handle = $fopen("/home/user1/sim/f1.txt", "r");
        if (file_handle != 0) begin
            $fscanf(file_handle, "%h", file_data);
            $fclose(file_handle); 
            data_in <= file_data; 
        end
        end
    endmodule


  
10. Find the bug if any in the following File write operation snippet.

  module test ;
      reg [5:0]channel ;
      reg a ;
      initial begin
       channel = $fopen(“file1.txt”);
       $monitor(channel,”a=%b”,a);
      end
  endmodule


   A:
  1. The $open task is used wrong. The correct syntax for $fopen when opening a file for reading or writing should include the mode "r" for reading and "w" for writing.
  2. The $monitor system task is used incorrectly . It is used for monitoring variables and their changes in the simulation. Here, it is not used with its correct arguments format.
