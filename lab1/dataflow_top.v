/*

*/

`include "dataflow.v"

/*
dTestbench
Inputs:
Outputs:
Description: 
Author: 
Written On:
*/
module dTestbench;

	wire clk, rst;
	wire q0, q1, q2, q3;
	
	dataflow dut(q0, q1, q2, q3, clk, rst);
	
	tester test(clk, rst, q0, q1, q2, q3);
	
	initial begin
			$dumpfile("dataflow.vcd");
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
module Tester(clk, rst, q0, q1, q2, q3);
	
	output reg clk, rst;
	input q0, q1, q2, q3;
	parameter Delay = 1;
	integer i;
	
	initial begin 
			$display("\t\tclk\tq0\tq1\tq2\tq3\trst\tTime");
			$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t  %g", 
						clk, q0, q1, q2, q3, rst, $time);			
	end
		
	initial begin
		clk = 1'b0;
		rst = 1'b0;
		for(i = 0; i < 40; i++) begin
			#Delay 	clk = ~clk;
					rst = ~(i < 1);
		end
		$finish;
	end

endmodule
