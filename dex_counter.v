`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:12 12/23/2014 
// Design Name: 
// Module Name:    dex_counter 
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
module dex_counter(
input clk,
input cen, 
input reset,
output reg [3:0] counter,
output carry
    );

	always @(posedge clk) begin
		if (reset)	counter = 0;
		else if (cen) 
			begin		
				if (counter == 10)	counter = 0;
				counter = counter + 1;
			end
	end
	
	assign carry = (counter == 9);

endmodule
