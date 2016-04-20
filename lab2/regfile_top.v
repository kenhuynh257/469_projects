/*

*/

`include "regfile.v"

/*
dTestbench
Inputs:
Outputs:
Description: 
Author: 
Written On:
*/
module Testbench;

	 wire [31:0] rd_data1,rd_data2;
	 wire clk, rst,wrt_en;
	 wire [4:0] rd_s1, rd_s2, wrt_s;
	 wire [31:0] wrt_data;
	
	regfile dut(clk,  wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	
	tester test(clk, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	
	initial begin
			$dumpfile("regfile.vcd");
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
module tester(clk , wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	output reg clk ;
	input [31:0] rd_data1,rd_data2;
	output reg  wrt_en;
	output reg [4:0] rd_s1, rd_s2, wrt_s;
	output reg [31:0] wrt_data;
	parameter Delay = 1;
	integer i;
	
	initial
	begin 
		$display("\t\t clk\t wrt_en \t wrt_data \t rd_s1 \t rd_s2 \t wrt_s \t rd_data1\ t rd_data2 \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g", 
				clk, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2 ,$time);			
	end
		
	initial begin
		clk = 1'b0;
		wrt_en = 1'b1;
		wrt_s = 0;
		wrt_data = 'h0xFFFF000F;
		rd_s1 = 0;
		rd_s2 = 0;
		for(i = 1; i < 16; i++) begin
		 
			#Delay 	clk = ~clk;
					rd_s1 = i;
					rd_s2 = i;
					wrt_data = wrt_data -1;
					wrt_s = wrt_s+1;
			#Delay 	clk = ~clk;
					
					end
			
		wrt_data = 'h0x0000FFF0;
		rd_s1 = 17;
		rd_s2 = 17;
		for(i = 17; i < 32; i++) begin
		
			#Delay 	clk = ~clk;
					rd_s1 = i;
					rd_s2 = i;
					wrt_data = wrt_data +1;
					wrt_s = wrt_s+1;
					
			#Delay 	clk = ~clk;		
					end		
		#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay			
		$finish;
	end

endmodule
