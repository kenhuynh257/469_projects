module registerFile (readOut_1, readOut_2, readSel_1, readSel_2, writeSel, data, we, rst, clock);
	output reg [31:0] readOut_1, readOut_2;
	input [4:0] readSel_1, readSel_2, writeSel;
	input [31:0] data;
	input rst, we, clock;
	
	reg [31:0] memory [31:0]; //The structure that contains the data
	integer i;
	initial begin
		for(i =1; i < 32;i=i+1) begin
			memory[i] = 31'b0;
			end
	end
	
	wire [31:0] readOut_1_temp, readOut_2_temp;
	
	mux32 ma0(readOut_1_temp, memory[0],
						memory[1],
						memory[2],
						memory[3],
						memory[4],
						memory[5],
						memory[6],
						memory[7],
						memory[8],
						memory[9],
						memory[10],
						memory[11],
						memory[12],
						memory[13],
						memory[14],
						memory[15],
						memory[16],
						memory[17],
						memory[18],
						memory[19],
						memory[20],
						memory[21],
						memory[22],
						memory[23],
						memory[24],
						memory[25],
						memory[26],
						memory[27],
						memory[28],
						memory[29],
						memory[30],
						memory[31], readSel_1);
	
	mux32 ma1(readOut_2_temp, memory[0],
						memory[1],
						memory[2],
						memory[3],
						memory[4],
						memory[5],
						memory[6],
						memory[7],
						memory[8],
						memory[9],
						memory[10],
						memory[11],
						memory[12],
						memory[13],
						memory[14],
						memory[15],
						memory[16],
						memory[17],
						memory[18],
						memory[19],
						memory[20],
						memory[21],
						memory[22],
						memory[23],
						memory[24],
						memory[25],
						memory[26],
						memory[27],
						memory[28],
						memory[29],
						memory[30],
						memory[31], readSel_2);


	wire [31:0] writeDec, enWriteDec;
	decoder dec0(writeDec, writeSel); // decoding write select

	and a0 (enWriteDec[0],  writeDec[0],  we);
	and a1 (enWriteDec[1],  writeDec[1],  we);
	and a2 (enWriteDec[2],  writeDec[2],  we);
	and a3 (enWriteDec[3],  writeDec[3],  we);
	and a4 (enWriteDec[4],  writeDec[4],  we);
	and a5 (enWriteDec[5],  writeDec[5],  we);
	and a6 (enWriteDec[6],  writeDec[6],  we);
	and a7 (enWriteDec[7],  writeDec[7],  we);
	and a8 (enWriteDec[8],  writeDec[8],  we);
	and a9 (enWriteDec[9],  writeDec[9],  we);
	and a10(enWriteDec[10], writeDec[10], we);
	and a11(enWriteDec[11], writeDec[11], we);
	and a12(enWriteDec[12], writeDec[12], we);
	and a13(enWriteDec[13], writeDec[13], we);
	and a14(enWriteDec[14], writeDec[14], we);
	and a15(enWriteDec[15], writeDec[15], we);
	and a16(enWriteDec[16], writeDec[16], we);
	and a17(enWriteDec[17], writeDec[17], we);
	and a18(enWriteDec[18], writeDec[18], we);
	and a19(enWriteDec[19], writeDec[19], we);
	and a20(enWriteDec[20], writeDec[20], we);
	and a21(enWriteDec[21], writeDec[21], we);
	and a22(enWriteDec[22], writeDec[22], we);
	and a23(enWriteDec[23], writeDec[23], we);
	and a24(enWriteDec[24], writeDec[24], we);
	and a25(enWriteDec[25], writeDec[25], we);
	and a26(enWriteDec[26], writeDec[26], we);
	and a27(enWriteDec[27], writeDec[27], we);
	and a28(enWriteDec[28], writeDec[28], we);
	and a29(enWriteDec[29], writeDec[29], we);
	and a30(enWriteDec[30], writeDec[30], we);
	and a31(enWriteDec[31], writeDec[31], we);
	
	integer k;
	always @(*)
	begin
		if(rst)
			for (k = 1; k < 32; k = k + 1)
					memory[k] <= 31'b0;
		else
		begin
			for (k = 1; k < 32; k = k + 1)
			begin
				if (enWriteDec[k])
					memory[k][31:0] <= data[31:0];	
			end
			memory[0] <= 32'b0;
		end
	end
	
	always @ (negedge clock) begin
		if (rst)
		begin
			readOut_1 <= 32'b0;
			readOut_2 <= 32'b0;
		end
		else 
		begin
			readOut_1 <= readOut_1_temp;
			readOut_2 <= readOut_2_temp;
		end
	end
	
	initial 
	begin
		memory[0] = 32'b0;
	end
	
