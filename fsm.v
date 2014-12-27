`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:58 12/23/2014 
// Design Name: 
// Module Name:    fsm 
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
module fsm(
input start, 
input stop, 
input inc,
input clk,
input reset,
output reg [1:0] state
    );

parameter STOP = 2'b00;
parameter START = 2'b01;
parameter INC = 2'b10;

reg [1:0] nextState ;

always @(posedge clk, posedge reset) begin
	if (reset) state = STOP;
	else		  state = nextState;
end

always @(*) begin	
	case (state)
		START: if (stop)		nextState = STOP;
				 else		   	nextState = START;
		STOP:	 if (start)		nextState = START;
				 else if (inc) nextState = INC;
				 else				nextState = STOP;
		INC:	 if (inc)		nextState = INC;
				 else				nextState = STOP;
		default:					nextState = STOP;
	endcase
end
	
endmodule
