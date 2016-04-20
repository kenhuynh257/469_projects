
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
module SRAM(data, addr, nWrite, clock);
	inout [15:0] data;
	input [10:0] addr;
	input nWrite, clock;
	
	reg [15:0] memReg [2047:0];
	
	assign data[15:0] = nWrite ? memReg[addr[10:0]][15:0] : 16'bz;
	
	always @(posedge clock)
	begin
	if (~nWrite)
		memReg[addr[10:0]][15:0] <= data[15:0];
	end
	
endmodule

// Module: MDR
// Authors: Maggie McCarthy, Hung Huynh, David Goniodsky
// Date Written: 4/17/2016

// Inputs:
// 'data' is a birdirectionl wire connecting the MDR to the data bus which
// moves information between the memory and the rest of the computer.
// 'memory' is a bidirectional wire connecting the MDR to the SRAM which moves
// information between the MDR and the SRAM.
// 'nOutput' is an active low signal from the computer that determines
// whether or not the MDR drives the data bus or not (tristate buffer).
// 'nWrite' is an active low signal from the computer that determines
// whether or not the MDR drives the SRAM or not (tristate buffer).
// 'clock' is a clock signal used for synchronous operations.
// Outputs:
// 'data' is a birdirectionl wire connecting the MDR to the data bus which
// moves information between the memory and the rest of the computer.
// 'memory' is a bidirectional wire connecting the MDR to the SRAM which moves
// information between the MDR and the SRAM.
// Major Functions:
// Register that holds information to be sent to the data bus or the memory.
module MDR(data, memory, nOutput, nWrite, clock);
	inout [15:0] data; // connects MDR and data
	inout [15:0] memory; // connects MDR and memory
	input nOutput, nWrite, clock;
	
	reg [15:0] aRegister; // the MDR
	
	assign data[15:0] = (~nOutput && nWrite) ? aRegister[15:0] : 16'bz;
	assign memory[15:0] = nWrite ? 16'bz : aRegister[15:0];
	
	always @(posedge clock)
	begin
	if (nWrite)
		aRegister[15:0] <= memory[15:0];
	else
		aRegister[15:0] <= data[15:0];
	end
	
endmodule

// Module: MAR
// Authors: Maggie McCarthy, Hung Huynh, David Goniodsky
// Date Written: 4/17/2016

// Inputs:
// 'inAdd' is an address recieved from the computer.
// 'clock' is a clock signal used for synchronous updates of the register.
// Outputs:
// 'outAdd' is an address sent to the SRAM.
// Major Functions:
// Buffers and synchronizes the addresses coming from the computer to the memory.
module MAR(outAdd, inAdd, clock);
	output reg [10:0] outAdd;
	input [10:0] inAdd;
	input clock;
	
	always @(posedge clock)
	begin
		outAdd[10:0] <= inAdd[10:0];
	end
	
endmodule	
	