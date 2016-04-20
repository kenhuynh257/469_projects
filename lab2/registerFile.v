module registerFile (readOut_1, readOut_2, readSel_1, readSel_2, writeSel, data, we, clock);
	output reg [31:0] readOut_1, readOut_2;
	input [4:0] readSel_1, readSel_2, writeSel;
	input [31:0] data;
	input we, clock;
	
	reg [31:0] memory [31:0]; //The structure that contains the data
	
	reg [31:0] writeDec, enWriteDec, longWe;
	decoder dec0(writeDec, writeSel); // decoding write select
	integer j;
	for (j = 0; j < 0; j++)
	begin
		longWe[i] = we;
	end
	and a0(enWriteDec[31:0], writeDec[31:0], longWe);
	
	integer i;
	for (i = 0; i < 32; i++) //Set up read muxing
	begin
		mux32 m0(readOut_1[i], memory[i][31:0], readSel_1);
		mux32 m1(readOut_2[i], memory[i][31:0], readSel_2);
	end
	
	integer k;
	always @(posedge clock)
	begin
		for (k = 0; k < 32; k++)
		begin
			if (longWe[i])
			begin
				memory[31:0][i] <= data[31:0];
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
	and a1 (decode[1],  nSelect[4], nSelect[3], nSelect[2], nSelect[1],  Select[0]);
	and a2 (decode[2],  nSelect[4], nSelect[3], nSelect[2],  Select[1], nSelect[0]);
	and a3 (decode[3],  nSelect[4], nSelect[3], nSelect[2],  Select[1],  Select[0]);
	and a4 (decode[4],  nSelect[4], nSelect[3],  Select[2], nSelect[1], nSelect[0]);
	and a5 (decode[5],  nSelect[4], nSelect[3],  Select[2], nSelect[1],  Select[0]);
	and a6 (decode[6],  nSelect[4], nSelect[3],  Select[2],  Select[1], nSelect[0]);
	and a7 (decode[7],  nSelect[4], nSelect[3],  Select[2],  Select[1],  Select[0]);
	and a8 (decode[8],  nSelect[4],  Select[3], nSelect[2], nSelect[1], nSelect[0]);
	and a9 (decode[9],  nSelect[4],  Select[3], nSelect[2], nSelect[1],  Select[0]);
	and a10(decode[10], nSelect[4],  Select[3], nSelect[2],  Select[1], nSelect[0]);
	and a11(decode[11], nSelect[4],  Select[3], nSelect[2],  Select[1],  Select[0]);
	and a12(decode[12], nSelect[4],  Select[3],  Select[2], nSelect[1], nSelect[0]);
	and a13(decode[13], nSelect[4],  Select[3],  Select[2], nSelect[1],  Select[0]);
	and a14(decode[14], nSelect[4],  Select[3],  Select[2],  Select[1], nSelect[0]);
	and a15(decode[15], nSelect[4],  Select[3],  Select[2],  Select[1],  Select[0]);
	and a16(decode[16],  Select[4], nSelect[3], nSelect[2], nSelect[1], nSelect[0]);
	and a17(decode[17],  Select[4], nSelect[3], nSelect[2], nSelect[1],  Select[0]);
	and a18(decode[18],  Select[4], nSelect[3], nSelect[2],  Select[1], nSelect[0]);
	and a19(decode[19],  Select[4], nSelect[3], nSelect[2],  Select[1],  Select[0]);
	and a20(decode[20],  Select[4], nSelect[3],  Select[2], nSelect[1], nSelect[0]);
	and a21(decode[21],  Select[4], nSelect[3],  Select[2], nSelect[1],  Select[0]);
	and a22(decode[22],  Select[4], nSelect[3],  Select[2],  Select[1], nSelect[0]);
	and a23(decode[23],  Select[4], nSelect[3],  Select[2],  Select[1],  Select[0]);
	and a24(decode[24],  Select[4],  Select[3], nSelect[2], nSelect[1], nSelect[0]);
	and a25(decode[25],  Select[4],  Select[3], nSelect[2], nSelect[1],  Select[0]);
	and a26(decode[26],  Select[4],  Select[3], nSelect[2],  Select[1], nSelect[0]);
	and a27(decode[27],  Select[4],  Select[3], nSelect[2],  Select[1],  Select[0]);
	and a28(decode[28],  Select[4],  Select[3],  Select[2], nSelect[1], nSelect[0]);
	and a29(decode[29],  Select[4],  Select[3],  Select[2], nSelect[1],  Select[0]);
	and a30(decode[30],  Select[4],  Select[3],  Select[2],  Select[1], nSelect[0]);
	and a31(decode[31],  Select[4],  Select[3],  Select[2],  Select[1],  Select[0]);
	
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
