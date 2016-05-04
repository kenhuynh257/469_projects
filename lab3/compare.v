module compareTop();
	wire [31:0] dataOut;
	wire zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	wire [31:0]busA, busB;

	compareRTL dut(busA, busB, dataOut[1:0], zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	tester testCompare(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	initial begin
		$dumpfile("compare.vcd");
		$dumpvars(1, testCompare);
	end

endmodule


module tester(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] dataOut;
	input zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	output reg [31:0] busA, busB;

	parameter delay = 10;

	initial begin 
		$display("\t\t busA \t busB \t dataOut \t zeroFlag \t overflowFlag \t carryoutFlag \t negativeFlag \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g",
					busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, $time);			
	end

	initial begin
		busA = 0; busB = 0;
		#delay;
		busA = 0; busB = 1;
		#delay;
		busA = 1; busB = 0;
		#delay;
		busA = 1; busB = 1;
		#delay;
		#delay;
	end
endmodule


module compareBehave(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] busA, busB;
	output reg[1:0] dataOut;
	output reg zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	always @(*) begin
		zeroFlag = (busA == 0 && busB == 0) ? 1'b1 : 1'b0;
		overflowFlag = 1'b0;
		carryoutFlag = 1'b0;
		negativeFlag = 1'b0;
		if (busA == busB) dataOut = 2'b0;
		else if (busA > busB) dataOut = 2'b01;
		else dataOut = 2'b10;
	end
endmodule

module compareRTL (busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] busA, busB;
	output [1:0] dataOut;
	output zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	assign zeroFlag = (busA == 0 && busB == 0) ? 1'b1 : 1'b0;
	assign overflowFlag = 1'b0;
	assign carryoutFlag = 1'b0;
	assign negativeFlag = 1'b0;
	assign dataOut = (busA == busB) ? 2'b0 : (busA > busB) ? 2'b01 : 2'b10;
endmodule