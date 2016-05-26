module decode(opCode, jumpInstruction, rs_FD, rt1_FD, rt2_FD, rd_FD, readData_1, readData_2, immediate, instruction, regWrite, writeAddr, writeData, clock);
	output [5:0] opCode;
	output [6:0] jumpInstruction
	output [4:0] rs_FD, rt1_FD, rt2_FD, rd_FD;
	output [31:0] readData_1, readData_2, immediate;
	input [31:0] instruction;
	input regWrite;
	input [4:0] writeAddr; 
	input [31:0] writeData;
	input clock;
endmodule

module signExtend();

endmodule

module registerFile();

endmodule