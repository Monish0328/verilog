module full_adder(
    input a,b,cin,
    output sum,cout
    );
    
    assign{sum,cout}={a^b^cin,((a&b)|(b&cin)|(a&cin))};
endmodule    

module ripple_carry_adder #(parameter SIZE = 4)(
input [SIZE-1:0] a,b,
input cin,
output [SIZE-1:0] s,cout);

genvar g;

full_adder fa0 ( a[0],b[0],cin,s[0],cout[0]);
   generate
      for(g=1;g<SIZE;g=g+1) begin
        full_adder fa(a[g],b[g],cout[g-1],s[g],cout[g]);
        end
   endgenerate
endmodule


module RCA_TB;
  wire [3:0] S, Cout;
  reg [3:0] A, B;
  reg Cin;
  wire[4:0] add;
  
  ripple_carry_adder rca(A, B, Cin, S, Cout);
  assign add = {Cout[3], S};
  
  initial begin
    $monitor("A = %b: B = %b, Cin = %b --> S = %b, Cout[3] = %b, Addition = %0d", A, B, Cin, S, Cout[3], add);
    A = 1; B = 0; Cin = 0; #3;
    A = 2; B = 4; Cin = 1; #3;
    A = 4'hb; B = 4'h6; Cin = 0; #3;
    A = 5; B = 3; Cin = 1; #3;
    $finish;
  end
  
  initial begin
    $dumpfile("waves.vcd");
    $dumpvars;
  end
endmodule
