//Arithmatic Operators:
module arithmetic_op;
  reg [3:0] i1, i2;
  initial begin
    i1 = 4'h6;
    i2 = 4'h2;
    
    $display("i1 = %0h and i2 = %0h", i1, i2);
    $display("Add: %0h", i1 + i2);
    $display("Sub: %0h", i1 - i2);
    $display("Mul: %0h", i1 * i2);
    $display("Div: %0h", i1 / i2);
    $display("pow: %0h", i2 ** 3);
    $display("Mod: %0h", i1 % i2);
    
    i1 = 4'ha; i2 = 4'h3;
    $display("\ni1 = %0h and i2 = %0h", i1, i2);
    $display("Mod: %0h", i1 % i2);
  end
endmodule

Output:
i1 = 6 and i2 = 2
Add: 8
Sub: 4
Mul: c
Div: 3
pow: 8
Mod: 0

i1 = a and i2 = 3
Mod: 1


//Logical Operators:
module logical_op;
  reg [3:0] i1, i2;
  initial begin
    i1 = 4'h6; i2 = 4'h2;
    $display("For operator: (&&): i1 = %0h && i2 = %0h: %h", i1, i2, i1 && i2);
    $display("For operator: (||): i1 = %0h || i2 = %0h: %h", i1, i2, i1 || i2);
    $display("For operator: (!) : i1 = %0h !  i2 = %0h: %h", i1, i2, !i1);
    
    i1 = 4'b1x0z; i2 = 4'b0x1x;
    $display("For operator: (&&): i1 = %0b && i2 = %0b: %h", i1, i2, i1 && i2);
    $display("For operator: (||): i1 = %0b || i2 = %0b: %h", i1, i2, i1 || i2);
  end
endmodule

Output:
For operator: (&&): i1 = 6 && i2 = 2: 1
For operator: (||): i1 = 6 || i2 = 2: 1
For operator: (!) : i1 = 6 !  i2 = 2: 0
For operator: (&&): i1 = 1x0z && i2 = x1x: 1
For operator: (||): i1 = 1x0z || i2 = x1x: 1

//Equality Operators:
module equality_op;
  reg [3:0] i1, i2;
  initial begin
    i1 = 4'h6; i2 = 4'h2;
    $display("For operator: (==): (i1 = %0h) == (i2 = %0h) --> %h", i1, i2, i1 == i2);
    $display("For operator: (!=): (i1 = %0h) != (i2 = %0h) --> %h", i1, i2, i1 != i2);
    
    i1 = 4'b1x0z; i2 = 4'b1x0z;
    $display("For operator: (==) : (i1 = %0b) ==  (i2 = %0b) --> %0b", i1, i2, i1 == i2);
    $display("For operator: (!=) : (i1 = %0b) !=  (i2 = %0b) --> %0b", i1, i2, i1 != i2);
    
    $display("For operator: (===) : (i1 = %0b) ===  (i2 = %0b) --> %0b", i1, i2, i1 === i2);
    $display("For operator: (!==) : (i1 = %0b) !==  (i2 = %0b) --> %0b", i1, i2, i1 !== i2);
    
    i1 = 4'b1x0z; i2 = 4'b1x0x;
    $display("For operator: (===) : (i1 = %0b) ===  (i2 = %0b) --> %0b", i1, i2, i1 === i2);
    $display("For operator: (!==) : (i1 = %0b) !==  (i2 = %0b) --> %0b", i1, i2, i1 !== i2);
  end
endmodule

Output:
For operator: (==): (i1 = 6) == (i2 = 2) --> 0
For operator: (!=): (i1 = 6) != (i2 = 2) --> 1
For operator: (==) : (i1 = 1x0z) ==  (i2 = 1x0z) --> x
For operator: (!=) : (i1 = 1x0z) !=  (i2 = 1x0z) --> x
For operator: (===) : (i1 = 1x0z) ===  (i2 = 1x0z) --> 1
For operator: (!==) : (i1 = 1x0z) !==  (i2 = 1x0z) --> 0
For operator: (===) : (i1 = 1x0z) ===  (i2 = 1x0x) --> 0
For operator: (!==) : (i1 = 1x0z) !==  (i2 = 1x0x) --> 1

