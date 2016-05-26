module fetch (instruction, PCSrc, clock, reset, jumpAddr);
	output [31:0] instruction;
 	input PCSrc, clock, reset;
	input [6:0] jumpAddr;
endmodule