module compareTop();
	wire [31:0] dataOut;
	wire zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	wire [31:0]busA, busB;

	compareRTL dut(busA, busB, dataOut[1:0], zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	//tester testCompare(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);

endmodule

/*
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
*/

module compareRTL(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] busA, busB;
	output [31:0] dataOut;
	output  zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	assign zeroFlag = 0;
	assign overflowFlag = 0;
	assign carryoutFlag = 0;
	assign negativeFlag = 0;
	assign dataOut = (busA < busB) ? 1 : 0;
endmodule
