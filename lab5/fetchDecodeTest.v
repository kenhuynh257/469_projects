`include "fetch.v"
`include "decode.v"

module fetchDecodeTest();
	wire [31:0] instruction;
	
	wire clock, reset;
	wire [2:0] PCSrc;
	wire pcWrite;
	wire IFIDWrite;
	wire IFFlush;
	wire [6:0] jumpAddr;
	wire [6:0] jrAddr;
	wire [6:0] branchAddr;
	
	wire [5:0] opCode;
	wire [4:0] rs_FD, rt_FD, rd_FD;
	wire [31:0] readData_1, readData_2, immediate;
	wire [6:0] jumpAddr_FD;
	wire [31:0] writeData;
	wire [4:0] writeAddr;
	wire regWrite;
	
	fetch IF(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, 
				branchAddr, pcWrite, IFFlush, IFIDWrite);
	decode ID(opCode, rs_FD, rt_FD, rd_FD, jumpAddr_FD, readData_1, readData_2, immediate,
				instruction, regWrite, writeAddr, writeData, clock, reset);
	tester test(clock, reset, PCSrc, pcWrite, IFIDWrite, IFFlush, jumpAddr, jrAddr,
				branchAddr, writeAddr, writeData, regWrite);
	
	initial begin
		$dumpfile("IFID.vcd");
		$dumpvars();
	end
endmodule

module tester(
	output reg clock,
	output reg reset,
	output reg [2:0] PCSrc,
	output reg pcWrite,
	output reg IFIDWrite,
	output reg IFFlush,
	output reg [6:0] jumpAddr,
	output reg [6:0] jrAddr,
	output reg [6:0] branchAddr,
	output reg [4:0] writeAddr,
	output reg [31:0] writeData,
	output reg regWrite);
	integer i;
	
	parameter delay = 10;
	
	initial begin
		// fill up register
		clock = 0;
		reset = 1;
		regWrite = 0;
		writeAddr = 0;
		writeData = 0;
		pcWrite = 0;
		PCSrc = 0;
		IFIDWrite = 0;
		IFFlush = 0;
		jumpAddr = 1;
		branchAddr = 31;
		for (i = 0; i < 16; i = i + 1) begin
			#delay; clock = ~clock; 
			#delay; clock = ~clock; 
		end
		reset = 0;
		regWrite = 1;
		for (i = 0; i < 16; i = i + 1) begin // check that registers can be written
			#delay; clock = ~clock;
			writeAddr = i;
			writeData = i; 
			#delay; clock = ~clock; 
		end
		regWrite = 0;
		for (i = 0; i < 16; i = i + 1) begin // check that registers are not written
			#delay; clock = ~clock;			 // when regWrite is low but there's stuff on the inputs
			writeAddr = 15 -i;					 
			writeData = 15 - i; 
			#delay; clock = ~clock; 
		end
		
		
		// sequential instructions and then some jumps
		pcWrite = 1;
		IFIDWrite = 1;
		for (i = 0; i < 32; i = i + 1) begin
			#delay; clock = ~clock; 
			#delay; clock = ~clock; 
		end
		PCSrc = 3'b100; // branchAddr into PC
		for (i = 0; i < 8; i = i + 1) begin
			#delay; clock = ~clock; 
			#delay; clock = ~clock; ;
		end
		PCSrc = 0; // back to sequential instructions
		IFFlush = 1; // zero IFID register
		for (i = 0; i < 8; i = i + 1) begin
			#delay; clock = ~clock; 
			#delay; clock = ~clock; 
		end
		IFFlush = 0;
		IFIDWrite = 0; // freeze IFID
		for (i = 0; i < 8; i = i + 1) begin
			#delay; clock = ~clock; 
			#delay; clock = ~clock; 
		end
		pcWrite = 0; // freeze PC
		for (i = 0; i < 8; i = i + 1) begin
			#delay; clock = ~clock; 
			#delay; clock = ~clock; 
		end
	end
endmodule
	