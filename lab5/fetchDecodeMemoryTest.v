module fetchDecodeMemoryTest();
	wire clock, reset;
	// fetch
	wire [31:0] instruction;
	wire [2:0] PCSrc; // connects to branchSrc
	wire pcWrite;
	wire IFIDWrite;
	wire IFFlush;
	wire [6:0] jumpAddr;
	wire [6:0] jrAddr;
	wire [6:0] branchAddr;
	
	// decode
	wire [5:0] opCode;
	wire [4:0] rs_FD, rt_FD, rd_FD;
	wire [31:0] readData_1, readData_2, immediate;
	wire [6:0] jumpAddrOut, jrAddrOut;
	wire [31:0] writeData;
	wire [4:0] writeAddr;
	wire regWrite;
	
	// memory
	wire [31:0] readData;
	wire [31:0] arithmeticOut;
	wire [4:0] regSelOut; // to forwarding control
	wire [31:0] forwardALUResult;
	wire branchCtrl;
	wire negFlag;
	wire memWrite;
	wire memRead;
	wire [31:0] addressIn;
	wire [4:0] regWriteSel;
	wire [31:0] MEMwriteData;
	
	// execute
	wire [31:0] ALUresult, outB;
	wire [6:0] branchOut;
	wire [1:0] forwardA, forwardB;
	wire regDst, ALUsrc;
	wire [2:0] ALUOp;
	
	
	
	
	wire memToReg;

	fetch IF(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, 
				branchAddr, pcWrite, IFFlush, IFIDWrite);
	decode ID(opCode, rs_FD, rt_FD, rd_FD, jumpAddrOut, jrAddrOut, readData_1, readData_2, immediate,
				instruction, regWrite, writeAddr, writeData, clock, reset);
	execute EX();			
				
	memory MEM(PCSrc[2], readData, arithmeticOut, writeAddr, regSelOut, forwardALUResult, branchCtrl,
				negFlag, memWrite, memRead, addressIn, regWriteSel, MEMwriteData);
				
	tester test();
	
	initial begin
		$dumpfile("MEMIFID.vcd");
		$dumpvars();
	end
endmodule

module tester(
	output reg clock,
	output reg reset,
	output reg [1:0] PCSrc,
	output reg pcWrite,
	output reg IFIDWrite,
	output reg IFFlush,
	output reg )