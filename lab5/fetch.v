module fetch (instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush);
	output reg [31:0] instruction;
	input clock, reset;
	input [2:0] PCSrc; // one-hot encoded mux control to PC choosing between j, jr, and branch
	input pcWrite; // enables writing to the PC for hazard control (stalling)
	input IFFlush; // signal to flush the IF/ID pipeline register
	input [6:0] jumpAddr, jrAddr, branchAddr;
	wire [6:0] pcIn, pcOut;
	always @(*) begin
		case(PCSrc)
			1XX: pcIn = branchAddr;
			01X: pcIn = jumpAddr;
			001: pcIn = jrAddr;
			000: pcIn = pcOut + 1;
			default: pcIn = 0;
		endcase
	end
	
	pc programCounter(pcWrite, pcIn, pcOut, clock);
	instructionMemory instructionMemory1(pcOut, memoryOut);
	
	always @(posedge clock) begin
		if (IFFlush) begin
			instruction <= 32'b0;
		end else begin
			instruction <= memoryOut;
		end
	end
endmodule

module pc(pcWrite, pcIn, pcOut, clock);
	input clock;
	input pcWrite; // used to freeze the PC address for hazard control
	input [6:0] pcIn; // instruction address
	output reg [6:0] pcOut;
	
	always @(posedge clock) begin
		if (pcWrite) begin
			pcOut <= pcIn;
		end else begin
			pcOut <= pcOut;
		end
endmodule

module instructionMemory(address, instruction);
	input [6:0] address;
	output [31:0] instruction;
	reg [31:0] memory [127:0];
	
	assign instruction = memory[address[6:0]][31:0];
	
	initial begin
	// load instructions into memory
	end
endmodule