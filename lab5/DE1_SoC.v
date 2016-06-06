module DE1_SoC(SW[0], CLOCK_50);
	input SW[0], CLOCK_50;

	fetch f(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush, IFIDWrite);
	
	decode d(opCode, rs_FD, rt_FD, rd_FD, jumpAddrOut, jrAddrOut, readData_1, readData_2, immediate, instruction, regWrite, writeAddr, writeData, clock, reset);
	
	
	
	execute x(ALUresult, outB, negF, regWriteSel, rt_DX, rd_DX, immediate, readData1, readData2, nextOutput, address, forwardA, forwardB, regDst, ALUSrc, ALUOp, clock);
	
	memory m(branchSrc, readData, arithmeticOut, MEMWBregSelOut, regSelOut, forwardALUResult, branchCtrl, negFlag, memWrite, memRead, addressIn, regWriteSel, writeData, clock);
	
	assign memData = readData;
	assign ALUout = //Which ALU output?
	
	writeBack w(regWriteData, memData, ALUout, memToReg);
	
	
	forwardingUnit fu(forwardA, forwardB, rs_DX, rt_DX, rd_XM, rd_MW, regWrite_XM, regWrite_MW);
	
	hazardDetectionUnit hdu(stall,write, memRead_DX, rs_FD, rt_FD, rt_DX);
	
endmodule