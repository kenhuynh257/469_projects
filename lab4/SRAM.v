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
module SRAM(writeData, readData, address, memWrite, memRead, clock);
	input [31:0] writeData;
	input [31:0] address;
	input memWrite, memRead, clock;
	output [31:0] readData;
	
	reg [31:0] memory [2047:0];
	
	assign readData[31:0] = (memRead) ? memory[address[10:0]][31:0] : 32'bz;
	
	// buffers for data and address
	always @(posedge clock) begin
		if (memWrite)
			memory[addr[10:0]][31:0] <= writeData[31:0];
		else
			memory[addr[10:0]][31:0] <= memory[addr[10:0]][31:0];
	end	
endmodule