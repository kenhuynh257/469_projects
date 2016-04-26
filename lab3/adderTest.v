/*

*/

`include "adder.v"
`include "adderRTL.v"

/*
dTestbench
Inputs:
Outputs:
Description: 
Author: 
Written On:
*/
module Testbench;

	 wire [31:0] a, b, sum;
	 wire clock, cout, overf;
	
	adderRTL dut(sum, cout, overf, a, b, clock);
	
	tester test(a, b, clock, sum, cout, overf);
	
	initial begin
			$dumpfile("adder.vcd");
			$dumpvars(1, dut);
	end
		
endmodule




/*
tester
Inputs: 
Outputs:
Description:
Author:
Written On:
*/
module tester(a, b, clock, sum, cout, overf);
	output reg clock;
	output reg [31:0] a;
	output reg [31:0] b;
	input [31:0] sum;
	input cout, overf;
	
	parameter Delay = 1;
	integer i, j;
	
	initial
	begin 
		$display("\t\t clock \t\t\t a \t\t\t\t\t b \t\t\t\t\t sum \t\t\t cout \t overf \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %g", 
				clock, a, b, sum, cout, overf, $time);			
	end
		
	initial begin
		clock  = 1'b0;
		a = 32'b0;
		b = 4294967295;
#Delay		clock = ~clock;
#Delay		clock = ~clock;
		for (i = 0; i < 20; i = i + 1)
		begin
#Delay		clock = ~clock;
			a = i;
			b = b - i;
#Delay		clock = ~clock;
		end
#Delay		clock = ~clock;
		a = 4294967295;
#Delay		clock = ~clock;
		for (j = 0; j < 20; j = j + 1)
		begin
#Delay		clock = ~clock;
			a = a - i;
			b = b - i;
#Delay		clock = ~clock;
		end
	end
endmodule