endmodule

module dFlipFlop(Q, Qbar, D, clock, reset);
	output Q, Qbar;
	input D, clock, reset;
	
	wire Dbar, s0, s1;
	
	not n0(Dbar, D);
	
	nand nd0(s0, clock, D);
	nand nd1(s1, clock, Dbar);
	
	nand nd2(Q, Qbar, s0);
	nand nd3(Qbar, Q, s1);

endmodule


module decoder(decode, select);
	output [31:0] decode;
	input [4:0] select;

	wire [4:0] nSelect;
	
	not n0(nSelect[0], select[0]);
	not n1(nSelect[1], select[1]);
	not n2(nSelect[2], select[2]);
	not n3(nSelect[3], select[3]);
	not n4(nSelect[4], select[4]);
	
	and a0 (decode[0],  nSelect[4], nSelect[3], nSelect[2], nSelect[1], nSelect[0]);
	and a1 (decode[1],  nSelect[4], nSelect[3], nSelect[2], nSelect[1],  select[0]);
	and a2 (decode[2],  nSelect[4], nSelect[3], nSelect[2],  select[1], nSelect[0]);
	and a3 (decode[3],  nSelect[4], nSelect[3], nSelect[2],  select[1],  select[0]);
	and a4 (decode[4],  nSelect[4], nSelect[3],  select[2], nSelect[1], nSelect[0]);
	and a5 (decode[5],  nSelect[4], nSelect[3],  select[2], nSelect[1],  select[0]);
	and a6 (decode[6],  nSelect[4], nSelect[3],  select[2],  select[1], nSelect[0]);
	and a7 (decode[7],  nSelect[4], nSelect[3],  select[2],  select[1],  select[0]);
	and a8 (decode[8],  nSelect[4],  select[3], nSelect[2], nSelect[1], nSelect[0]);
	and a9 (decode[9],  nSelect[4],  select[3], nSelect[2], nSelect[1],  select[0]);
	and a10(decode[10], nSelect[4],  select[3], nSelect[2],  select[1], nSelect[0]);
	and a11(decode[11], nSelect[4],  select[3], nSelect[2],  select[1],  select[0]);
	and a12(decode[12], nSelect[4],  select[3],  select[2], nSelect[1], nSelect[0]);
	and a13(decode[13], nSelect[4],  select[3],  select[2], nSelect[1],  select[0]);
	and a14(decode[14], nSelect[4],  select[3],  select[2],  select[1], nSelect[0]);
	and a15(decode[15], nSelect[4],  select[3],  select[2],  select[1],  select[0]);
	and a16(decode[16],  select[4], nSelect[3], nSelect[2], nSelect[1], nSelect[0]);
	and a17(decode[17],  select[4], nSelect[3], nSelect[2], nSelect[1],  select[0]);
	and a18(decode[18],  select[4], nSelect[3], nSelect[2],  select[1], nSelect[0]);
	and a19(decode[19],  select[4], nSelect[3], nSelect[2],  select[1],  select[0]);
	and a20(decode[20],  select[4], nSelect[3],  select[2], nSelect[1], nSelect[0]);
	and a21(decode[21],  select[4], nSelect[3],  select[2], nSelect[1],  select[0]);
	and a22(decode[22],  select[4], nSelect[3],  select[2],  select[1], nSelect[0]);
	and a23(decode[23],  select[4], nSelect[3],  select[2],  select[1],  select[0]);
	and a24(decode[24],  select[4],  select[3], nSelect[2], nSelect[1], nSelect[0]);
	and a25(decode[25],  select[4],  select[3], nSelect[2], nSelect[1],  select[0]);
	and a26(decode[26],  select[4],  select[3], nSelect[2],  select[1], nSelect[0]);
	and a27(decode[27],  select[4],  select[3], nSelect[2],  select[1],  select[0]);
	and a28(decode[28],  select[4],  select[3],  select[2], nSelect[1], nSelect[0]);
	and a29(decode[29],  select[4],  select[3],  select[2], nSelect[1],  select[0]);
	and a30(decode[30],  select[4],  select[3],  select[2],  select[1], nSelect[0]);
	and a31(decode[31],  select[4],  select[3],  select[2],  select[1],  select[0]);
	
