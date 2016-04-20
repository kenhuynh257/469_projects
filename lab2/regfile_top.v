/*

*/

`include "registerFile.v"

/*
dTestbench
Inputs:
Outputs:
Description: 
Author: 
Written On:
*/
module Testbench;

	 wire [31:0] readOut_1,readOut_2;
	 wire clock, we;
	 wire [4:0] readSel_1, readSel_2, writeSel;
	 wire [31:0] data;
	
	registerFile dut(readOut_1, readOut_2, readSel_1, readSel_2, writeSel, data, we, clock);
	
	tester test(clock, we, data, readSel_1, readSel_2, writeSel, readOut_1, readOut_2);
	
	initial begin
			$dumpfile("registerFile.vcd");
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
module tester(clock , we, data, readSel_1, readSel_2, writeSel, readOut_1, readOut_2);
	output reg clock ;
	output reg  we;
	output reg [4:0] readSel_1, readSel_2, writeSel;
	output reg [31:0] data;
	input [31:0] readOut_1,readOut_2;
	
	parameter Delay = 1;
	integer i;
	
	initial
	begin 
		$display("\t\t clock\t we \t data \t readSel_1 \t readSel_2 \t writeSel \t readOut_1\ t readOut_2 \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g", 
				clock, we, data, readSel_1, readSel_2, writeSel, readOut_1, readOut_2 ,$time);			
	end
		
	initial begin
		clock = 1'b0;
		we = 1'b0;
		writeSel = 0;
		data = 'h0xFFFF000F;
		readSel_1 = 0;
		readSel_2 = 0;
		for(i = 1; i < 16; i++) begin
		 
			#Delay 	clock = ~clock;
					readSel_1 = i;
					readSel_2 = i;
					data = data -1;
					writeSel = writeSel+1;
			#Delay 	clock = ~clock;
					
					end
			
		data = 'h0x0000FFF0;
		readSel_1 = 17;
		readSel_2 = 17;
		for(i = 17; i < 32; i++) begin
		
			#Delay 	clock = ~clock;
					readSel_1 = i;
					readSel_2 = i;
					data = data +1;
					writeSel = writeSel+1;
					
			#Delay 	clock = ~clock;		
					end		
		#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay#Delay			
		$finish;
	end

endmodule