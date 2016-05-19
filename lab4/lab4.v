module lab4(CLOCK_50,SW);
	input CLOCK_50;
	input [9:0] SW;
	
	wire[6:0] programcounter,pcout,instructionOut;
	wire[31:0] instruction;
	
	PC p1(programcounter,instructionOut,CLOCK_50, SW[0]);
	
	pcplus1 pc2(pcout,programcounter);
	
	instructionMemory in1(programcounter,instruction);
	instructiondec in2(instructionOut,CLOCK_50,instruction,pcout);

endmodule
