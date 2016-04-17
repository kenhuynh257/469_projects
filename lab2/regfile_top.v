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
module dTestbench;

	wire clk, rst;
	wire  wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2;
	
	regfile dut(clk, rst, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	
	tester test(clk, rst, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	
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
module tester(clk, rst, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	
	output reg[31:0] rd_data1,rd_data2;
	input clk, rst,wrt_en;
	input [4:0] rd_s1, rd_s2 , wrt_s;
	input [31:0]wrt_data;
	parameter Delay = 1;
	integer i;
	
	initial begin 
			$display("\t\tclk\trst\twrt_en\twrt_data\trd_s1\trd_s2\twrt_s\trd_data1\trd_data2\tTime");
			$monitor("\t\t %b \t %b \t  %b \t     %b \t  %b \t  %b \t  %b \t     %b \t     %b \t %g", 
						clk, rst, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2 $time);			
	end
		
	initial begin
		clk = 1'b0;
		rst = 1'b0;
		wrt_en = 1'b0;
		wrt_s = 0;
		wrt_data = 10'h0xFFFF000F;
		for(i = 0; i < 16; i++) begin
		 
			#Delay 	clk = ~clk;
					rst = ~(i < 1);
					wrt_en = ~wrt_en;
					rd_s1 = i;
					rd_s2 = i;
					wrt_data = wrt_data -1;
					wrt_s = wrt_s+1;
					
					
					end
			
		wrt_data = 10'h0x0000FFF0;
		for(i = 16; i < 32; i++) begin
		
			#Delay 	clk = ~clk;
					rst = ~(i < 1);
					wrt_en = ~wrt_en;
					rd_s1 = i;
					rd_s2 = i;
					wrt_data = wrt_data +1;
					wrt_s = wrt_s+1;
					
					
					end		
					
		$finish;
	end

endmodule