endmodule


module mux2(D0, in0, in1, sel0);
	output [31:0] D0;
	input  [31:0] in0, in1;
	input sel0;

	wire nSel;
	wire [31:0] q0, q1;

	not(nSel, sel0);
	
	and(q0[0], in1[0], sel0);
	and(q0[1], in1[1], sel0);
	and(q0[2], in1[2], sel0);
	and(q0[3], in1[3], sel0);
	and(q0[4], in1[4], sel0);
	and(q0[5], in1[5], sel0);
	and(q0[6], in1[6], sel0);
	and(q0[7], in1[7], sel0);
	and(q0[8], in1[8], sel0);
	and(q0[9], in1[9], sel0);
	and(q0[10], in1[10], sel0);
	and(q0[11], in1[11], sel0);
	and(q0[12], in1[12], sel0);
	and(q0[13], in1[13], sel0);
	and(q0[14], in1[14], sel0);
	and(q0[15], in1[15], sel0);
	and(q0[16], in1[16], sel0);
	and(q0[17], in1[17], sel0);
	and(q0[18], in1[18], sel0);
	and(q0[19], in1[19], sel0);
	and(q0[20], in1[20], sel0);
	and(q0[21], in1[21], sel0);
	and(q0[22], in1[22], sel0);
	and(q0[23], in1[23], sel0);
	and(q0[24], in1[24], sel0);
	and(q0[25], in1[25], sel0);
	and(q0[26], in1[26], sel0);
	and(q0[27], in1[27], sel0);
	and(q0[28], in1[28], sel0);
	and(q0[29], in1[29], sel0);
	and(q0[30], in1[30], sel0);
	and(q0[31], in1[31], sel0);
	
	and(q1[0], in0[0], nSel);
	and(q1[1], in0[1], nSel);
	and(q1[2], in0[2], nSel);
	and(q1[3], in0[3], nSel);
	and(q1[4], in0[4], nSel);
	and(q1[5], in0[5], nSel);
	and(q1[6], in0[6], nSel);
	and(q1[7], in0[7], nSel);
	and(q1[8], in0[8], nSel);
	and(q1[9], in0[9], nSel);
	and(q1[10], in0[10], nSel);
	and(q1[11], in0[11], nSel);
	and(q1[12], in0[12], nSel);
	and(q1[13], in0[13], nSel);
	and(q1[14], in0[14], nSel);
	and(q1[15], in0[15], nSel);
	and(q1[16], in0[16], nSel);
	and(q1[17], in0[17], nSel);
	and(q1[18], in0[18], nSel);
	and(q1[19], in0[19], nSel);
	and(q1[20], in0[20], nSel);
	and(q1[21], in0[21], nSel);
	and(q1[22], in0[22], nSel);
	and(q1[23], in0[23], nSel);
	and(q1[24], in0[24], nSel);
	and(q1[25], in0[25], nSel);
	and(q1[26], in0[26], nSel);
	and(q1[27], in0[27], nSel);
	and(q1[28], in0[28], nSel);
	and(q1[29], in0[29], nSel);
	and(q1[30], in0[30], nSel);
	and(q1[31], in0[31], nSel);
	
	or(D0[0], q0[0], q1[0]);
	or(D0[1], q0[1], q1[1]);
	or(D0[2], q0[2], q1[2]);
	or(D0[3], q0[3], q1[3]);
	or(D0[4], q0[4], q1[4]);
	or(D0[5], q0[5], q1[5]);
	or(D0[6], q0[6], q1[6]);
	or(D0[7], q0[7], q1[7]);
	or(D0[8], q0[8], q1[8]);
	or(D0[9], q0[9], q1[9]);
	or(D0[10], q0[10], q1[10]);
	or(D0[11], q0[11], q1[11]);
	or(D0[12], q0[12], q1[12]);
	or(D0[13], q0[13], q1[13]);
	or(D0[14], q0[14], q1[14]);
	or(D0[15], q0[15], q1[15]);
	or(D0[16], q0[16], q1[16]);
	or(D0[17], q0[17], q1[17]);
	or(D0[18], q0[18], q1[18]);
	or(D0[19], q0[19], q1[19]);
	or(D0[20], q0[20], q1[20]);
	or(D0[21], q0[21], q1[21]);
	or(D0[22], q0[22], q1[22]);
	or(D0[23], q0[23], q1[23]);
	or(D0[24], q0[24], q1[24]);
	or(D0[25], q0[25], q1[25]);
	or(D0[26], q0[26], q1[26]);
	or(D0[27], q0[27], q1[27]);
	or(D0[28], q0[28], q1[28]);
	or(D0[29], q0[29], q1[29]);
	or(D0[30], q0[30], q1[30]);
	or(D0[31], q0[31], q1[31]);

