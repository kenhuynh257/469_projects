`include "SRAM.v"
// NOT TESTED YET
module memory(
	output branchSrc, /* 3rd bit of PCSrc */
	output reg [31:0] arithmeticOut,
	output reg [31:0] readData,
	output reg [4:0] regWriteSelOut;
	input branchCtrl,
	input zeroFlag,
	input memWrite,
	input memRead,
	input [31:0] address,
	input [4:0] regWriteSel,
	input [31:0] writeData
	input clock);
	
	assign branchSrc = branchCtrl & zeroFlag;
	wire [31:0] memoryOut;
	SRAM dataMemory(writeData, memoryOut, address, memWrite, memRead, clock);
	
	always @(posedge clock) begin
		readData <= memoryOut;
		arithmeticOut <= address;
		regWriteSelOut <= regWriteSel;
	end
endmodule
	