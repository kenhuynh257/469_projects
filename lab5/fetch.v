// this has been tested and it works, but we need to look at the timing together 6:15pm 6/4 - David

// Includes the IF/ID register.
// Instruction memory is loaded with an initial block
// Instructions are chosen with the PC address which can be:
// jump address, jump register address, branch address, and the sequential address (see case statement)
// Inputs from the Hazard detection can stall the PC and IFID registers and put all zeros into IFID
module fetch (instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush, IFIDWrite);
	output reg [31:0] instruction;
	input clock, reset; // reset doesn't do anything right now...
	input [2:0] PCSrc; // one-hot encoded mux control to PC choosing between j, jr, and branch
	input pcWrite; // enables writing to the PC for hazard control (stalling)
	input IFIDWrite; // enables writing to the pipeline register for stalling
	input IFFlush; // signal to flush the IF/ID pipeline register
	input [6:0] jumpAddr, jrAddr, branchAddr;
	reg [6:0] pcIn;
	wire [6:0] pcOut;
	wire [31:0] memoryOut;
	reg [6:0] plusOne;
	
	
	always @(*) begin
		plusOne = pcOut + 1;
		case(PCSrc)
			3'b100: pcIn = branchAddr;
			3'b010: pcIn = jumpAddr;
			3'b001: pcIn = jrAddr;
			3'b000: pcIn = plusOne;
			default: pcIn = 11;
		endcase
	end
	
	pc programCounter(pcWrite, pcIn, pcOut, clock, reset);
	instructionMemory instructionMemory1(pcOut, memoryOut);
	
	always @(posedge clock) begin
		if (IFFlush) begin
			instruction <= 32'b0;
		end else if (IFIDWrite) begin
			instruction <= memoryOut;
		end else begin
			instruction <= instruction;
		end
	end
endmodule

module pc(pcWrite, pcIn, pcOut, clock, reset);
	input clock, reset;
	input pcWrite; // used to freeze the PC address for hazard control
	input [6:0] pcIn; // instruction address
	output reg [6:0] pcOut;
	
	always @(posedge clock) begin
		if (reset) begin
			pcOut <= 0;
		end else if (pcWrite) begin
			pcOut <= pcIn;
		end else begin
			pcOut <= pcOut;
		end
	end
endmodule

module instructionMemory(address, memoryOut);
	input [6:0] address;
	output [31:0] memoryOut;
	reg [31:0] memory [127:0];
	
	assign memoryOut = memory[address[6:0]][31:0];
	
	integer i;
	initial begin
		// load instructions into memory
		for (i = 0; i < 32; i = i + 1) begin
			memory[i][31:0] = {6'b0 + i, 5'b0 + i, 5'b11111 - i, 15'b0 + i}; // op, rs, and immediate count up
																			 // rt counts down
		end
	end
endmodule

`define NO_FETCH_TESTBENCH 1
`ifndef NO_FETCH_TESTBENCH
module testbench();
	wire [31:0] instruction;
	wire [2:0] PCSrc;
	wire clock, reset;
	wire [6:0] jumpAddr, jrAddr, branchAddr;
	wire pcWrite, IFFlush;
	
	fetch dut(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush, IFIDWrite);
	tester test(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush, IFIDWrite);
	
	initial begin
		$dumpfile("fetch.vcd");
		$dumpvars();
	end
endmodule

module tester(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush, IFIDWrite);
	input [31:0] instruction;
	output reg [2:0] PCSrc;
	output reg clock, reset;
	output reg [6:0] jumpAddr, jrAddr, branchAddr;
	output reg pcWrite, IFFlush, IFIDWrite;
	integer i;
	
	parameter delay = 10;
	
	initial begin
		// increment through instructions
		clock = 1;
		reset = 1;
		PCSrc = 3'b0;
		pcWrite = 1;
		IFFlush = 0;
		IFIDWrite = 1;
		for (i = 0; i < 4; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		reset = 0;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		// jump to different places
		PCSrc = 3'b100;
		branchAddr = 1;
		jumpAddr = 4;
		jrAddr = 9;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end

		PCSrc =  3'b010;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end

		PCSrc = 3'b001;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end

		PCSrc = 3'b000;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		// stall
		pcWrite = 0;
		IFIDWrite = 0;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		// flush
		IFFlush = 1;
		PCSrc = 3'b001;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		IFFlush = 0;
		pcWrite = 1;
		for (i = 0; i < 16; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
	end
endmodule
`endif

	