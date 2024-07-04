1. What is the value of y in the below snippet?

    reg [2:0] a, b;
    reg y;
    initial begin
      a= 3&#39;d5;
      b= 3,b111;
      y = a&amp;&amp;b;
    end

2. What is the value of x in the below snippet?

   reg [2:0] a, b;
   reg [2:0]x;
   initial begin
     a=3&#39;d5;
     b=3’b111;
     x= a | b;
   end

3. What is the value of x in the below snippet?

   reg [2:0]a;
   reg [2:0]x;
   initial begin
     x = ^a;
     a = 3&#39;d4;
   end

4. Evaluate the value of x in the below snippet.

   reg [3:0]a;
   reg [1:0]x;
   initial begin
     a = 4&#39;d10;
     X= (a&gt;&gt;1);
   end

5. Find the value of b in the below snippet.

   reg [3:0]a;
   reg [6:0]b;
   initial begin
      a=4&#39;d10;
      b={a,1};
   end

6. Which block executes in the below snippet and justify the
reason:
   reg [3:0]a= 4&#39;b110x;
   initial begin
      if (a== 4&#39;b1100)
       begin: B1
       end
     else
      begin: B2 
      end
   end

7. Which block executes in the below snippet and justify the
reason.
   reg [3:0]a= 4&#39;b110x;
   initial begin
     if ( a !== 4&#39;b1100)
       begin: B1
       end
     else
       begin: B2 
       end
   end

8. What is the value of y in the below expression and justify the
reason.

   reg [3:0]a= 4&#39;b110x;
   wire y = (a== 4&#39;b1100)?1&#39;b1:1&#39;b0;

9. What is the value of y in the below expression and justify the
reason.

   reg [3:0]a= 4&#39;b010x;
   wire y = (a== 4&#39;b1100)?1&#39;b1:1&#39;b0;

10. What is the value of b in the below expression and justify the
reason.

   reg [3:0]a= 4&#39;b0100;
   reg [3:0]b;
   initial begin
     b = a+1&#39;bx;
   end

11. Design a 4 bit ALU circuit to perform arithmetic and logic
operations.

Based on sel signal output will be assigned.

  If sel =3&#39;b000 =&gt; addition
  3&#39;b001 =&gt; subtraction
  3&#39;b010 =&gt; division
  3&#39;b011 =&gt; logical and
  3&#39;b100 =&gt; bitwise and
  3&#39;b101 =&gt; bitwise or
  3&#39;b110 =&gt; bitwise nand
  3&#39;b111 =&gt; bitwise xnor
