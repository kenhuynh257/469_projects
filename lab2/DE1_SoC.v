// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50);
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	input [3:0] KEY;
	input [9:0] SW;
	input CLOCK_50;
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	parameter Delay = 1;
	integer j, i;
	
	reg nMemOut, nMemWrite, we;
	reg [4:0] memAdd, readSel_1, readSel_2, writeSel;
	reg [31:0] memData, readOut_1, readOut_2, data;
	
	memoryInterface dut0(nMemOut, nMemWrite, memData, memAdd, CLOCK_50);
	registerFile dut1(readOut_1, readOut_2, readSel_1, readSel_2, writeSel, data, we, CLOCK_50);

	initial
	begin
		readSel_1 = 5'b0;
		readSel_2 = 5'b0;
		writeSel = 5'b0;
		memAdd = 5'b0;
		we = 1'b0;
		nMemOut = 1'b1;
		nMemWrite = 1'b1;
		data = 32'b0;
		
#Delay
		
		nMemWrite = 1'b0; //writing to SRAM
		
#Delay
		
		for (i = 0; i < 128; i = i + 1)
		begin
			memAdd = i[4:0];
			memData = 127 - i;
#Delay;
		end
		nMemWrite = 1'b1;
		
		for (j = 0; j < 4; j = j + 1)
		begin
#Delay //BLOCK
			
			nMemOut = 1'b0; //reading from SRAM 0
			we = 1'b1; //writing to register
			
#Delay
			
			for (i = 0; i < 32; i = i + 1)
			begin
				memAdd = i + (j * 32);
				writeSel = i;
#Delay;
			end
			nMemOut = 1'b1;
			we = 1'b0;
#Delay
			
			for (i = 0; i < 16; i = i + 1) //reading registers
			begin
				readOut_1 = i;
				readOut_2 = i + 16;
#Delay
#Delay
#Delay
#Delay
#Delay;
			end
		end

	end
endmodule

/*
clkdiv
Inputs:
Outputs:
Description: 
Author: Maggie McCarthy
Written On: 4/4/2016
*/
module clkdiv(clks, clksource);
	input clksource;
	output reg [31:0] clks; 
	
	initial clks = 0;
	always@(posedge clksource) clks <= clks + 1'b1;
endmodule 