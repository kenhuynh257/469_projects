/*

*/

`include "ripple.v"

/*
rTestbench
Inputs: none
Outputs: none
Description:
Author: 
Written On: 
*/
module rTestbench;

	wire q0, q1, q2, q3;
	wire clk, rst;
	
	ripple dut(q0, q1, q2, q3, clk, rst);
	
	tester test(clk, rst, q0, q1, q2, q3);
	
	initial begin
			$dumpfile("ripple.vcd");
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
module tester(clk, rst, q0, q1, q2, q3);
	
	input q0, q1, q2, q3;
	output reg clk, rst;
	parameter Delay = 1;
	integer i;
	
	initial begin 
			$display("\t\tclk\trst\tq0\tq1\tq2\tq3\tTime");
			$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %g",
						clk, rst, q0, q1, q2, q3, $time);			
	end
		
	initial begin
		clk = 1'b0;
		rst = 1'b0;
		for(i = 0; i < 64; i++) begin
			#Delay clk = ~clk;
			rst = ~((i == 52) | (i == 0));
		end
		$finish;
	end

endmodule
