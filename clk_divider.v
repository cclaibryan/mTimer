`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:06:35 12/23/2014 
// Design Name: 
// Module Name:    clk_divider 
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
module clk_divider(
input clk_input,
output clk_output
    );
parameter rate = 1000;

reg [16:0] counter = 0;
assign clk_output = ( counter == rate );

always @(posedge clk_input) begin
	if (counter == rate)  counter <= 1;
	else  				    	counter <= counter + 1;
end

endmodule
