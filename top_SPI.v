`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/18 12:42:05
// Design Name: 
// Module Name: top_SPI
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_SPI(
clk,
rst_n,
SPI_SCK,
SPI_MISO,
SPI_MOSI,
SPI_CS,
led,
byte_data_received,
bitcnt,
data_out_ready
    );
input clk;
input rst_n;
input wire SPI_SCK;
output wire SPI_MISO;
input wire SPI_MOSI;
input wire SPI_CS;
output reg [7:0] led;
output [7:0] byte_data_received;
output wire [2:0] bitcnt;
output wire data_out_ready;
//clock_divider u_clock_divider();
wire [7:0] count;
//wire [7:0] byte_data_received;
//wire data_out_ready;
reg [7:0] Tx_byte_data;
//reg data_in_val;
//wire fifo_empty;
//wire [4:0] tail;

SPI U_SPI (
.clk(clk),
.PRESET_N(rst_n),
.MOSI(SPI_MOSI),
.SSEL(SPI_CS),
.SCK(SPI_SCK),
.Tx_byte_data(Tx_byte_data),
.data_in_val(data_in_val),
.MISO(SPI_MISO),
.byte_data_received(byte_data_received),
.data_out_ready(data_out_ready),
.bitcnt(bitcnt));
//reg [15:0] pulseCNT=16'h0000;
//reg [7:0] limit_val;
//reg fifo_write=1'b0;
//reg fifo_read=1'b0;

//wire fifo_full;

//reg flag=1'b0;

always @(posedge clk or negedge rst_n) begin
    if(rst_n) begin
      led<=8'b0;
    end else begin
        if(data_out_ready) begin
            led<=byte_data_received;
        end
    end
end

endmodule
