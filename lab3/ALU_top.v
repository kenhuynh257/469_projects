/*

*/

`include "andRTL.v"
`include "orRTL.v"
`include "xorRTL.v"
`include "ALU.v"
`include "adderRTL.v"
`include "compareRTL.v"
`include "shiftRTL.v"
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
	 wire [2:0] control;
	 wire clk, zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	alu dut(out, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, a, b, control);
	
	tester test(a,b,out,zeroFlag, overflowFlag, carryoutFlag, negativeFlag,control,clk);
	
	initial begin
			$dumpfile("ALU_top.vcd");
			$dumpvars(1, dut);
	end
		
endmodule
module tester(a,b,out,zeroFlag, overflowFlag, carryoutFlag, negativeFlag,control,clk);
	input  [31:0] out;
	output reg [2:0] control;
	output reg [31:0] a,b;
	output reg clk;
	input zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	parameter Delay = 10;
	integer i;
	
	initial
	begin 
		$display("\t\t clk\t\t\t a\t\t\t\t\t b  \t\t\t\t\t out\t\t\t control  zerof\t overf\t carryf\t negf\t\t  time");
		$monitor("\t\t %b\t %b \t %b \t %b \t %b\t %b\t %b\t %b \t %g", 
				clk,a,b,out,control,zeroFlag, overflowFlag, carryoutFlag, negativeFlag,$time);			
	end
		
	initial begin
		clk = 1'b0;
		a = 'h0;
		b = 'h16;
		control = 0;
		#Delay 	clk = ~clk;
		control = control +1;
		#Delay 	clk = ~clk;	
		control = control +1;
		#Delay 	clk = ~clk;
		control = control +1;
		#Delay 	clk = ~clk;
		control = control +1;
		#Delay 	clk = ~clk;
		control = control +1;
		#Delay 	clk = ~clk;
		control = control +1;
		
		#Delay 	clk = ~clk;
		control = control +1;
		#Delay 	
		$finish;
	end

endmodule