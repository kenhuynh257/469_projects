module test (readOut_1, readOut_2, readSel_1, readSel_2, writeSel, data, we, clock);
	output [31:0] readOut_1, readOut_2;
	input [4:0] readSel_1, readSel_2, writeSel;
	input [31:0] data;
	input we, clock;
	
	reg [31:0] memory [31:0]; //The structure that contains the data
	
	mux32 ma0 (readOut_1[0],  memory[0][31:0],  readSel_1);
	mux32 ma1 (readOut_1[1],  memory[1][31:0],  readSel_1);
	mux32 ma2 (readOut_1[2],  memory[2][31:0],  readSel_1);
	mux32 ma3 (readOut_1[3],  memory[3][31:0],  readSel_1);
	mux32 ma4 (readOut_1[4],  memory[4][31:0],  readSel_1);
	mux32 ma5 (readOut_1[5],  memory[5][31:0],  readSel_1);
	mux32 ma6 (readOut_1[6],  memory[6][31:0],  readSel_1);
	mux32 ma7 (readOut_1[7],  memory[7][31:0],  readSel_1);
	mux32 ma8 (readOut_1[8],  memory[8][31:0],  readSel_1);
	mux32 ma9 (readOut_1[9],  memory[9][31:0],  readSel_1);
	mux32 ma10(readOut_1[10], memory[10][31:0], readSel_1);
	mux32 ma11(readOut_1[11], memory[11][31:0], readSel_1);
	mux32 ma12(readOut_1[12], memory[12][31:0], readSel_1);
	mux32 ma13(readOut_1[13], memory[13][31:0], readSel_1);
	mux32 ma14(readOut_1[14], memory[14][31:0], readSel_1);
	mux32 ma15(readOut_1[15], memory[15][31:0], readSel_1);
	mux32 ma16(readOut_1[16], memory[16][31:0], readSel_1);
	mux32 ma17(readOut_1[17], memory[17][31:0], readSel_1);
	mux32 ma18(readOut_1[18], memory[18][31:0], readSel_1);
	mux32 ma19(readOut_1[19], memory[19][31:0], readSel_1);
	mux32 ma20(readOut_1[20], memory[20][31:0], readSel_1);
	mux32 ma21(readOut_1[21], memory[21][31:0], readSel_1);
	mux32 ma22(readOut_1[22], memory[22][31:0], readSel_1);
	mux32 ma23(readOut_1[23], memory[23][31:0], readSel_1);
	mux32 ma24(readOut_1[24], memory[24][31:0], readSel_1);
	mux32 ma25(readOut_1[25], memory[25][31:0], readSel_1);
	mux32 ma26(readOut_1[26], memory[26][31:0], readSel_1);
	mux32 ma27(readOut_1[27], memory[27][31:0], readSel_1);
	mux32 ma28(readOut_1[28], memory[28][31:0], readSel_1);
	mux32 ma29(readOut_1[29], memory[29][31:0], readSel_1);
	mux32 ma30(readOut_1[30], memory[30][31:0], readSel_1);
	mux32 ma31(readOut_1[31], memory[31][31:0], readSel_1);
	
	mux32 mb0 (readOut_2[0],  memory[0][31:0],  readSel_2);
	mux32 mb1 (readOut_2[1],  memory[1][31:0],  readSel_2);
	mux32 mb2 (readOut_2[2],  memory[2][31:0],  readSel_2);
	mux32 mb3 (readOut_2[3],  memory[3][31:0],  readSel_2);
	mux32 mb4 (readOut_2[4],  memory[4][31:0],  readSel_2);
	mux32 mb5 (readOut_2[5],  memory[5][31:0],  readSel_2);
	mux32 mb6 (readOut_2[6],  memory[6][31:0],  readSel_2);
	mux32 mb7 (readOut_2[7],  memory[7][31:0],  readSel_2);
	mux32 mb8 (readOut_2[8],  memory[8][31:0],  readSel_2);
	mux32 mb9 (readOut_2[9],  memory[9][31:0],  readSel_2);
	mux32 mb10(readOut_2[10], memory[10][31:0], readSel_2);
	mux32 mb11(readOut_2[11], memory[11][31:0], readSel_2);
	mux32 mb12(readOut_2[12], memory[12][31:0], readSel_2);
	mux32 mb13(readOut_2[13], memory[13][31:0], readSel_2);
	mux32 mb14(readOut_2[14], memory[14][31:0], readSel_2);
	mux32 mb15(readOut_2[15], memory[15][31:0], readSel_2);
	mux32 mb16(readOut_2[16], memory[16][31:0], readSel_2);
	mux32 mb17(readOut_2[17], memory[17][31:0], readSel_2);
	mux32 mb18(readOut_2[18], memory[18][31:0], readSel_2);
	mux32 mb19(readOut_2[19], memory[19][31:0], readSel_2);
	mux32 mb20(readOut_2[20], memory[20][31:0], readSel_2);
	mux32 mb21(readOut_2[21], memory[21][31:0], readSel_2);
	mux32 mb22(readOut_2[22], memory[22][31:0], readSel_2);
	mux32 mb23(readOut_2[23], memory[23][31:0], readSel_2);
	mux32 mb24(readOut_2[24], memory[24][31:0], readSel_2);
	mux32 mb25(readOut_2[25], memory[25][31:0], readSel_2);
	mux32 mb26(readOut_2[26], memory[26][31:0], readSel_2);
	mux32 mb27(readOut_2[27], memory[27][31:0], readSel_2);
	mux32 mb28(readOut_2[28], memory[28][31:0], readSel_2);
	mux32 mb29(readOut_2[29], memory[29][31:0], readSel_2);
	mux32 mb30(readOut_2[30], memory[30][31:0], readSel_2);
	mux32 mb31(readOut_2[31], memory[31][31:0], readSel_2);
	
	wire [31:0] writeDec, enWriteDec;
	reg [31:0] longWe;
	decoder dec0(writeDec, writeSel); // decoding write select

	and a0(enWriteDec[31:0], writeDec[31:0], longWe);

	integer j;
	always @ (we)
	begin
		for (j = 0; j < 0; j = j + 1)
		begin
			longWe[j] = we;
		end
	end
	
	integer k;
	always @(posedge clock)
	begin		
		for (k = 0; k < 32; k = k + 1)
		begin
			if (longWe[k])
			begin
				memory[k][31:0] <= data[31:0];
			end
		end
	end
	
