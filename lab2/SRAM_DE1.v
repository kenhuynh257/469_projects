module SRAM_DE1(SW, CLOCK_50, LEDR, KEY);
	// DE1 connections
	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;
	output [9:0] LEDR;
	// module connections
	wire nOutput, nWrite;
	wire [15:0]data, sData;
	wire [10:0]sAddr, addr;	
	wire [31:0] divclk;
	// clock division
	clockDivider divideIt(divclk, CLOCK_50);
	wire clock;
	
	always @(*) begin
		// Choose divided clock
		if (SW[9]) begin
			clock = divclk[31];
		end else if (SW[8]) begin
			clock = divclk[27];
		end else if (SW[7]) begin
			clock = divclk[23];
		end else begin
			clock = divclk[19];
		end
		// setup the lights
		LEDR[6:0] = data[6:0];
	end
		
	// connect the modules
	memory tSRAM(mdrSRAM, sramAddr, nWrite, clock);
	MDR tMDR(data, mdrSRAM, nOutput, nWrite, clock);
	MAR tMAR(sramAddr, addr, clock);
	tester test(clock, data, addr, nOutput, nWrite, mdrSRAM, sramAddr, KEY[0]);

	
	
endmodule

module clockDivider(divclk, CLK);
	input CLK;
	output reg [31:0] divclk;
	
	initial divclk = 0;
	always @ (posedge CLK) begin
		divclk <= divclk + 1'b1;
	end
endmodule

module tester(clock, data, addr, nOutput, nWrite, mdrSRAM, sramAddr, rst);
	inout [15:0] data;
	output reg clock, nOutput, nWrite;
	output reg [10:0] addr;
	input [15:0] mdrSRAM;
	input[10:0] sramAddr;
	reg [15:0] writeData;
	input rst;
	assign data[15:0] = nOutput ? writeData[15:0] : 16'bz;
	
	// write numbers 127-0 into memory locations 0-127
	initial
	begin
		writeData[15:0] = 16'd127;
		addr[10:0] = 11'b0;
		nOutput = 1'b1;
		nWrite = 1'b0;
	end
	
	always @(posedge clock)
	begin
		if (rst == 1'b0) begin
			writeData[15:0] <= 16'd127;
			addr[10:0] <= 11'b0;
		end else if (writeData > 0) begin
			writeData <= writeData - 1'b1; // count down
			addr <= addr + 1'b1;
		end else if (writeData == 0) begin
			addr <= 11'b0;
			nWrite <= 1'b1;
			writeData <= writeData - 1'b1;
		end else begin
			addr <= addr - 1'b1;
		end
	end
endmodule