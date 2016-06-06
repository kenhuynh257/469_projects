module memory(branch, readData, regWriteSelout, dataMemAddrout, memRead, branchSel, memWrite, zeroF, regWriteSelin, dataMemAddrin, memData);
	output branch;
	output [31:0] readData;
	output [4:0] regWriteSelout; //rd_XM
	output [6:0] dataMemAddrout;
	input memRead, branchSel, memWrite, zeroF;
	input [4:0] regWriteSelin;
	input [6:0] dataMemAddrin;
	input [31:0] memData;
endmodule

module dataMemory();

endmodule