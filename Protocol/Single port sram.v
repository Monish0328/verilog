module spsram(
    clk,
    cs,
    we,
    addr,
    din,
    dout
);

parameter mem_depth = 1024;
parameter mem_width = 32;
parameter mem_bitw = 10;

input wire clk;
input wire cs;
input wire we;
input wire [mem_bitw-1:0] addr;
input wire [mem_width-1:0] din;
output reg [mem_width-1:0] dout;

reg [mem_width-1:0] mem[0:mem_depth-1];

always @(posedge clk) begin
    if (cs) begin
        if (we) begin
            mem[addr] <= din;
        end
        else begin
            dout <= mem[addr];
        end
    end          
end

endmodule


module apb_sram_inf(
    clk,
    rstn,
    psel,
    penable,
    paddr,
    pwrite,
    pwdata,
    pready,
    prdata
);

parameter mem_depth = 1024;
parameter mem_width = 32;
parameter mem_bitw = 10;

parameter IDEL = 0;
parameter SETUP = 1;
parameter ENABLE = 2;

input wire clk;
input wire rstn;
input wire psel;
input wire penable;
input wire [mem_bitw+1:0] paddr;        
input wire pwrite;
input wire [31:0] pwdata;
output wire pready;
output reg [31:0] prdata;

reg [1:0] sta;
reg [1:0] nsta;
reg apb_write;
reg apb_read;
reg pready_pre;
reg [mem_bitw-1:0] apb_addr;
reg [31:0] apb_wdata;

wire mem_cs;
wire mem_we;
wire [mem_width-1:0] mem_dout;


always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        sta = 2'd0;
    end
    else begin
        sta = nsta;
    end
end


always @(*) begin
    nsta = sta;
    case (sta) 
        IDEL: begin
            if ((psel==1'b1) && (penable==1'b0)) begin
                nsta = SETUP;
            end
            else begin
                nsta = IDEL;
            end
        end
        SETUP: begin
            if ((psel==1'b1) && (penable==1'b1)) begin
                nsta = ENABLE;
            end
            else begin
                nsta = IDEL;
            end
        end
        ENABLE: begin
            if ((psel==1'b1) && (penable==1'b1)) begin
                nsta = ENABLE;
            end
            else begin
                nsta = IDEL;
            end
        end
        default: begin
            nsta <= IDEL;
        end
    endcase
end


always @(*) begin
    if (sta==IDEL) begin
        apb_write = 1'b0;
        apb_read = 1'b0;
        pready_pre = 1'b0;
    end
    else if (sta==SETUP) begin
        apb_addr = paddr[mem_bitw+1:2];
        if (pwrite) begin
            apb_write = 1'b1;
            apb_read = 1'b0;
            apb_wdata = pwdata;
            pready_pre = 1'b0;
        end
        else if (!pwrite) begin
            apb_write = 1'b0;
            apb_read = 1'b1;
            pready_pre = 1'b0;
        end
    end
    else if (sta==ENABLE) begin
        if (pwrite) begin
            pready_pre = 1'b1;
        end 
        else if (!pwrite) begin
            prdata = mem_dout;
            pready_pre = 1'b1;
        end
    end
end

assign pready = pready_pre;                
assign mem_cs = (apb_write | apb_read);     
assign mem_we = apb_write;                 

spsram u_spsram(
    .clk(clk),
    .cs(mem_cs),
    .we(mem_we),
    .addr(apb_addr),
    .din(apb_wdata),
    .dout(mem_dout)
);

endmodule


module apb_sram_inf_tb;

reg clk;
reg rstn;
reg psel;
reg penable;
reg [11:0] paddr;
reg pwrite;
reg [31:0] pwdata;
wire pready;
wire [31:0] prdata;

apb_sram_inf u_apb_sram_inf(
    .clk(clk),
    .rstn(rstn),
    .psel(psel),
    .penable(penable),
    .paddr(paddr),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .pready(pready),
    .prdata(prdata)
);

initial clk = 1'b0;
always #10 clk = ~clk;

initial begin
    rstn = 1'b0;
    #20
    rstn = 1'b1;
    psel = 1'b0;
    penable= 1'b0;

   
    #10
    psel = 1'b1;
    paddr = 12'hff1;
    pwrite = 1'b1;
    pwdata = 32'hffff_ff01;
    #20
    penable = 1'b1;
    #20
    penable = 1'b0;
    psel = 1'b0;

   
    #20
    psel = 1'b1;
    paddr = 12'hff1;
    pwrite = 1'b0;
   
    #20
    penable = 1'b1;
    #20
    penable = 1'b0;
    psel = 1'b0;

    #40
    $finish;
end


initial begin
    $dumpfile("apb_sram_inf_tb.vcd");
    $dumpvars;
end


endmodule

