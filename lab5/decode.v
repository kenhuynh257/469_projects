`include "registerFile.v" // is the register file tested and working? what about reading and writing in the same clock cycle?

module decode(rs_FD, rt_FD, rd_FD, readData_1, readData_2, immediate, instruction, regWrite, writeAddr, writeData, jumpAddr, clock, reset);

	output reg [4:0] rs_FD, rt_FD, rd_FD;
	output reg [31:0] readData_1, readData_2, immediate;
	output reg [6:0] jumpAddr_FD;

	input [31:0] instruction, writeData;
	input [6:0] jumpAddr;
	input [4:0] writeAddr;
	input regWrite;
	input clock, reset;
	wire [31:0] regDataOut1, regDataOut2, extendedImmediate; // the last 6 bits are alu function code

	registerFile generalRegister(regDataOut1, regDataOut2, instruction[25:21], instruction[20:16], writeAddr, writeData, regWrite, reset, clock);
	signExtend extendImmediate(instruction[15:0], extendedImmediate[31:0]);

	always @(posedge clock) begin
		readData_1 <= regDataOut1;
		readData_2 <= regDataOut2;
		immediate <= extendedImmediate;
		rs_FD <= instruction[25:21];
		rt_FD <= instruction[20:16];
		rd_FD <= instruction[15:11];
		jumpAddr_FD <= jumpAddr;
	end
endmodule

//////////////////////////////////////////////////////////////////
module signExtend(shortImmediate, extendedImmediate);
	input [15:0] shortImmediate;
	output [31:0] extendedImmediate;

	assign extendedImmediate[31:0] = (shortImmediate[15]) ? {16'hFFFF, shortImmediate[15:0]} : {16'b0, shortImmediate[15:0]};
endmodule

////////////////////////////////////////////////////////////////////
module testbench();
	wire [4:0] rs_FD, rt_FD, rd_FD;
	wire [31:0] readData_1, readData_2, immediate;
	wire [31:0] instruction, writeData;
	wire [4:0] writeAddr;
	wire regWrite;
	wire clock, reset;

	decode instructionDecode(rs_FD, rt_FD, rd_FD, readData_1, readData_2, immediate, instruction, regWrite, writeAddr, writeData, clock, reset);
	tester test(rs_FD, rt_FD, rd_FD, readData_1, readData_2, immediate, instruction, regWrite, writeAddr, writeData, clock, reset);


	initial begin
		$dumpfile("fetch.vcd");
		$dumpvars();
	end
endmodule

///////////////////////////////////////////////
module tester(rs_FD, rt_FD, rd_FD, readData_1, readData_2, immediate, instruction, regWrite, writeAddr, writeData, clock, reset);
	input [4:0] rs_FD, rt_FD, rd_FD;
	input [31:0] readData_1, readData_2, immediate;
	output reg [31:0] instruction, writeData;
	output reg [4:0] writeAddr;
	output reg regWrite;
	output reg clock, reset;
	integer i;

	parameter delay = 10;

	initial begin
		// fill up register
		clock = 1;
		reset = 1;
		regWrite = 0;
		writeAddr = 0;
		instruction = 0;
		writeData = 0;
		for (i = 0; i < 4; i = i+1) begin
			clock = ~clock;
			#delay;
			clock = ~clock;
			#delay
		end
		reset = 0;
		regWrite = 1;
		for (i = 0; i < 16; i = i + 1) begin
			writeData = 16 - i;
			writeAddr = i;
			clock = ~clock;
			#delay;
			clock = ~clock;
			#delay;
		end
		// read register and instruction lines
		regWrite = 0;
		for (i = 0; i < 16; i = i + 1) begin
			instruction [31:26] = i
			instruction[25:21] = i;
			instruction[20:16] = 16 - i; // counting down just to tell apart from rt
			instruction[15:0] = i - 8; // counting from -8 to +8 to check sign extend
			clock = ~clock;
			#delay;
			clock = ~clock;
			#delay;	
		end
	end
endmodule
