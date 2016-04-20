`include "SRAM.v"

module sramTop();
	wire nOutput, nWrite;
	wire [15:0]data, mdrSRAM;
	wire [10:0]sramAddr, addr;
	wire clock;
	
	SRAM tSRAM(mdrSRAM, sramAddr, nWrite, clock);
	MDR tMDR(data, mdrSRAM, nOutput, nWrite, clock);
	MAR tMAR(sramAddr, addr, clock);
	tester test(clock, data, addr, nOutput, nWrite, mdrSRAM, sramAddr);
	
	initial 
	begin
		$dumpfile("SRAM.vcd");
		$dumpvars(1, test);
	end
	
endmodule


module tester(clock, data, addr, nOutput, nWrite, mdrSRAM, sramAddr);
	inout [15:0] data;
	output reg clock, nOutput, nWrite;
	output reg [10:0] addr;
	input [15:0] mdrSRAM;
	input[10:0] sramAddr;
	reg [15:0] writeData;
	integer i;
	
	assign data[15:0] = nOutput ? writeData[15:0] : 16'bz;
	
	
	parameter delay = 200;
	
	initial 
	begin 
		$display("\t\t clock \t nOutput \t nWrite \t data \t mdrSRAM \t addr \t sramAddr \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g",
					clock, nOutput, nWrite, data, mdrSRAM, addr, sramAddr, $time);			
	end
	
	initial
	begin
		clock = 1'b0;
		for (i = 0; i < 4; i++) begin
		#delay clock = ~clock;
		end
		#delay clock = ~clock;
		nOutput = 1'b1;
		nWrite = 1'b0;
		#1 addr[10:0] = 11'b0;
		#1 writeData[15:0] = 16'b0;
		#delay clock = ~clock;
		// write
		for(i = 0; i < 128; i = i + 1) begin
			#delay clock = ~clock;
			#1 writeData[15:0] = i; // small delay simulates propagation of information
			#1 addr[10:0] = i;
			#delay clock = ~clock;
		end

		// settle
		for(i = 0; i < 4 ; i = i + 1) begin
			#delay clock = ~clock;
			
		end
		nOutput = 1'b0;
		nWrite = 1'b1;
		// read
		for (i = 0; i < 128; i = i + 1) begin
			#delay clock = ~clock;
			#1 addr[10:0] = i;
			#delay clock = ~clock;
		end
		for (i = 0; i < 8; i = i+1) begin
			#delay clock = ~clock;
		end
		// extra
		nOutput = 1'b1;
		for (i = 0; i < 8; i = i+1) begin
			#delay clock = ~clock;
		end
		#1 addr[10:1] = 11'd5;
		for (i = 0; i < 8; i = i+1) begin
			#delay clock = ~clock;
		end
		nOutput = 1'b0;
		for (i = 0; i < 8; i = i+1) begin
			#delay clock = ~clock;
		end
	end
	
endmodule
