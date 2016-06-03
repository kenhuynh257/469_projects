module fetch (instruction, PCSrc, clock, reset, jumpAddr, pcWrite, IFWrite, IFFlush);
	output [31:0] instruction;
 	input PCSrc, clock, reset, pcWrite, IFWrite, IFFlush;
	input [6:0] jumpAddr;
endmodule

module pc();

endmodule

module instructionMemory();

endmodule