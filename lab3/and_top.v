/*

*/

`include "andLogic.v"

/*
dTestbench
Inputs:
Outputs:
Description: 
Author: 
Written On:
*/
module Testbench;

	 wire [31:0] a,b,out;
	 wire clk, zerof;
	
	andLogic dut(a,b,out,zerof);
	
	tester test(a,b,out,zerof,clk);
	
	initial begin
			$dumpfile("orRTL.vcd");
			$dumpvars(1, dut);
	end
		
endmodule
module tester(a,b,out,zerof,clk);
	input  [31:0] out;
	output reg [31:0] a,b;
	output reg clk,zerof;
	parameter Delay = 10;
	integer i;
	
	initial
	begin 
		$display("\t\t clk\t a\t b  \t out\t zerof \t time");
		$monitor("\t\t %b\t %b \t %b \t %b \t %b \t %g", 
				clk,a,b,out,zerof ,$time);			
	end
		
	initial begin
		clk = 1'b0;
		a = 'h2;
		b = 'h8;
		
		#Delay 	clk = ~clk;
		
		#Delay 	clk = ~clk;
		a = 'h8;
		b = 'h8;
		#Delay 	clk = ~clk;	
		a= 'h0;
		b= 'h0;
		#Delay 	clk = ~clk;
		$finish;
	end

endmodule