endmodule

module dFlipFlop(Q, Qbar, D, clock, reset);
	output reg Q, Qbar;
	input D, clock, reset;
	
	wire Dbar, s0, s1;
	
	not n0(Dbar, D);
	
	nand nd0(s0, clock, D);
	nand nd1(s1, clock, Dbar);
	
	nand nd2(Q, Qbar, s0);
	nand nd3(Qbar, Q, s1);

endmodule


module decoder(decode, select);
	output reg [31:0] decode;
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
	output reg D0;
	input  in0, in1;
	input sel0;

	wire nSel, q0, q1;

	not(nSel, sel0);
	and(q0,in1,sel0);
	and(q1,in0,nSel);
	or(D0,q0,q1);

endmodule

 
module mux4(D0, in0, in1, in2, in3, sel0, sel1);
	output reg D0;
	input in0, in1, in2, in3; 
	input sel0, sel1;

	wire q0, q1;

	mux2_1 m0(q0, in0, in1, sel0);
	mux2_1 m1(q1, in2, in3, sel0);
	mux2_1 m (D0, q0, q1, sel1);
 
endmodule


module mux32 (D0, i, sel);
	output reg D0;
	input [31:0] i ;
	input[4:0] sel;

	wire [9:0] v;

	mux4_1 m0(v[0], i[0],  i[1],  i[2],  i[3],  sel[0], sel[1]);
	mux4_1 m1(v[1], i[4],  i[5],  i[6],  i[7],  sel[0], sel[1]);
	mux4_1 m2(v[2], i[8],  i[9],  i[10], i[11], sel[0], sel[1]);
	mux4_1 m3(v[3], i[12], i[13], i[14], i[15], sel[0], sel[1]);
	mux4_1 m4(v[4], i[16], i[17], i[18], i[19], sel[0], sel[1]);
	mux4_1 m5(v[5], i[20], i[21], i[22], i[23], sel[0], sel[1]);
	mux4_1 m6(v[6], i[24], i[25], i[26], i[27], sel[0], sel[1]);
	mux4_1 m7(v[7], i[28], i[29], i[30], i[31], sel[0], sel[1]);

	mux4_1 m8(v[8], v[0], v[1], v[2], v[3], sel[2], sel[3]);
	mux4_1 m9(v[9], v[4], v[5], v[6], v[7], sel[2], sel[3]);

	mux2_1 m10(D0, v[8], v[9], sel[4]);
endmodule
