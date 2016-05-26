module execute(ALUresult, readData2out, zeroF, regWriteSel, rt_DX, rd_DX, immediate, readData1, readData2in, regDst, ALUSrc, ALUOp, clock);
	output [31:0] ALUresult, readData2out;
	output zeroF;
	output [4:0] regWriteSel;
	input [4:0] rt_DX, rd_DX;
	input [31:0] immediate, readData1, readData2in;
	input regDst, ALUSrc, ALUOp;
	input clock;
endmodule

module ALU();

endmodule

module aluControl();

endmodule