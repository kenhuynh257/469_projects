module writeBack(regWriteData, memData, ALUout, rd_MW);
	output [31:0] regWriteData;
	input [31:0] memData, ALUout;
	input [4:0] rd_MW;
endmodule