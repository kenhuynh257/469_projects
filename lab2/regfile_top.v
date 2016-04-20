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
	integer i, j;
	
	initial
	begin 
		$display("\t\t clock\t we \t\t\t data \t\t\t readSel_1 \t readSel_2 \t writeSel \t\t readOut_1 \t\t\t\t readOut_2 \t\t\t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t\t %b \t\t %b \t\t %b \t %b \t %g", 
				clock, we, data, readSel_1, readSel_2, writeSel, readOut_1, readOut_2 ,$time);			
	end
		
	initial begin
		clock = 1'b0;
		we = 1'b1;
		writeSel = 5'b00001;
		data = 'h0xFFFF000F;
		readSel_1 = 5'b0;
		readSel_2 = 5'b0;
		#Delay
		clock = ~clock;
		#Delay
		clock = ~clock;
		
		for(i = 1; i < 16; i++) 
		begin
		 
			#Delay 	clock = ~clock;
					readSel_1 = i - 1;
					readSel_2 = i;
					data = data - 1;
					writeSel = i + 1;
			#Delay 	clock = ~clock;
					
		end
		
		#Delay 	clock = ~clock;	
		data = 'h0x0000FFF0;
		writeSel = 5'b10001;
		#Delay 	clock = ~clock;
		
		for(i = 17; i < 32; i++) 
		begin
		
			#Delay 	clock = ~clock;
					readSel_1 = i - 1;
					readSel_2 = i;
					data = data + 1;
					writeSel = i + 1;
					
			#Delay 	clock = ~clock;		
		end
		
		for (j = 0; j < 10; j++)
		begin
			#Delay 	clock = ~clock;
		end			
		
		$finish;
	end

endmodule