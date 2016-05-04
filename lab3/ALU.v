`include "shift.v"
`include "compare.v"
`include "adderRTL.v"
`include "andRTL.v"
`include "orRTL.v"
`include "xorRTL.v"

module alu(dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, busA, busB, control);
	output [31:0] dataOut;
	output zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	input [31:0]busA, busB;
	input [2:0] control;
	
	
	wire [31:0] dataOut8 [7:0];
	wire [7:0] zeroFlag8, overflowFlag8, carryoutFlag8, negativeFlag8;

	// assign the NOP values
	assign dataOut8[0] = 32'b0;
	assign zeroFlag8[0] = 1'b0; // check with TA
	assign overflowFlag8[0] = 1'b0;
	assign carryoutFlag8[0] = 1'b0;
	assign negativeFlag8[0] = 1'b0;
	
	//call all modules
	adderRTL adder(dataOut8[1], carryoutFlag8[1], overflowFlag8[1], zeroFlag8[1], negativeFlag8[1], busA, busB);
	subtractorRTL subtractor(dataOut8[2], carryoutFlag8[2], overflowFlag8[2], zeroFlag8[2], negativeFlag8[2], busA, busB);
	andRTL ander(busA, busB,dataOut8[3],zeroFlag8[3], negativeFlag8[3], overflowFlag8[3],carryoutFlag8[3] );
	orRTL orer(busA, busB,dataOut8[4],zeroFlag8[4], negativeFlag8[4], overflowFlag8[4],carryoutFlag8[4] );
	xorRTL xorer(busA, busB,dataOut8[5],zeroFlag8[5], negativeFlag8[5], overflowFlag8[5],carryoutFlag8[5] );
	compareRTL comparer(busA, busB,dataOut8[6][1:0], zeroFlag8[6], overflowFlag8[6], carryoutFlag8[6], negativeFlag8[6]);
	shiftRTL shifter(busA, busB[1:0],dataOut8[7], zeroFlag8[7], overflowFlag8[7], carryoutFlag8[7], negativeFlag8[7]);
	
	// Select between outputs
	mux32_8 selDataOut(dataOut, dataOut8[0], dataOut8[1], dataOut8[2], dataOut8[3], dataOut8[4], dataOut8[5], dataOut8[6], dataOut8[7], control);
	mux1_8 selZero(zeroFlag, zeroFlag8, control);
	mux1_8 selOverf(overflowFlag, overflowFlag8, control);
	mux1_8 selCarry(carryoutFlag, carryoutFlag8, control);
	mux1_8 selNeg(negativeFlag, negativeFlag8, control);
	
endmodule


module mux32_8 (D0, i0,
					i1,
					i2,
					i3,
					i4,
					i5,
					i6,
					i7, sel);
	output [31:0] D0;
	input [31:0] i0, i1, i2, i3, i4, i5, i6, i7;
	input[2:0] sel;

	wire [31:0] v [1:0];

	mux32_4 m0(v[0], i0,  i1,  i2,  i3,  sel[0], sel[1]);
	mux32_4 m1(v[1], i4,  i5,  i6,  i7,  sel[0], sel[1]);

	mux32_2 m10(D0, v[0], v[1], sel[2]);
endmodule
 
module mux32_4(D0, in0, in1, in2, in3, sel0, sel1);
	output [31:0] D0;
	input [31:0] in0, in1, in2, in3; 
	input sel0, sel1;

	wire [31:0] q0, q1;

	mux32_2 m0(q0, in0, in1, sel0);
	mux32_2 m1(q1, in2, in3, sel0);
	mux32_2 m (D0, q0, q1, sel1);
 
endmodule

module mux32_2(D0, in0, in1, sel0);
	output [31:0] D0;
	input  [31:0] in0, in1;
	input sel0;

	wire nSel;
	wire [31:0] q0, q1;

	not(nSel, sel0);
	
	genvar i;
	
	generate
	for (i = 0; i < 32; i = i + 1)
	begin: ands
		and(q0[i], in1[i], sel0);
		and(q1[i], in0[i], nSel);
	end
	endgenerate
	
	genvar j;
	
	generate
	for (j = 0; j < 32; j = j + 1)
	begin: ors
		or(D0[j], q0[j], q1[j]);
	end
	endgenerate
	
endmodule

module mux1_8 (D0, i, sel);
	output D0;
	input [7:0] i;
	input[2:0] sel;

	wire v [1:0];

	mux1_4 m0(v[0], i[0],  i[1],  i[2],  i[3],  sel[0], sel[1]);
	mux1_4 m1(v[1], i[4],  i[5],  i[6],  i[7],  sel[0], sel[1]);

	mux1_2 m10(D0, v[0], v[1], sel[2]);
endmodule
 
module mux1_4(D0, in0, in1, in2, in3, sel0, sel1);
	output D0;
	input in0, in1, in2, in3; 
	input sel0, sel1;

	wire q0, q1;
	
	mux1_2 m0(q0, in0, in1, sel0);
	mux1_2 m1(q1, in2, in3, sel0);
	mux1_2 m (D0, q0, q1, sel1);
 
endmodule

module mux1_2(D0, in0, in1, sel0);
	output D0;
	input in0, in1;
	input sel0;

	wire nSel;
	wire q0, q1;

	not(nSel, sel0);
	
	and(q0, in1, sel0);
	and(q1, in0, nSel);
	or(D0, q0, q1);

endmodule
