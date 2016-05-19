// A complete SRAM for connecting to the General Register



// Module: memory
// Authors: Maggie McCarthy, Hung Huynh, David Goniodsky
// Date Written: 4/17/2016

// Inputs:
// 'data' is a birdirectionl wire connecting the SRAM to the MDR that
// the information to be read/written from/to the memory.
// 'addr' is a address recieved by the SRAM from the rest of the computer
// specifying which part of the memory should be read/written from/to.
// 'nWrite' is an active low signal from the computer that determines
// whether or not the SRAM drives the MDR or not (tristate buffer).
// 'clock' is a clock signal used for synchronous operations.
// Outputs:
// 'data' is a birdirectionl wire connecting the SRAM to the MDR that
// the information to be read/written from/to the memory.
// Major Functions:
// 2048x16 bit memory that can be read or written to. 'addr' selects
// which of the 2048 words is to be written/read, and then either that
// word is read by the MDR or the word in the MDR is written to that address.
module SRAM(writeData, readData, address, memWrite, memRead, clock, memory0, memory1, memory2, memory3,
memory4, memory5, memory6, memory7, memory8, memory9, memory10, memory11, memory12, memory13, memory14, memory15);
	input [15:0] writeData;
	input [31:0] address;
	input memWrite, memRead, clock;
	output [15:0] readData;
	
	output [15:0] memory0;
	output [15:0] memory1;
	output [15:0] memory2;
	output [15:0] memory3;
	output [15:0] memory4;
	output [15:0] memory5;
	output [15:0] memory6;
	output [15:0] memory7;
	output [15:0] memory8;
	output [15:0] memory9;
	output [15:0] memory10;
	output [15:0] memory11;
	output [15:0] memory12;
	output [15:0] memory13;
	output [15:0] memory14;
	output [15:0] memory15;
	
	assign memory0 [15:0] = memory[0][15:0];
	assign memory1 [15:0] = memory[1][15:0];
	assign memory2 [15:0] = memory[2][15:0];
	assign memory3 [15:0] = memory[3][15:0];
	assign memory4 [15:0] = memory[4][15:0];
	assign memory5 [15:0] = memory[5][15:0];
	assign memory6 [15:0] = memory[6][15:0];
	assign memory7 [15:0] = memory[7][15:0];
	assign memory8 [15:0] = memory[8][15:0];
	assign memory9 [15:0] = memory[9][15:0];
	assign memory10 [15:0] = memory[10][15:0];
	assign memory11 [15:0] = memory[11][15:0];
	assign memory12 [15:0] = memory[12][15:0];
	assign memory13 [15:0] = memory[13][15:0];
	assign memory14 [15:0] = memory[14][15:0];
	assign memory15 [15:0] = memory[15][15:0];
	
	reg [15:0] memory [31:0];
	
	assign readData[15:0] = (memRead) ? memory[address[4:0]][15:0] : 16'bz;
	
	// buffers for data and address
	always @(*) begin
		if (memWrite)
			memory[address[4:0]][15:0] = writeData[15:0];
		else
			memory[address[4:0]][15:0] = memory[address[4:0]][15:0];
	end
	integer i;

	initial begin
		memory[0][15:0] = 32'd7;
		memory[1][15:0] = 32'd5;
		memory[2][15:0] = 32'd2;
		memory[3][15:0] = 32'd4;
		memory[4][15:0] = 32'd8;
		memory[5][15:0] = 32'd4;
	end
endmodule 