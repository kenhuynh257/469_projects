`include "ALU.v"
`include "ALUcontrol.v"
`include "ALU_functions.v"

module execute(ALUresult, busBpreMux, zeroF, regWriteSel, rt_DX, rd_DX, immediate, readData1, readData2in, regDst, ALUSrc, ALUOp, clock);
	output [31:0] ALUresult, busBpreMux;
	output zeroF;
	output [4:0] regWriteSel;
	input [4:0] rt_DX, rd_DX;
	input [31:0] immediate, readData1, readData2;
	input [1:0] forwardA, forwardB;
	input regDst, ALUSrc, ALUOp;
	input clock;
	
	wire [31:0] busA, busBpreMux, busB;
	wire oFlag, nFlag, cFlag;
	wire [2:0] control;
	
	mux32_4 mux1(busA, readData1, address, nextOutput, 32'b0, forwardA);
	mux32_4 mux2(busBpreMux, readData2, address, nextOutput, 32'b0, forwardB);
	
	mux32_2 mux3(busB, busBpreMux, immediate, ALUSrc);
	
	alu arithmetic(ALUresult, zeroF, oFlag, nFlag, cFlag, busA, busB, control);
	
	ALUcontrol aCon(control, immediate[5:0], ALUOp);
	
	mux5_2to1 mux4(regWriteSel, rt_DX, rd_DX, regDst);
	
endmodule

module mux5_2to1(D0, in0, in1, sel0);
	output [4:0] D0;
	input [4:0] in0, in1;
	input sel0;

	wire nSel;
	wire [4:0] q0, q1;

	not(nSel, sel0);
	
	genvar i;
	
	generate
	for (i = 0; i < 5; i = i + 1)
	begin: ands
		and(q0[i], in1[i], sel0);
		and(q1[i], in0[i], nSel);
	end
	endgenerate
	
	genvar j;
	
	generate
	for (j = 0; j < 5; j = j + 1)
	begin: ors
		or(D0[j], q0[j], q1[j]);
	end
	endgenerate
endmodule
