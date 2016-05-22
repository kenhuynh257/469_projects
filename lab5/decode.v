module decode (pcout, readDatat1, readDatat2, signExtend, inst2016, inst1511, RegWrite, wbControl, mControl, exControl, instruction, pcin);
	output [7:0] pcout;
	output [31:0] readDatat1, readDatat2, signExtend;
	output [3:0] inst2016, inst1511;
	output wbControl, mControl, exControl, RegWrite;
	input [31:0] instruction;
	input [6:0] pcin;
endmodule