1. Write RTL code for designing a Moore overlapping sequence
   detector in order to detect a sequence 1010 with MSB first.


  A:module moore_sequence_detector (
    input wire clk,      
    input wire reset,    
    input wire data_in,  
    output reg detected  ); 
    typedef enum logic [1:0] {   S0,  
                                 S1,  
                                 S2,  
                                 S3   } 
    state_type;
    reg [1:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;     
            detected <= 0;   
        end else begin
            case (state)
                S0: begin
                    if (data_in) begin
                        state <= S1;  
                    end else begin
                        state <= S0;
                    end
                end
                S1: begin
                    if (data_in) begin
                        state <= S2; 
                    end else begin
                        state <= S0; 
                    end
                end
                S2: begin
                    if (data_in) begin
                        state <= S3;  
                    end else begin
                        state <= S0;  
                    end
                end
                S3: begin
                    if (!data_in) begin
                        state <= S0;   
                        detected <= 1;  
                    end else begin
                        state <= S1;  
                    end
                end
                default: state <= S0; 
            endcase
        end
    end

endmodule


2. Write RTL code for designing a Mealy overlapping sequence
   detector in order to detect a sequence 1101 with LSB first.


     A:module mealy_sequence_detector (
    input wire clk,     
    input wire reset,    
    input wire data_in,  
    output reg detected  );
    typedef enum logic [2:0] {  S0,  
                                S1, 
                                S2,  
                                S3, 
                                S4 } state_type;
    reg [2:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;    
            detected <= 0;   
        end else begin
            case (state)
                S0: begin
                    if (data_in) begin
                        state <= S1;  
                    end else begin
                        state <= S0;  
                    end
                end
                S1: begin
                    if (data_in) begin
                        state <= S2; 
                    end else begin
                        state <= S0; 
                    end
                end
                S2: begin
                    if (data_in) begin
                        state <= S3; 
                    end else begin
                        state <= S0; 
                    end
                end
                S3: begin
                    if (data_in) begin
                        state <= S4;  
                        detected <= 1;  
                    end else begin
                        state <= S0;  
                    end
                end
                S4: begin
                    if (!data_in) begin
                        state <= S0;    
                    end else begin
                        state <= S1;    
                    end
                end
                default: state <= S0; 
            endcase
        end
    end

endmodule


3. Write RTL for a synchronous logic control unit for a Vending machine.
The machine can take only two types of coins of denomination 1 and 2
in any order. It delivers only one product that is priced at Rs. 3. On
receiving Rs. 3 the product is delivered by asserting an output X=1
which otherwise remains 0. If it gets Rs. 4 then the product is
delivered by asserting X and also a coin return mechanism is
activated by output Y = 1 to return a Re. 1 coin . There are two
sensors to sense the denomination of the coins that give binary output
as shown in the following table. The clock speed is much higher than
human response time, i.e. no two coins can be deposited in the same
clock cycle.

I J Coin
0 0 No coin dropped
0 1 One Rupee
1 0 Two Rupees
1 1 No coin dropped



  A:module vending_machine_control (
    input wire clk,         
    input wire reset,       
    input wire i, j,        
    output reg X, Y   );

    typedef enum logic [1:0] {
                               IDLE,      
                               ONE_RUPEE, 
                               TWO_RUPEES, 
                               THREE_RUPEES  } state_type;
    reg [1:0] deposited_amount;
    localparam PRODUCT_PRICE = 2'd3;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;           
            deposited_amount <= 2'd0; 
            X <= 1'b0;               
            Y <= 1'b0;               
        end else begin
            state <= next_state; 
            case (state)
                IDLE: begin
                 
                    if (i) begin
                        next_state = ONE_RUPEE;
                        deposited_amount = deposited_amount + 1;
                    end else if (j) begin
                        next_state = TWO_RUPEES;
                        deposited_amount = deposited_amount + 2;
                    end else begin
                        next_state = IDLE;
                    end
                end
                ONE_RUPEE: begin
                    
                    if (j) begin
                        next_state = THREE_RUPEES;
                        deposited_amount = deposited_amount + 2;
                    end else if (deposited_amount == PRODUCT_PRICE) begin
                        next_state = IDLE;
                        X = 1'b1; 
                    end else if (deposited_amount > PRODUCT_PRICE) begin
                        next_state = THREE_RUPEES;
                    end else begin
                        next_state = ONE_RUPEE;
                    end
                end
                TWO_RUPEES: begin
                    if (i) begin
                        next_state = THREE_RUPEES;
                        deposited_amount = deposited_amount + 1;
                    end else if (deposited_amount == PRODUCT_PRICE) begin
                        next_state = IDLE;
                        X = 1'b1; 
                    end else if (deposited_amount > PRODUCT_PRICE) begin
                        next_state = THREE_RUPEES;
                    end else begin
                        next_state = TWO_RUPEES;
                    end
                end
                THREE_RUPEES: begin
                
                    if (deposited_amount == PRODUCT_PRICE) begin
                        next_state = IDLE;
                        X = 1'b1; 
                    end else if (deposited_amount > PRODUCT_PRICE) begin
                        next_state = THREE_RUPEES;
                    end else begin
                        next_state = IDLE;
                        Y = 1'b1; 
                    end
                end
                default: begin
                    next_state = IDLE; 
                end
            endcase
        end
    end

endmodule


