`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:19:13 12/23/2014 
// Design Name: 
// Module Name:    seg7show 
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
module seg7show(
input clk,
input [15:0] second,
output reg dp,
output reg [3:0] an,
output reg [6:0] seg
    );

	wire segClk;
	reg [1:0] counter;
	reg [3:0] currentInput;
	reg [16:0] clk_counter  = 0;
	
	always @(posedge clk) begin
		clk_counter = clk_counter + 1;
	end
		
	assign segClk = clk_counter[16];

	always @(posedge segClk) begin
		counter <= counter + 1;
		
		case (counter) 
			2'b00:
				begin
					an = 4'b1110;
					currentInput <= second[3:0];
					dp = 1;
				end
			2'b01:
				begin
					an = 4'b1101;
					currentInput <= second[7:4];
					dp = 1;
				end
			2'b10:	
				begin
					an = 4'b1011;
					currentInput <= second[11:8];
					dp = 1;				
				end
			2'b11: 
				begin
					an = 4'b0111;
					currentInput <= second[15:12];
					dp = 0;
				end
			default:
				begin
					an = 4'b1111;
					currentInput <= second[3:0];
				end
		endcase
	end

	always @(*) begin
		case (currentInput)
			0: seg = 7'b0000001; 
			1: seg = 7'b1001111; 
			2: seg = 7'b0010010; 
			3: seg = 7'b0000110; 
			4: seg = 7'b1001100; 
			5: seg = 7'b0100100; 
			6: seg = 7'b0100000; 
			7: seg = 7'b0001111; 
			8: seg = 7'b0000000; 
			9: seg = 7'b0000100; 
			default: seg = 7'b0000001;
		endcase
	end

endmodule
