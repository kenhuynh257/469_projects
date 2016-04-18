module SRAM(data, addr, weBar, oeBar, clock);
	inout [15:0] data;
	input [10:0] addr;
	input weBar;
	input oeBar;
	input clock;

	reg [15:0] state [2047:0];

	assign data[15:0] = oeBar ? 'bz : state[addr[10:0]][15:0];

	always @(posedge clock) 
	begin
		if (!weBar & oeBar) 
			state[addr[10:0]][15:0] <= data[15:0];
	end
endmodule


module MAR(outAdd, inAdd, reset, clock);
	output reg [10:0] outAdd;
	input [10:0] inAdd;
	input reset, clock;
	
	always @(posedge clock)
	if (reset)
		outAdd <= 11'b0;
	else
		outAdd <= inAdd;

endmodule

module MDR(outDat, inDat, reset, clock);
	output reg [15:0] outDat;
	input [15:0] inDat;
	input reset, clock;
	
	always @(posedge clock)
	if (reset)
		outDat <= 16'b0;
	else
		outDat <= inDat;
endmodule