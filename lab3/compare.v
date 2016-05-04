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


module compareRTL(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] busA, busB;
	output reg[31:0] dataOut;
	output reg zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	assign zeroFlag = 0;
	assign overflowFlag = 0;
	assign carryoutFlag = 0;
	assign negativeFlag = 0;
	assign dataOut = (a < b) ? 1 : 0;
endmodule

/* module compareRTL (busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] busA, busB;
	output [1:0] dataOut;
	output zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	genvar i;
	
	generate
	for (i = 0; i < 32; i = i + 1)
	begin: comparator
		assign lessThan = 
	end
	
	assign dataOut = (a[31] > b[31]) | ((a[31] == b[31]) & )
	assign zeroFlag = 0;
	assign overflowFlag = 0;
	assign carryoutFlag = 0;
	assign negativeFlag = 0;
endmodule */

/* module compare1(out, a, b);
	output out;
	input a, b;
	assign out = (a < b) ? 1 : 0;
endmodule */