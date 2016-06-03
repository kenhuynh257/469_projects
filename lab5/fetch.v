module fetch (instruction, PCSrc, clock, reset, jumpAddr, flush, pcHazardSet);
	output [31:0] instruction;
 	input PCSrc, clock, reset, flush;
	input [6:0] jumpAddr;
endmodule

module pc();

endmodule

module instructionMemory();

endmodule