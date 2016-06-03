module fetch (instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush);
	output reg [31:0] instruction;
	input clock, reset; // reset doesn't do anything right now...
	input [2:0] PCSrc; // one-hot encoded mux control to PC choosing between j, jr, and branch
	input pcWrite; // enables writing to the PC for hazard control (stalling)
	input IFFlush; // signal to flush the IF/ID pipeline register
	input [6:0] jumpAddr, jrAddr, branchAddr;
	reg [6:0] pcIn;
	wire [6:0] pcOut;
	wire [31:0] memoryOut;
	reg [6:0] plusOne;
	
	
	always @(PCSrc) begin
		plusOne = pcOut + 1;
		case(PCSrc)
			3'b1XX: pcIn = branchAddr;
			3'b01X: pcIn = jumpAddr;
			3'b001: pcIn = jrAddr;
			3'b000: pcIn = plusOne;
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
	end
	
	initial begin
		pcOut = 7'b0;
	end
endmodule

module instructionMemory(address, instruction);
	input [6:0] address;
	output [31:0] instruction;
	reg [31:0] memory [127:0];
	
	assign instruction = memory[address[6:0]][31:0];
	
	integer i
	initial begin
		// load instructions into memory
		for (i = 0; i < 64; i = i + 1) begin
			memory[i][31:0] = i;
		end
	end
endmodule

module testbench();
	wire [31:0] instruction;
	wire [2:0] PCSrc;
	wire clock, reset;
	wire [6:0] jumpAddr, jrAddr, branchAddr;
	wire pcWrite, IFFlush;
	
	fetch dut(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush);
	tester test(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush);
	
	initial begin
		$dumpfile("fetch.vcd");
		$dumpvars(1, test);
	end
end

module tester(instruction, PCSrc, clock, reset, jumpAddr, jrAddr, branchAddr, pcWrite, IFFlush);
	input [31:0] instruction;
	output reg [2:0] PCSrc;
	output reg clock, reset;
	output reg [6:0] jumpAddr, jrAddr, branchAddr;
	output reg pcWrite, IFFlush;
	integer i;
	
	parameter delay = 10;
	
	initial begin
		// increment through instructions
		clock = 1;
		PCSrc = 3'b0;
		pcWrite = 1;
		IFFlush = 0;
		for (i = 0; i < 8; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		// jump to different places
		PCSrc = 3'b100;
		branchAddr = 1;
		jumpAddr = 4;
		jrAddr = 9;
		for (i = 0; i < 4; i = i + 1) begin
			#delay;
			clock = ~clock;
		end

		PCSrc =  3'b010;
		for (i = 0; i < 4; i = i + 1) begin
			#delay;
			clock = ~clock;
		end

		PCSrc = 3'b001;
		for (i = 0; i < 4; i = i + 1) begin
			#delay;
			clock = ~clock;
		end

		PCSrc = 3'b000;
		for (i = 0; i < 8; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		// stall
		pcWrite = 0;
		for (i = 0; i < 4; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		// flush
		IFFlush = 1;
		PCSrc = 3'b001;
		for (i = 0; i < 4; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
		IFFlush = 0;
		pcWrite = 1;
		for (i = 0; i < 4; i = i + 1) begin
			#delay;
			clock = ~clock;
		end
	end
endmodule

	