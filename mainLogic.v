`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:27 12/23/2014 
// Design Name: 
// Module Name:    mainLogic 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mainLogic(
input start, 
input stop,
input inc,
input clk,
input reset,
output [3:0] an,
output [6:0] seg,
output dp
    );

	parameter STOP = 2'b00;
	parameter START = 2'b01;
	parameter INC = 2'b10;
	
	wire [3:0] carry;
	wire [1:0] currentState;
	wire [15:0] whole_num;
	wire clk_1k;
	reg cen;
	
	//1KHz clock generater
	clk_divider #100000 divider(.clk_input(clk), .clk_output(clk_1k));
	
	fsm myFSM(.start(start), .stop(stop), .inc(inc), .clk(clk), .reset(reset), .state(currentState));
	
	always @(*) begin
		if (currentState == STOP)	cen = 0;
		else 								cen = 1;
	end

	//four deximal counters
	dex_counter count_1(.clk(clk), .cen(cen && clk_1k),.reset(reset), .counter(whole_num[3:0]),.carry(carry[0]));
	dex_counter count_10(.clk(clk), .cen(cen && carry[0] && clk_1k),.reset(reset), .counter(whole_num[7:4]),.carry(carry[1]));
	dex_counter count_100(.clk(clk), .cen(cen && carry[0] && carry[1] && clk_1k ),.reset(reset), .counter(whole_num[11:8]),.carry(carry[2]));
	dex_counter count_1000(.clk(clk), .cen(cen && carry[0] && carry[1] && carry[2] && clk_1k),.reset(reset), .counter(whole_num[15:12]),.carry(carry[3]));
	
	seg7show myShower(.clk(clk), .second(whole_num), .dp(dp), .an(an), .seg(seg));
	

endmodule