//Relational Operators:
module relational_op;
  reg [3:0] i1, i2;
  initial begin
    i1 = 4'h6; i2 = 4'h2;
    $display("For operator: (>) : i1 = %0h >  i2 = %0h: %h", i1, i2, i1>i2);
    $display("For operator: (>=): i1 = %0h >= i2 = %0h: %h", i1, i2, i1>=i2);
    $display("For operator: (<) : i1 = %0h <  i2 = %0h: %h", i1, i2, i1<i2);
    
    i1 = 4'h2; i2 = 4'h6;
    $display("For operator: (<) : i1 = %0h <  i2 = %0h: %h", i1, i2, i1<i2);
    $display("For operator: (<=): i1 = %0h <= i2 = %0h: %h", i1, i2, i1<=i2);
    $display("For operator: (>) : i1 = %0h >  i2 = %0h: %h", i1, i2, i1>i2);
  end
endmodule

Output:
For operator: (>) : i1 = 6 >  i2 = 2: 1
For operator: (>=): i1 = 6 >= i2 = 2: 1
For operator: (<) : i1 = 6 <  i2 = 2: 0
For operator: (<) : i1 = 2 <  i2 = 6: 1
For operator: (<=): i1 = 2 <= i2 = 6: 1
For operator: (>) : i1 = 2 >  i2 = 6: 0


// Bitwise Operators:
module bitwise_op;
  reg [3:0] i1, i2;
  initial begin
    i1 = 4'h6; i2 = 4'h2;
    $display("For operator: (&) : i1 = %b &  i2 = %b: %h", i1, i2, i1 & i2);
    $display("For operator: (|) : i1 = %b |  i2 = %b: %h", i1, i2, i1 | i2);
    $display("For operator: (^) : i1 = %b ^  i2 = %b: %h", i1, i2, i1 ^ i2);
    $display("For operator: (~) : i1 = %b ~  i2 = %b: %h", i1, i2, ~i1);
    $display("For operator: (~^): i1 = %b ~^ i2 = %b: %h", i1, i2, i1 ~^ i2);
    
    i1 = 4'b1x0z; i2 = 4'b0x1x;
    $display("For operator: (&) : i1 = %b &  i2 = %b: %b", i1, i2, i1 & i2);
    $display("For operator: (|) : i1 = %b |  i2 = %b: %b", i1, i2, i1 | i2);
    $display("For operator: (^) : i1 = %b ^  i2 = %b: %b", i1, i2, i1 ^ i2);
    $display("For operator: (~) : i1 = %b ~  i2 = %b: %b", i1, i2, ~i1);
    $display("For operator: (~^): i1 = %b ~^ i2 = %b: %b", i1, i2, i1 ~^ i2);
  end
endmodule

Output:
For operator: (&) : i1 = 0110 &  i2 = 0010: 2
For operator: (|) : i1 = 0110 |  i2 = 0010: 6
For operator: (^) : i1 = 0110 ^  i2 = 0010: 4
For operator: (~) : i1 = 0110 ~  i2 = 0010: 9
For operator: (~^): i1 = 0110 ~^ i2 = 0010: b
For operator: (&) : i1 = 1x0z &  i2 = 0x1x: 0x0x
For operator: (|) : i1 = 1x0z |  i2 = 0x1x: 1x1x
For operator: (^) : i1 = 1x0z ^  i2 = 0x1x: 1x1x
For operator: (~) : i1 = 1x0z ~  i2 = 0x1x: 0x1x
For operator: (~^): i1 = 1x0z ~^ i2 = 0x1x: 0x0x

//Conditional Operator:
module conditional_op;
  reg [3:0] i1, i2;
  reg [3:0] result;
  initial begin
    i1 = 4'h6; i2 = 4'h2;
    $display("i1 = %0h, i2 = %0h", i1, i2);
    result = (i1 > i2)? 1 : 0;
    $display("result = %0h", result);
    
    i1 = 4'h6; i2 = 4'h6;
    $display("i1 = %0h, i2 = %0h", i1, i2);
    result = (i1 > i2)? 1 : 0;
    $display("result = %0h", result);
    
    i1 = 4'b1x00; i2 = 4'b0100;
    $display("i1 = %b, i2 = %b", i1, i2);
    result = (i1 > i2)? (i1 & i2) : (i1 | i2);
    // The outcome is ambiguous then both <true_expression> and <false_expression>
    // will be evaluated and compared to compute outcome
    // <true_expression>  = i1 & i2 = 4'b0x00
    // <false_expression> = i1 | i2 = 4'b1x00
    // result = xx00;
    $display("result = %b", result);
  end
