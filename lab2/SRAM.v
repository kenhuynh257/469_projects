module SRAM();

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