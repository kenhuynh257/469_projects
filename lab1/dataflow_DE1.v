/*

*/

/*
dataflow_DE1
Inputs:	
Outputs:
Description:
Author:
Written On:
*/
module dataflow_DE1(LEDR, SW, CLOCK_50);
	output [9:0] LEDR;
	input [9:0] SW;
	input CLOCK_50;
	wire [31:0]clks;
	parameter SEL = 24;
	
	assign LEDR[9:4] = 6'b0;
	clkdiv divider(clks, CLOCK_50);
	
	dataflow counter(LEDR[0], LEDR[1], LEDR[2], LEDR[3], clks[SEL], SW[0]);
	
endmodule
	
	
/*
clkdiv
Inputs:
Outputs:
Description: 
Author: Maggie McCarthy
Written On: 4/4/2016
*/
module clkdiv(clks, clksource);
	input clksource;
	output reg [31:0] clks; 
	
	initial clks = 0;
	always@(posedge clksource) clks <= clks + 1'b1;

endmodule