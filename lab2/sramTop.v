`include "SRAM.v"

module sramTestbench;
	wire weBar, oeBar;
	wire [15:0]outDat, data;
	wire [10:0]inAdd, addr;
	wire clock, reset;
	
	MAR dut0(addr, inAdd, reset, clock);
	SRAM dut1(data, addr, weBar, oeBar, clock);
	MDR dut2(outDat, data, reset, clock);
	
	tester test(clock, data, addr, weBar, oeBar, outDat, inAdd);
	
	initial 
	begin
		$dumpfile("SRAM.vcd");
		$dumpvars(1, dut1);
	end
	
endmodule


module tester(clock, data, addr, weBar, oeBar, outDat, inAdd);
	inout [15:0]data;
	input weBar, oeBar;
	input [15:0]outDat;
	input [10:0]inAdd, addr;
	output reg clock, reset;
	
	parameter delay = 2;
	
	initial 
	begin 
		$display("\t\tclock\treset\taddr\tweBar\toeBar\toutDat\tinAdd\tdata\ttime");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g",
					clock, reset, addr, weBar, oeBar, outDat, data, $time);			
	end
	
	initial
	begin
		clock = 1'b0;
		reset = 1'b0;
		for()
		begin
			#delay clk = ~clk;
			
		end
	end
	
endmodule