endmodule

 
module mux4(D0, in0, in1, in2, in3, sel0, sel1);
	output [31:0] D0;
	input [31:0] in0, in1, in2, in3; 
	input sel0, sel1;

	wire [31:0] q0, q1;

	mux2 m0(q0, in0, in1, sel0);
	mux2 m1(q1, in2, in3, sel0);
	mux2 m (D0, q0, q1, sel1);
 
endmodule


module mux32 (D0, i0,
						i1,
						i2,
						i3,
						i4,
						i5,
						i6,
						i7,
						i8,
						i9,
						i10,
						i11,
						i12,
						i13,
						i14,
						i15,
						i16,
						i17,
						i18,
						i19,
						i20,
						i21,
						i22,
						i23,
						i24,
						i25,
						i26,
						i27,
						i28,
						i29,
						i30,
						i31, sel);
	output [31:0] D0;
	input [31:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15, i16, i17, i18, i19, i20, i21, i22, i23, i24, i25, i26, i27, i28, i29, i30, i31;
	input[4:0] sel;

	wire [31:0] v [9:0];

	mux4 m0(v[0], i0,  i1,  i2,  i3,  sel[0], sel[1]);
	mux4 m1(v[1], i4,  i5,  i6,  i7,  sel[0], sel[1]);
	mux4 m2(v[2], i8,  i9,  i10, i11, sel[0], sel[1]);
	mux4 m3(v[3], i12, i13, i14, i15, sel[0], sel[1]);
	mux4 m4(v[4], i16, i17, i18, i19, sel[0], sel[1]);
	mux4 m5(v[5], i20, i21, i22, i23, sel[0], sel[1]);
	mux4 m6(v[6], i24, i25, i26, i27, sel[0], sel[1]);
	mux4 m7(v[7], i28, i29, i30, i31, sel[0], sel[1]);

	mux4 m8(v[8], v[0], v[1], v[2], v[3], sel[2], sel[3]);
	mux4 m9(v[9], v[4], v[5], v[6], v[7], sel[2], sel[3]);

	mux2 m10(D0, v[8], v[9], sel[4]);
endmodule
