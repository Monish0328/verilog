module impl_top (
input               clk     , 
input               sw_0    , 
input               sw_1    , 
input   wire        uart_rxd, 
output  wire        uart_txd, 
output  wire [7:0]  led
);


parameter CLK_HZ = 50000000;
parameter BIT_RATE =   9600;
parameter PAYLOAD_BITS = 8;

wire [PAYLOAD_BITS-1:0]  uart_rx_data;
wire        uart_rx_valid;
wire        uart_rx_break;

wire        uart_tx_busy;
wire [PAYLOAD_BITS-1:0]  uart_tx_data;
wire        uart_tx_en;

reg  [PAYLOAD_BITS-1:0]  led_reg;
assign      led = led_reg;


assign uart_tx_data = uart_rx_data;
assign uart_tx_en   = uart_rx_valid;

always @(posedge clk) begin
    if(!sw_0) begin
        led_reg <= 8'hF0;
    end else if(uart_rx_valid) begin
        led_reg <= uart_rx_data[7:0];
    end
end


