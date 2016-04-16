module SRAM(data, addr, weBar, oeBar);
	inout [7:0] data;
	input [7:0] addr;
	input weBar;
	input oeBar;

	reg [7:0] state [255:0];

	assign data[7:0] = oeBar ? 'bz : state[addr[7:0]][7:0];

	always @(*) begin
		if (!weBar & oeBar) begin
			state[addr[7:0]][7:0] = data[7:0];
		end
	end
endmodule


module MAR(outAdd, inAdd, reset, clock);
	output reg [7:0] outAdd;
	input [7:0] inAdd;
	input reset, clock;
	
	always @(posedge clock)
	if (reset)
		outAdd <= 7'b0;
	else
		outAdd <= inAdd;

endmodule

module MDR(outDat, inDat, reset, clock);
	output reg [7:0] outDat;
	input [7:0] inDat;
	input reset, clock;
	
	always @(posedge clock)
	if (reset)
		outDat <= 7'b0;
	else
		outDat <= inDat;
endmodule