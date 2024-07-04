1. What is the value of y in the below snippet?

    reg [2:0] a, b;
    reg y;
    initial begin
      a= 3'd5;
      b= 3'b111;
      y = a&&b;
    end

    A:y=5.

2. What is the value of x in the below snippet?

   reg [2:0] a, b;
   reg [2:0]x;
   initial begin
     a=3'd5;
     b=3’b111;
     x= a | b;
   end

  A:x=7.

3. What is the value of x in the below snippet?

   reg [2:0]a;
   reg [2:0]x;
   initial begin
     x = ^a;
     a = 3'd4;
   end

  A:x=1.
  

4. Evaluate the value of x in the below snippet.

   reg [3:0]a;
   reg [1:0]x;
   initial begin
     a = 4'd10;
     X= (a>>1);
   end
 A:x= 1
   

5. Find the value of b in the below snippet.

   reg [3:0]a;
   reg [6:0]b;
   initial begin
      a=4'd10;
      b={a,1};
   end

  A:b=21

6. Which block executes in the below snippet and justify the
reason:
reg [3:0]a= 4'b110x;
   initial begin
       if (a== 4'b1100)
       begin: B1
       end
     else
      begin: B2 
      end
   end
  A: If a= 1100: Block B1 will execute.
     If a= 1101, 1110, 1111: Block B2 will execute.

7. Which block executes in the below snippet and justify the
reason.
   reg [3:0]a= 4'b110x;
   initial begin
       if ( a !== 4'b1100)
       begin: B1
       end
     else
       begin: B2 
       end
   end
   A:If a=1100: Block B2 will execute.
     If a=1101, 1110, 1111: Block B1 will execute.

8. What is the value of y in the below expression and justify the
reason.

  reg [3:0]a= 4'b110x;
  wire y = (a== 4'b1100)?b1:b0;

  A:If a=4'b1100,  y = b1.
    If a is  not equal to 4'b1100,  y = b0.

9. What is the value of y in the below expression and justify the
reason.

   reg [3:0]a= 4'b010x;
   wire y = (a== 4'b1100)?1'b1:1'b0;

   A:y=0,  operator ?: will assign y to 1'b0  at runtime for any value.

10. What is the value of b in the below expression and justify the
reason.

       reg [3:0]a= 4'b0100;
       reg [3:0]b;
       initial begin
       b = a+1'bx;
       end
   A:b=If 1'bx = 1'b0: b = 4.
       If 1'bx = 1'b1: b = 5.

11. Design a 4 bit ALU circuit to perform arithmetic and logic
operations.

Based on sel signal output will be assigned.

  If sel =3'b000 => addition
  3'b001 => subtraction
  3'b010 => division
  3'b011 => logical and
  3'b100 => bitwise and
  3'b101 => bitwise or
  3'b110 => bitwise nand
  3'b111 => bitwise xnor
A:
