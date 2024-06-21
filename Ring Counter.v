module ringcounter(clk, rst, count);  
    input clk, rst; 
    output [5:0] count; 
    wire clk, rst; 
    reg [5:0] count = 8'b1;  
      
  always @ ( posedge clk, posedge rst ) 
        begin   
        if ( ~rst )   
            begin     
            count <= count << 1;    
            count[0] <= count[5];   
        end 
          else 
            count <= 8'b1;
    end  

endmodule 

module  ringcounter_tb();  
    reg clk = 0, rst = 0; 
    wire [5:0] count;  
    always #1 clk = ~clk;  

    initial begin   
    $monitor("At time %4t, count = %b", $time, count );  
        #5 rst = 1;   
        #5  rst = 0;
        #200 $finish; 
    end  

    ringcounter cntr01 ( .clk(clk), .rst(rst), .count(count) );  
  
  initial
    begin
      $dumpvars(0,top);
      $dumpfile("my.vcd");
    end
endmodule 