endmodule

Output:
i1 = 6, i2 = 2
result = 1
i1 = 6, i2 = 6
result = 0
i1 = 1x00, i2 = 0100
result = xx00

//Shift Operators:
module shift_op;
  reg [7:0] i1, o1;
  reg signed [7:0] i2, o2;
  
  initial begin
    // Logical shift
    i1 = 8'b1111_0000;
    o1 = i1 >> 3;
    $display("Shift right (>>) i1 = %b by 3: %b", i1, o1);
    i1 = o1;
    
    o1 = i1 << 3;
    $display("Shift left (<<) i1 = %b by 3: %b", i1, o1);
    
    // Arithmatic shift
    i2 = 8'b1111_0000;
    o2 = i2 >>> 3;
    $display("Shift right (>>>) i2 = %b by 3: %b", i2, o2);
    i2 = o2;
    
    o2 = i2 <<< 3;
    $display("Shift left (<<<) i2 = %b by 3: %b", i2, o2);
  end
endmodule

Output:
Shift right (>>) i1 = 11110000 by 3: 00011110
Shift left (<<) i1 = 00011110 by 3: 11110000
Shift right (>>>) i2 = 11110000 by 3: 11111110
Shift left (<<<) i2 = 11111110 by 3: 11110000

//Reduction Operators:
module reduction_op;
  reg [3:0] i1;
  initial begin
    i1 = 4'h6;
    $display("For operator: (&)  : i1 = %b -> %b", i1, &i1);
    $display("For operator: (|)  : i1 = %b -> %b", i1, |i1);
    $display("For operator: (^)  : i1 = %b -> %b", i1, ^i1);
    $display("For operator: (~&) : i1 = %b -> %b", i1, ~&i1);
    $display("For operator: (~|) : i1 = %b -> %b", i1, ~|i1);
    $display("For operator: (~^) : i1 = %b -> %b", i1, ~^i1);
       
    i1 = 4'b1x0z;
    $display("For operator: (&)  : i1 = %b -> %b", i1, &i1);
    $display("For operator: (|)  : i1 = %b -> %b", i1, |i1);
    $display("For operator: (^)  : i1 = %b -> %b", i1, ^i1);
    $display("For operator: (~&) : i1 = %b -> %b", i1, ~&i1);
    $display("For operator: (~|) : i1 = %b -> %b", i1, ~|i1);
    $display("For operator: (~^) : i1 = %b -> %b", i1, ~^i1);
  end
endmodule

Output:
For operator: (&)  : i1 = 0110 -> 0
For operator: (|)  : i1 = 0110 -> 1
For operator: (^)  : i1 = 0110 -> 0
For operator: (~&) : i1 = 0110 -> 1
For operator: (~|) : i1 = 0110 -> 0
For operator: (~^) : i1 = 0110 -> 1
For operator: (&)  : i1 = 1x0z -> 0
For operator: (|)  : i1 = 1x0z -> 1
For operator: (^)  : i1 = 1x0z -> x
For operator: (~&) : i1 = 1x0z -> 1
For operator: (~|) : i1 = 1x0z -> 0
For operator: (~^) : i1 = 1x0z -> x


//Concatination Operators:
module concatenation_op;
  reg [1:0] i1, i2;
  reg [3:0] i3;
  reg [7:0] out;
  
  initial begin
    i1 = 2'h2; i2 = 2'h3;
    i3 = 4'h8;
    
    $display("out = %b", {i3, i2, i1});
    $display("out = %b", {i3, i2, 2'b11});
    $display("out = %b", {i3, i2[1], 1'b1, i1[0]});
  end
endmodule

Output:
out = 10001110
out = 10001111
out = 1000110

//Replication Operators:
module replication_op;
  reg [1:0] i1, i2;
  reg [7:0] out;
  
  initial begin
    i1 = 2'h2; i2 = 2'h3;
    
    $display("out = %b", {4{i1}});
    $display("out = %b", {{3{i2}}, {2{i1}}} );
  end
endmodule

Output:
out = 10101010
out = 1111111010


