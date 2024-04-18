`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/18 12:15:32
// Design Name: 
// Module Name: SPI
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


module SPI(
clk,PRESET_N,MOSI,SSEL,SCK,Tx_byte_data,data_in_val,MISO,byte_data_received,data_out_ready,bitcnt
    );
input clk;
input PRESET_N;
output MISO;
input MOSI;
input SSEL;
input SCK;
output reg [7:0] byte_data_received;
output reg data_out_ready;
input [7:0] Tx_byte_data;
input data_in_val;

// CLK Synchronizing
reg [2:0] SCKr; always @(posedge clk) SCKr <= {SCKr[1:0],SCK};
wire SCK_risingedge = (SCKr[2:1]==2'b01);
wire SCK_fallingedge = (SCKr[2:1]==2'b10);
reg [2:0] SSELr; always @(posedge  clk) SSELr <= {SSELr[1:0],SSEL};
wire SSEL_active = ~SSELr[1];
// Q.why set SSELr bit to 3bit?
// A.to alert whether start or end by using message.

wire SSEL_startmessage = (SSELr[2:1] ==2'b10); // message starts at falling edge
wire SSEL_endmessage = (SSELr[2:1] == 2'b01); //message stops at rising edge
reg [1:0] MOSIr; always @(posedge clk) MOSIr <= {MOSIr[0],MOSI} ;
wire MOSI_data = MOSIr[1];
output reg [2:0] bitcnt;

always @(posedge clk) begin
    if(~SSEL_active) begin 
        bitcnt <= 3'b000;
        byte_data_received <= 8'b00000000;
        data_out_ready <=1'b0;
    end else if (SCK_risingedge) begin //(!SSEL_active && SCK_rigingedge)
        bitcnt <= bitcnt + 3'b001;
        byte_data_received <= {byte_data_received[6:0], MOSI_data}; //MSB First Shift Register
    end
end

always @(posedge clk) data_out_ready <= SSEL_active && SCK_risingedge && (bitcnt==3'b111);
reg [7:0] byte_data_sent;
reg [7:0] cnt;

always @(posedge clk) begin
    if(data_in_val) begin
        byte_data_sent <=Tx_byte_data;
    end else if(SSEL_startmessage) begin
        byte_data_sent <= byte_data_sent;
    end else if(SSEL_active) begin
        if(SCK_fallingedge) begin
            if(bitcnt==3'b000) begin
                //byte_data_sent <=8'b0;
            end else begin
                byte_data_sent <= byte_data_sent<<1;
            end
        end
    end
end   
endmodule
