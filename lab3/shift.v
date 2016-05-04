module shiftTop();
	wire [31:0] dataOut;
	wire zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	wire [31:0]busA, busB;
	wire [2:0] control;

	shiftRTL dutShift(busA, busB[1:0], dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	//tester testShift(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);


endmodule


/*
module tester(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] dataOut;
	input zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	output reg [31:0]busA, busB;

	parameter delay = 10;

	initial begin 
		$display("\t\t busA \t busB \t dataOut \t zeroFlag \t overflowFlag \t carryoutFlag \t negativeFlag \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g",
					busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, $time);			
	end

	initial begin
		busA = 32'b11110000111100001111000011110000;
		busB = 32'b0;
		#delay;
		busB = 4;
		#delay;
		busB = 1;
		#delay;
		busB = 2;
		#delay;
		busB = 3;
		#delay;

	end
endmodule
*/
 
module shiftBehave(in, amount, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] in;
	input [1:0] amount;
	output reg[31:0] dataOut;
	output reg zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	always @(*) begin
		overflowFlag = 1'b0;
		case (amount)
			2'b00: begin 
					carryoutFlag = 1'b0;
					dataOut = in;
					negativeFlag = dataOut[31];
					zeroFlag = (dataOut == 0) ? 1'b1 : 1'b0;
					end
			2'b01: begin
					carryoutFlag = in[31];
					dataOut = in << 1;
					negativeFlag = dataOut[31];
					zeroFlag = (dataOut == 0) ? 1'b1 : 1'b0; // does the zero flag specify if the output or input is zero?
					end
			2'b10: begin
					carryoutFlag = in[31];
					dataOut = in << 2;
					negativeFlag = dataOut[31];
					zeroFlag = (dataOut == 0) ? 1'b1 : 1'b0;
					end
			2'b11: begin
					carryoutFlag = in[31];
					dataOut = in << 3;
					negativeFlag = dataOut[31];
					zeroFlag = (dataOut == 0) ? 1'b1 : 1'b0;
					end
		endcase
	end
endmodule

module shiftRTL(in, amount, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] in;
	input [1:0] amount;
	output [31:0] dataOut;
	output zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	assign overflowFlag = 1'b0;
	assign carryoutFlag = (amount == 2'b00) ? 1'b0 : in[31];
	assign dataOut = (amount == 2'b00) ? in : (amount == 2'b01) ? in << 1 : (amount == 2'b10) ? in << 2 : in << 3;
	assign negativeFlag = dataOut[31];
	assign zeroFlag = (dataOut == 0) ? 1'b1 : 1'b0;

endmodule