`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/18 18:31:52
// Design Name: 
// Module Name: top_tb
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


module top_tb;

reg clk;
reg rst_n;
reg SPI_SCK;
wire SPI_MISO;
reg SPI_MOSI;
reg SPI_CS;
wire [7:0] led;
wire [7:0] byte_data_received;
wire [3:0] bitcnt;
top_SPI u_top_SPI(
.clk(clk),
.rst_n(rst_n),
.SPI_SCK(SPI_SCK),
.SPI_MISO(SPI_MISO),
.SPI_MOSI(SPI_MOSI),
.SPI_CS(SPI_CS),
.led(led),
.bitcnt(bitcnt),
.byte_data_received(byte_data_received)
);

always #5 clk=~clk;

initial begin
clk=1'b0;
rst_n=1'b1;
#100
rst_n=1'b0;
SPI_CS =1'b1;
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_CS =1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#200
SPI_SCK=1'b1;
SPI_MOSI=1'b1;
#200
SPI_SCK=1'b0;
SPI_MOSI=1'b0;
#1000
SPI_CS=1'b1;

@(posedge clk);
#13000000
$finish;
end


endmodule
