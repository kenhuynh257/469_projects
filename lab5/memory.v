`include "SRAM.v"
// not tested but it's just the SRAM which I think has been tested and
// single wire or flip flop connections.
module memory(
	output branchSrc, /* 3rd bit of PCSrc */
	output reg [31:0] readData,
	output reg [31:0] arithmeticOut,
	output reg [4:0] MEMWBregSelOut,
	output [4:0] regSelOut,
	output [31:0] forwardALUResult,
	input branchCtrl,
	input zeroFlag,
	input memWrite,
	input memRead,
	input [31:0] addressIn,
	input [4:0] regWriteSel,
	input [31:0] writeData,
	input clock);
	
	assign regSelOut = regWriteSel;
	assign forwardALUResult = addressIn;
	assign branchSrc = branchCtrl & zeroFlag;
	wire [31:0] memoryOut;
	SRAM dataMemory(writeData, memoryOut, addressIn, memWrite, memRead, clock);
	
	always @(posedge clock) begin
		readData <= memoryOut;
		arithmeticOut <= addressIn;
		MEMWBregSelOut <= regWriteSel;
	end
endmodule
	
module testbench();
	wire branchSrc, /* 3rd bit of PCSrc */
	wire [31:0] readData,
	wire [31:0] arithmeticOut,
	wire [4:0] MEMWBregSelOut,
	wire [4:0] regSelOut,
	wire [31:0] forwardALUResult,
	wire branchCtrl,
	wire zeroFlag,
	wire memWrite,
	wire memRead,
	wire [31:0] addressIn,
	wire [4:0] regWriteSel,
	wire [31:0] writeData,
	wire clock);
	
	memory MEM(branchSrc, readData, arithmeticOut, MEMWBregSelOut, regSelOut, forwardLUResult, 
				branchCtrl, zeroFlag, memWrite, memRead, addressIn, regWriteSel, writeData, clock);
	
	tester test(branchCtrl, zeroFlag, memWrite, memRead, addressIn, regWriteSel, writeData, clock);
	
	initial begin
		$dumpfile("IFID.vcd");
		$dumpvars();
	end
endmodule

module tester(
	output reg branchCtrl,
	output reg zeroFlag,
	output reg memWrite,
	output reg memRead,
	output reg addressIn,
	output reg regWriteSel,
	output reg writeData,
	output reg clock);
	
	integer i;
	
	parameter delay = 10;
	
	initial begin
		// test writing memory
		// reading memory
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
