/*

*/

`include "ALU_functions.v"

/*
Testbench
Inputs:
Outputs:
Description: 
Author: 
Written On:
*/
module Testbench;

	 wire [31:0] a, b, sum;
	 wire clock, cout, overf, zerof;

	adderCLA32 dut(sum, cout, overf, zerof, negf, a, b);
	
	tester test(a, b, clock, sum, cout, overf, zerof, negf);
	
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
module tester(a, b, clock, sum, cout, overf, zerof, negf);
	output reg clock;
	output reg [31:0] a;
	output reg [31:0] b;
	input [31:0] sum;
	input cout, overf, zerof, negf;
	
	parameter Delay = 1;
	integer i, j;
	
	initial
	begin 
		$display("\t\t clock \t\t\t a \t\t\t\t\t b \t\t\t\t\t sum \t\t\t cout \t overf \t zerof \t negf \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g", 
				clock, a, b, sum, cout, overf, zerof, negf, $time);			
	end
		
	initial begin
		clock  = 1'b0;
		a = 'h7FFFFFFF;
		b = 'h00000001;
#Delay		clock = ~clock;
#Delay		clock = ~clock;
		a = 32'b1;
		b = 4294967295;
#Delay		clock = ~clock;
#Delay		clock = ~clock;
		a = 'hFFFFFFFF;
		b = 'hFFFFFFFF;
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