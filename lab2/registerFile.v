module registerFile (readOut_1, readOut_2, readSel_1, readSel_2, writeSel, data, we);

endmodule

module dFlipFlop(Q, Qbar, D, clock, reset);
	output Q, Qbar;
	input D, clock, reset;
	
	wire Dbar, s0, s1;
	
	not n0(Qbar, Q);
	not n0(Dbar, D);
	
	nand nd0(s0, clock, D);
	nand nd1(s1, clock, Dbar);
	
	nand nd2(Q, Qbar, s0);
	nand nd3(Qbar, Q, s1);

endmodule

module decoder();

endmodule


module mux2(D0, in0, in1, sel0);
	output reg D0;
	input  in0, in1;
	input sel0;

	wire nSel, q0, q1;

	not(selbar, sel0);
	and(q0,in1,sel0);
	and(q1,in0,selbar);
	or(D0,q0,q1);

endmodule

 
module mux4(D0, in0, in1, in2, in3 sel0, sel1);
	output reg D0;
	input in0, in1, in2, in3; 
	input sel0, sel1;

	wire q0, q1;

	mux2_1 m0(q0, in0, in1, sel0);
	mux2_1 m1(q1, in2, in3, sel0);
	mux2_1 m (D0, q0, q1, sel1);
 
endmodule


module mux32 (D0,i,sel);
	output reg D0;
	input [31:0] i ;
	input[4:0] sel;

	wire  v [9:0];

	mux4_1 m1(v[0], i[0],  i[1],  i[2],  i[3],  sel[0], sel[1]);
	mux4_1 m2(v[1], i[4],  i[5],  i[6],  i[7],  sel[0], sel[1]);
	mux4_1 m3(v[2], i[8],  i[9],  i[10], i[11], sel[0], sel[1]);
	mux4_1 m4(v[3], i[12], i[13], i[14], i[15], sel[0], sel[1]);
	mux4_1 m5(v[4], i[16], i[17], i[18], i[19], sel[0], sel[1]);
	mux4_1 m6(v[5], i[20], i[21], i[22], i[23], sel[0], sel[1]);
	mux4_1 m7(v[6], i[24], i[25], i[26], i[27], sel[0], sel[1]);
	mux4_1 m8(v[7], i[28], i[29], i[30], i[31], sel[0], sel[1]);

	mux4_1  m9(v[8], v[0], v[1], v[2], v[3], sel[2], sel[3]);
	mux4_1 m10(v[9], v[4], v[5], v[6], v[7], sel[2], sel[3]);

	mux2_1 m (D0, v[8], v[9], sel[4]);
endmodule
