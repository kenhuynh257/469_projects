module SRAM_DE1(SW, CLOCK_50, LEDR);
	// DE1 connections
	input [9:0] SW;
	input CLOCK_50;
	output [9:0] LEDR;
	// module connections
	wire nOutput, nWrite;
	wire [15:0]data, sData;
	wire [10:0]sAddr, addr;	
	wire divclk[31:0];
	// clock division
	clockDivider divideIt(divclk, CLOCK_50);
	wire clock;
	
	always @* begin
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
		// Setup switches for nOutput and nWrite
		nOutput = SW[1];
		nWrite = SW[0];
		// setup the lights
		LEDR[6:0] = data[6:0];
	end
		
	// connect the modules
	SRAM tSRAM(sData, sAddr, nWrite, clock);
	MDR tMDR(data, sData, nOutput, nWrite, clock);
	MAR tMAR(sAddr, addr, clock);
	

	
	
endmodule

module clockDivider(divclk, CLK);
	input CLK;
	output [31:0] divclk;
	
	initial divclk = 0;
	always (@posedge CLK) begin
		divclk <= divclk + 1'b1;
	end
endmodule