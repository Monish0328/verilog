module apb_ram_interface
#(
    parameter DATA_WIDTH = 32,      
    parameter ADDR_WIDTH = 10        
)
(
    input wire PCLK,                 
    input wire PSEL,                 
    input wire PENABLE,              
    input wire PWRITE,               
    input wire [ADDR_WIDTH-1:0] PADDR,
    input wire [DATA_WIDTH-1:0] PWDATA, 
    output reg [DATA_WIDTH-1:0] PRDATA, 
    output reg PREADY,               
    output reg PSLVERR               
);

    
    reg we;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;

   
    simple_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) ram_inst (
        .clk(PCLK),
        .we(we),
        .addr(PADDR),
        .din(din),
        .dout(dout)
    );

    
    always @(posedge PCLK) begin
        if (PSEL && PENABLE) begin
            PREADY <= 1;      
            PSLVERR <= 0;

            if (PWRITE) begin
             
                we <= 1;
                din <= PWDATA;
            end else begin
                
                we <= 0;
                PRDATA <= dout;
            end
        end else begin
            PREADY <= 0;
            PSLVERR <= 0;
            we <= 0;
        end
    end

endmodule

module simple_ram
#(
    parameter DATA_WIDTH = 32,       
    parameter ADDR_WIDTH = 10      
)
(
    input wire clk,                 
    input wire we,                  
    input wire [ADDR_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0] din, 
    output reg [DATA_WIDTH-1:0] dout 
);

    
    reg [DATA_WIDTH-1:0] ram [0:2**ADDR_WIDTH-1];

    always @(posedge clk) begin
        if (we) begin
          
            ram[addr] <= din;
        end else begin
            
            dout <= ram[addr];
        end
    end

endmodule





module apb_ram_interface_tb;

   
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 10;

    
    reg PCLK;
    reg PSEL;
    reg PENABLE;
    reg PWRITE;
    reg [ADDR_WIDTH-1:0] PADDR;
    reg [DATA_WIDTH-1:0] PWDATA;
    wire [DATA_WIDTH-1:0] PRDATA;
    wire PREADY;
    wire PSLVERR;

    
    apb_ram_interface #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .PCLK(PCLK),
        .PSEL(PSEL),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR)
    );
    initial begin
	    $dumpfile("apb_ram_interface_tb.vcd");
	    $dumpvars;
    end

  
    initial begin
        PCLK = 0;
        forever #5 PCLK = ~PCLK; 
    end

    
    initial begin
        
        PSEL = 0;
        PENABLE = 0;
        PWRITE = 0;
        PADDR = 0;
        PWDATA = 0;

        
        @(negedge PCLK);

 
        @(negedge PCLK);
        PSEL = 1;
        PWRITE = 1;
        PADDR = 10'h001;
        PWDATA = 32'hDEADBEEF;
        @(negedge PCLK);
        PENABLE = 1;
        @(negedge PCLK);
        PSEL = 0;
        PENABLE = 0;
        PWRITE = 0;

       
        @(negedge PCLK);
        PSEL = 1;
        PWRITE = 0;
        PADDR = 10'h001;
        @(negedge PCLK);
        PENABLE = 1;
        @(negedge PCLK);
        PSEL = 0;
        PENABLE = 0;

    
        if (PRDATA != 32'hDEADBEEF) begin
            $display("ERROR: Read data mismatch at address 0x001. Expected: 0xDEADBEEF, Got: 0x%08X", PRDATA);
        end else begin
            $display("Read operation successful at address 0x001. Data: 0x%08X", PRDATA);
        end

        
        @(negedge PCLK);
        PSEL = 1;
        PWRITE = 1;
        PADDR = 10'h002;
        PWDATA = 32'hCAFEBABE;
        @(negedge PCLK);
        PENABLE = 1;
        @(negedge PCLK);
        PSEL = 0;
        PENABLE = 0;
        PWRITE = 0;

        @(negedge PCLK);
        PSEL = 1;
        PWRITE = 0;
        PADDR = 10'h002;
        @(negedge PCLK);
        PENABLE = 1;
        @(negedge PCLK);
        PSEL = 0;
        PENABLE = 0;

       
        if (PRDATA != 32'hCAFEBABE) begin
            $display("ERROR: Read data mismatch at address 0x002. Expected: 0xCAFEBABE, Got: 0x%08X", PRDATA);
        end else begin
            $display("Read operation successful at address 0x002. Data: 0x%08X", PRDATA);
        end

      
        $finish;
    end

endmodule

