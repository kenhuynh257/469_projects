module writeBack(regWriteData, memData, ALUout, memToReg);
	output [31:0] regWriteData;
	input [31:0] memData, ALUout;
	input memToReg;
	
	regWriteData = (memToReg) ? memData : ALUout;
	
endmodule